//
//  AppDelegate.h
//  AnZhi
//
//  Created by Mr.Positive on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "AZSearchBar.h"
//#import "UIImage+Create.h"

@implementation AZSearchBar

- (void)setup {
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subview removeFromSuperview];
            break;
        }
        for (UIView *subsubview in subview.subviews) {
            if ([subsubview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                [subsubview removeFromSuperview];
                break;
            }
        }
    }
    
    self.translucent = YES;
    
    self.tintColor = [UIColor colorWithRed:((float)((0x2c2a28 & 0xFF0000) >> 16))/255.0 green:((float)((0x2c2a28 & 0xFF00) >> 8))/255.0 blue:((float)(0x2c2a28 & 0xFF))/255.0 alpha:1.0f];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setSearchTextFieldBackgroundColor:(UIColor *)backgroundColor {
    UIView *searchTextField = nil;
    [self setBackgroundColor:[UIColor whiteColor]];
    self.barTintColor = [UIColor whiteColor];
    searchTextField = [[[self.subviews firstObject] subviews] lastObject];
    searchTextField.backgroundColor = backgroundColor;
    
    
}

- (void)setSearchTextFieldCornerRadius:(CGFloat)cornerRadius {
    UIView *searchTextField = nil;
    [self setBackgroundColor:[UIColor whiteColor]];
    self.barTintColor = [UIColor whiteColor];
    searchTextField = [[[self.subviews firstObject] subviews] lastObject];
    searchTextField.layer.cornerRadius = cornerRadius;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
