//
//  AZRegisterVC.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZDetailPhotoView.h"
#import "AZUtil.h"
#import "UIImageView+AFNetworking.h"
#import "AZConstant.h"

#define kMaxZoom 3.0

@interface AZDetailPhotoView()

@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) BOOL isTwiceTaping;
@property (assign, nonatomic) BOOL isDoubleTapingForZoom;
@property (assign, nonatomic) CGFloat currentScale;
@property (assign, nonatomic) CGFloat offsetY;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (assign, nonatomic) CGFloat touchX;
@property (assign, nonatomic) CGFloat touchY;

@property (strong, nonatomic) AZImageModel *imageModel;

@end

@implementation AZDetailPhotoView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _width = [AZAppUtil getDeviceWidth];
        _height = [AZAppUtil getDeviceHeight];
        
        self.frame = CGRectMake(0, 0, [AZAppUtil getDeviceWidth], [AZAppUtil getDeviceHeight]);
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 0.0;
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [AZAppUtil getDeviceWidth], [AZAppUtil getDeviceHeight])];
        [self addSubview:_scrollView];
        _scrollView.delegate = self;
        _scrollView.maximumZoomScale = 5.0;
        _scrollView.showsVerticalScrollIndicator = FALSE;
        _scrollView.showsHorizontalScrollIndicator = FALSE;
        CGFloat ratio = _width/_height*[AZAppUtil getDeviceHeight]/[AZAppUtil getDeviceWidth];
        CGFloat min = MIN(ratio, 1.0);
        _scrollView.minimumZoomScale = min;
        
        CGFloat height = _height /_width * [AZAppUtil getDeviceWidth];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_scrollView.contentOffset.x+100, _scrollView.contentOffset.y+230, 10, 10)];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        CGFloat y = ([AZAppUtil getDeviceHeight] - height)/2.0;
        _offsetY = 0.0-y;
        _scrollView.contentSize = CGSizeMake([AZAppUtil getDeviceWidth], height);
        [_scrollView addSubview:_imageView];
        _scrollView.contentOffset = CGPointMake(0, 0.0-y);

        
        self.imageView.multipleTouchEnabled = YES;
        self.imageView.userInteractionEnabled = YES;
        
        [UIView animateWithDuration:0.6 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            _imageView.frame = CGRectMake(0, 0, [AZAppUtil getDeviceWidth], height);
            self.alpha = 1.0;
        }completion:^(BOOL finished) {
        }];

        UITapGestureRecognizer *tapImgView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImgViewHandle)];
        tapImgView.numberOfTapsRequired = 1;
        tapImgView.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tapImgView];
        
        UITapGestureRecognizer *tapImgViewTwice = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImgViewHandleTwice:)];
        tapImgViewTwice.numberOfTapsRequired = 2;
        tapImgViewTwice.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tapImgViewTwice];
        [tapImgView requireGestureRecognizerToFail:tapImgViewTwice];
    }
    return self;
}

- (void)updateImageView:(AZImageModel *)imageModel {
    _imageModel =imageModel;
    if (self.imageSource == nil) {
        [AZViewUtil updateImageView:self.imageView imageUrl:imageModel.imageUrl imageThumbUrl:imageModel.imageUrlThumb placeholderImageName:AZDefaultCoverImageName];
    } else {
        [self.imageView setImage:self.imageSource];
    }
}

#pragma mark - UIscrollViewDelegate zoom

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    _currentScale = scale;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    //当捏或移动时，需要对center重新定义以达到正确显示未知
    CGFloat xcenter = scrollView.center.x,ycenter = scrollView.center.y;
    xcenter = scrollView.contentSize.width > scrollView.frame.size.width?scrollView.contentSize.width/2 :xcenter;
    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ?scrollView.contentSize.height/2 : ycenter;
    //双击放大时，图片不能越界，否则会出现空白。因此需要对边界值进行限制。
    if(_isDoubleTapingForZoom){
        xcenter = kMaxZoom*([AZAppUtil getDeviceWidth] - _touchX);
        ycenter = kMaxZoom*([AZAppUtil getDeviceHeight] - _touchY);
        if(xcenter > (kMaxZoom - 0.5)*[AZAppUtil getDeviceWidth]){//放大后左边超界
            xcenter = (kMaxZoom - 0.5)*[AZAppUtil getDeviceWidth];
        }else if(xcenter <0.5*[AZAppUtil getDeviceWidth]){//放大后右边超界
            xcenter = 0.5*[AZAppUtil getDeviceWidth];
        }
        if(ycenter > (kMaxZoom - 0.5)*[AZAppUtil getDeviceHeight]){//放大后左边超界
            ycenter = (kMaxZoom - 0.5)*[AZAppUtil getDeviceHeight] +_offsetY*kMaxZoom;
        }else if(ycenter <0.5*[AZAppUtil getDeviceHeight]){//放大后右边超界
            ycenter = 0.5*[AZAppUtil getDeviceHeight] +_offsetY*kMaxZoom;
        }
    }
    [_imageView setCenter:CGPointMake(xcenter, ycenter)];
}

#pragma mark - tap
- (void)tapImgViewHandle {
    if(!_isTwiceTaping){
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationCommonPhotoShowVCQuit object:nil];
    }
}

- (void)restoreInitState {
    [_scrollView setZoomScale:1.0 animated:YES];
}

- (UIImage *)getDetailViewImage {
    return self.imageView.image;
}

- (AZImageModel *)getDetailViewImageModel {
    return self.imageModel;
}

-(IBAction)tapImgViewHandleTwice:(UIGestureRecognizer *)sender{
    _touchX = [sender locationInView:sender.view].x;
    _touchY = [sender locationInView:sender.view].y;
    if(_isTwiceTaping){
        return;
    }
    _isTwiceTaping = YES;
    
    if(_currentScale > 1.0){
        _currentScale = 1.0;
        [_scrollView setZoomScale:1.0 animated:YES];
    }else{
        _isDoubleTapingForZoom = YES;
        _currentScale = kMaxZoom;
        [_scrollView setZoomScale:kMaxZoom animated:YES];
    }
    _isDoubleTapingForZoom = NO;
    //延时做标记判断，使用户点击3次时的单击效果不生效。
    [self performSelector:@selector(twiceTaping) withObject:nil afterDelay:0.8];
}

- (void)twiceTaping{
    _isTwiceTaping = NO;
}

@end
