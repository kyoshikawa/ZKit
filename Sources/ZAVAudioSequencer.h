//
//  ZAVAudioSequencer.h
//	ZKit
//
//  Created by Kaz Yoshikawa on 10/20/11.
//  Copyright (c) 2011 Electricwoods LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@class ZAVAudioSegment;

typedef void (^ZAudioCompletionBlock)(BOOL finished);
extern NSString *kSoundDidStartPlaying;
extern NSString *kSoundDidStopPalying;

//
//	ZAVAudioSegmentDelegate
//
@protocol ZAudioSegmentDelegate <NSObject>
- (void)audioSegmentDidFinishPlaying:(ZAVAudioSegment *)segment;		// it came to the end of audio
- (void)audioSegmentDidStopPlaying:(ZAVAudioSegment *)segment;		// somehow, stopped - could be an error
@end

#pragma mark -

//
//	ZAVAudioSegment
//
@interface ZAVAudioSegment : NSObject <AVAudioPlayerDelegate>

@property (weak) id <ZAudioSegmentDelegate> delegate;
@property (retain) AVAudioPlayer *player;
@property (retain) NSString *soundFile;


+ (id)audioSegmentWithFile:(NSString *)file delegate:(id <ZAudioSegmentDelegate>)delegate completion:(ZAudioCompletionBlock)completion;
- (id)initWithFile:(NSString *)file delegate:(id <ZAudioSegmentDelegate>)delegate completion:(ZAudioCompletionBlock)completion;

@end

#pragma mark -

//
//	ZAVAudioSequencer
//
@interface ZAVAudioSequencer : NSObject <ZAudioSegmentDelegate>

@property (assign) BOOL playing;

- (void)addSoundFile:(NSString *)file;
- (void)addSoundFile:(NSString *)file completion:(ZAudioCompletionBlock)completion;
- (void)playSoundFile:(NSString *)file completion:(ZAudioCompletionBlock)completion;
- (void)playSoundFiles:(NSArray *)files completion:(ZAudioCompletionBlock)completion;
- (void)startPlaying;
- (void)stopPlaying;
- (void)pausePlaying;
- (void)resumePlaying;

@end
