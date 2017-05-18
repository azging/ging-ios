//
//  RecordAudio.m
//  JuuJuu
//
//  Created by xiaoguang huang on 11-12-19.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "RecordAudio.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "amrFileCodec.h"
#import "AZStringUtil.h"

@interface RecordAudio ()

@property (strong, nonatomic) NSData *playingData;

@end

@implementation RecordAudio


- (void)dealloc {
	recorder = nil;
	recordedTmpFile = nil;
    [avPlayer stop];
    avPlayer = nil;
}

- (id)init {
    self = [super init];
    if (self) {
        //Instanciate an instance of the AVAudioSession object.
        AVAudioSession * audioSession = [AVAudioSession sharedInstance];
        //Setup the audioSession for playback and record. 
        //We could just use record and then switch it to playback leter, but
        //since we are going to do both lets set it up once.
        NSError *error = nil;
        [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error: &error];
        
        UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
        AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,
								 sizeof (audioRouteOverride),
								 &audioRouteOverride);
        
        //Activate the session
        [audioSession setActive:YES error: &error];
    }
    return self;
}

- (NSURL *)stopRecord {
    NSURL *url = [[NSURL alloc] initWithString:recorder.url.absoluteString];
    [recorder stop];
    recorder =nil;
    return url;
}

+ (NSTimeInterval)getAudioTime:(NSData *)data {
    NSError * error;
    AVAudioPlayer*play = [[AVAudioPlayer alloc] initWithData:data error:&error];
    NSTimeInterval n = [play duration];
    return n;
}

+ (NSData *)getDataFromString:(NSString *)string{
    if ([AZStringUtil isNullString:string]) {
        return nil;
    }
    
    return [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
}

+ (NSString *)getStringFromData:(NSData *)data{
    if (!data) {
        return nil;
    }
    
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)getCurrentPlayingString {
    if (self.playingData) {
        return [RecordAudio getStringFromData:self.playingData];
    }
    return @"";
}

- (void)sendStatus:(RecordAudioPlayStatus)status {
    self.status = status;
    if (self.delegate && [self.delegate respondsToSelector:@selector(recordAudioPlayStatusChanged:)]) {
        [self.delegate recordAudioPlayStatusChanged:status];
    }
    
    if (status!= RecordAudioPlayStatus_Playing) {
        self.playingData = nil;
        if (avPlayer!=nil) {
            [avPlayer stop];
            avPlayer = nil;
        }
    }
}

- (void)stopPlay {
    if (avPlayer!=nil) {
        [avPlayer stop];
        avPlayer = nil;
        [self sendStatus:RecordAudioPlayStatus_Finish];
    }
}

- (NSData *)decodeAmr:(NSData *)data {
    if (!data) {
        return data;
    }

    return DecodeAMRToWAVE(data);
}

- (void)play:(NSData *)data {
	//Setup the AVAudioPlayer to play the file that we just recorded.
    //在播放时，只停止
    if (avPlayer!=nil) {
        [self stopPlay];
        return;
    }
    self.playingData = data;
    NSLog(@"start decode");
    NSError *error = nil;
    NSData* o = [self decodeAmr:data];
    NSLog(@"end decode");
    avPlayer = [[AVAudioPlayer alloc] initWithData:o error:&error];
    avPlayer.delegate = self;
	[avPlayer prepareToPlay];
    [avPlayer setVolume:1.0];
	if(![avPlayer play]){
        [self sendStatus:RecordAudioPlayStatus_Finish];
    } else {
        [self sendStatus:RecordAudioPlayStatus_Playing];
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    [self sendStatus:RecordAudioPlayStatus_Finish];
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
    [self sendStatus:RecordAudioPlayStatus_Failure];
}

- (void)startRecord {
    //Begin the recording session.
    //Error handling removed.  Please add to your own code.
    
    //Setup the dictionary object with all the recording settings that this 
    //Recording sessoin will use
    //Its not clear to me which of these are required and which are the bare minimum.
    //This is a good resource: http://www.totodotnet.net/tag/avaudiorecorder/
    //		NSMutableDictionary* recordSetting = [[NSMutableDictionary alloc] init];
    //		[recordSetting setValue :[NSNumber numberWithInt:kAudioFormatAppleIMA4] forKey:AVFormatIDKey];
    //		[recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey]; 
    //		[recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
    
//    NSDictionary *recordSetting =
//    [[NSDictionary alloc] initWithObjectsAndKeys:
//     
//     [NSNumber numberWithFloat:8000.00], AVSampleRateKey,
//     
//     [NSNumber numberWithInt:kAudioFormatiLBC], AVFormatIDKey,
//     
//     [NSNumber numberWithInt:1], AVNumberOfChannelsKey,
//     
//     [NSNumber numberWithInt:AVAudioQualityMax], AVEncoderAudioQualityKey,
//     
//     nil];
    
        NSDictionary *recordSetting = [NSDictionary dictionaryWithObjectsAndKeys:
                                       [NSNumber numberWithInt:kAudioFormatLinearPCM], AVFormatIDKey, 
                                       //[NSNumber numberWithFloat:44100.0], AVSampleRateKey,
                                       [NSNumber numberWithFloat:8000.00], AVSampleRateKey,
                                       [NSNumber numberWithInt:1], AVNumberOfChannelsKey,
                                       //  [NSData dataWithBytes:&channelLayout length:sizeof(AudioChannelLayout)], AVChannelLayoutKey,
                                       [NSNumber numberWithInt:16], AVLinearPCMBitDepthKey,
                                       [NSNumber numberWithBool:NO], AVLinearPCMIsNonInterleaved,
                                       [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,
                                       [NSNumber numberWithBool:NO], AVLinearPCMIsBigEndianKey,
                                       nil];
    
    //Now that we have our settings we are going to instanciate an instance of our recorder instance.
    //Generate a temp file for use by the recording.
    //This sample was one I found online and seems to be a good choice for making a tmp file that
    //will not overwrite an existing one.
    //I know this is a mess of collapsed things into 1 call.  I can break it out if need be.
    recordedTmpFile = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: [NSString stringWithFormat: @"%.0f.%@", [NSDate timeIntervalSinceReferenceDate] * 1000.0, @"caf"]]];
    NSLog(@"Using File called: %@",recordedTmpFile);

    NSError *error = nil;
    //Setup the recorder to use this file and record to it.
    recorder = [[ AVAudioRecorder alloc] initWithURL:recordedTmpFile settings:recordSetting error:&error];
    NSLog(@"1");
    //Use the recorder to start the recording.
    //Im not sure why we set the delegate to self yet.  
    //Found this in antother example, but Im fuzzy on this still.
    [recorder setDelegate:self];
    //We call this to start the recording process and initialize 
    //the subsstems so that when we actually say "record" it starts right away.
    [recorder prepareToRecord];
    NSLog(@"2");
    //Start the actual Recording
    [recorder record];
    NSLog(@"3");
    //There is an optional method for doing the recording for a limited time see 
    //[recorder recordForDuration:(NSTimeInterval) 10]
}

@end
