//
//  RecordAudio.h
//  JuuJuu
//
//  Created by xiaoguang huang on 11-12-19.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import "amrFileCodec.h"

typedef enum : NSInteger {
    RecordAudioPlayStatus_Playing       = 0,
    RecordAudioPlayStatus_Finish        = 1,
    RecordAudioPlayStatus_Failure       = 2,
} RecordAudioPlayStatus;

@protocol RecordAudioDelegate <NSObject>
- (void)recordAudioPlayStatusChanged:(RecordAudioPlayStatus)status;
@end

@interface RecordAudio : NSObject <AVAudioRecorderDelegate,AVAudioPlayerDelegate>
{
	NSURL *recordedTmpFile;
	AVAudioRecorder *recorder;
    AVAudioPlayer *avPlayer;
}
@property (nonatomic, assign) RecordAudioPlayStatus status;
@property (nonatomic, assign) id<RecordAudioDelegate> delegate;

- (NSURL *)stopRecord;
- (void)startRecord;

- (void)play:(NSData *)data;
- (void)stopPlay;

+ (NSTimeInterval)getAudioTime:(NSData *)data;
+ (NSString *)getStringFromData:(NSData *)data;
+ (NSData *)getDataFromString:(NSString *)string;

- (NSString *)getCurrentPlayingString;
@end
