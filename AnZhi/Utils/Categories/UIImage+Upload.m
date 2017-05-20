//
//  AppDelegate.h
//  AnZhi
//
//  Created by LHJ on 2017/5/18.
//  Copyright © 2017年 AnZhi. All rights reserved.
//

#import "UIImage+Upload.h"
#import <objc/runtime.h>

static const void * PhotoUrlKey = &PhotoUrlKey;
static const void * UploadFinishedKey = &UploadFinishedKey;

@implementation UIImage (Upload)
@dynamic photoUrl;
@dynamic uploadFinished;

- (NSString *)photoUrl {
    return objc_getAssociatedObject(self, PhotoUrlKey);
}

- (void)setPhotoUrl:(NSString *)photoUrl {
    objc_setAssociatedObject(self, PhotoUrlKey, photoUrl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)uploadFinished {
    return [objc_getAssociatedObject(self, UploadFinishedKey) boolValue];
}

- (void)setUploadFinished:(BOOL)uploadFinished {
    objc_setAssociatedObject(self, UploadFinishedKey, @(uploadFinished), OBJC_ASSOCIATION_ASSIGN);
}

@end
