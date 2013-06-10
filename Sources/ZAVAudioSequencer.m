//
//  ZAVAudioSequencer.m
//	ZKit
//
//  Created by Kaz Yoshikawa on 10/20/11.
//  Copyright (c) 2011 Electricwoods LLC. All rights reserved.
//

#import "ZAVAudioSequencer.h"
#import "ZUtils.h"
#import "NSArray+Z.h"

//
//	Global Variables
//

NSString *kSoundDidStartPlaying = @"kSoundDidStartPlaying";
NSString *kSoundDidStopPalying = @"kSoundDidStopPalying";


//
//	ZAudioSegment ()
//

@interface ZAVAudioSegment ()

@property (strong) ZAudioCompletionBlock completion;
@property (assign) BOOL finished;

@end


#pragma mark -

//
//	ZAVAudioSegment
//

@implementation ZAVAudioSegment

@synthesize player;

+ (id)audioSegmentWithFile:(NSString *)file delegate:(id <ZAudioSegmentDelegate>)delegate completion:(ZAudioCompletionBlock)completion;
{
	return [[ZAVAudioSegment alloc] initWithFile:file delegate:delegate completion:completion];
}

- (id)initWithFile:(NSString *)file delegate:(id <ZAudioSegmentDelegate>)delegate completion:(ZAudioCompletionBlock)completion
{
	NSParameterAssert(file);
	NSParameterAssert(delegate);
	NSError *error = nil;
	if ((self = [super init])) {
		self.delegate = delegate;
		self.completion = completion;
		NSURL *fileURL = [NSURL fileURLWithPath:file];
		self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
		ZReportError(error);
		self.player.delegate = self;
		[self.player prepareToPlay];
		self.soundFile = file;
	}
	return self;
}

- (void)dealloc
{
	[self.player stop];
	[self notifyStopPlaying];
	self.player = nil;

	if (self.completion) {
		self.completion(self.finished);
	}
}

#pragma mark -

- (void)notifyStartPlaying
{
	[[NSNotificationCenter defaultCenter] postNotificationName:kSoundDidStartPlaying object:self.soundFile];
}

- (void)notifyStopPlaying
{
	[[NSNotificationCenter defaultCenter] postNotificationName:kSoundDidStopPalying object:self.soundFile];
}

#pragma mark -

- (void)startPlaying
{
#if DEBUG
	NSLog(@"playing: %@", [self.soundFile stringByAbbreviatingWithTildeInPath]);
#endif
	[self.player play];
	[self notifyStartPlaying];
}

- (void)stopPlaying
{
	[self.player stop];
	[self notifyStopPlaying];
}

- (void)pausePlaying
{
	[self.player stop];
	[self notifyStopPlaying];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)aPlayer successfully:(BOOL)flag
{
	if (flag) {
		self.finished = YES;
		[self.delegate audioSegmentDidFinishPlaying:self];
	}
	else {
		[self.delegate audioSegmentDidStopPlaying:self];
	}
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)aPlayer error:(NSError *)error
{
	NSLog(@"Audio encoding error: %@", error);
	[self.delegate audioSegmentDidStopPlaying:self];
}

- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)aPlayer
{
	[self.player pause];
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)aPlayer withFlags:(NSUInteger)flags
{
	if (flags & AVAudioSessionInterruptionFlags_ShouldResume) {
		[self.player play];
	}
	else {
		[self.delegate audioSegmentDidStopPlaying:self];
	}
}

@end


#pragma mark -

//
//	ZAVAudioSequencer ()
//

@interface ZAVAudioSequencer ()

@property (strong) NSMutableArray *sequence;

@end



#pragma mark -

//
//	ZAVAudioSequencer
//

@implementation ZAVAudioSequencer

@synthesize playing;

- (id)init
{
	if ((self = [super init])) {
		self.sequence = [[NSMutableArray alloc] init];
	}
	return self;
}

#pragma mark -

- (void)addSoundFile:(NSString *)file completion:(ZAudioCompletionBlock)completion
{
	[self.sequence addObject:[ZAVAudioSegment audioSegmentWithFile:file delegate:self completion:completion]];
}

- (void)addSoundFile:(NSString *)file
{
	[self.sequence addObject:[ZAVAudioSegment audioSegmentWithFile:file delegate:self completion:nil]];
}

//- (void)removeAll
//{
//	if (self.playing) {
//		[self stopPlaying];
//	}
//
//	[self.sequence removeAllObjects];
//}

- (void)playSoundFile:(NSString *)file completion:(ZAudioCompletionBlock)completion
{
	// stop currently playing sound
//	if (self.playing) {
//		ZAVAudioSegment *segment = [self.sequence firstObject];
//		[segment stopPlaying];
//	}
	[self stopPlaying];

	// prepare playing sound
	[self addSoundFile:file completion:completion];
	[self startPlaying];
}

- (void)playSoundFiles:(NSArray *)files completion:(ZAudioCompletionBlock)completion
{
	// stop currently playing sound
//	if (self.playing) {
//		ZAVAudioSegment *segment = [self.sequence firstObject];
//		[segment stopPlaying];
//	}
	[self stopPlaying];

	// prepare playing sound
	NSString *lastFile = [files lastObject];
	for (NSString *file in files) {
		if (file == lastFile) {
			[self addSoundFile:file completion:completion];
		}
		else {
			[self addSoundFile:file];
		}
	}
	[self startPlaying];

}

#pragma mark -

- (void)startPlaying
{
//	if (!self.playing) {
	ZAVAudioSegment *segment = [self.sequence firstObject];
	[segment startPlaying];
	self.playing = YES;
//	}
}

- (void)stopPlaying
{
	ZAVAudioSegment *segment = [self.sequence firstObject];
	[segment stopPlaying];
	[self.sequence removeAllObjects];
	self.playing = NO;
}

- (void)pausePlaying
{
	// What's the difference between stop and pause?
	// paused audio will start playing back again when resume,
	// on the other hand, stopped audio will not play back again when resume

	if (self.playing) {
		ZAVAudioSegment *segment = [self.sequence firstObject];
		[segment stopPlaying];
		// isPlaying = NO;		// do not set isPlaying to NO
	}
}

- (void)resumePlaying
{
	if (self.playing) {
		ZAVAudioSegment *segment = [self.sequence firstObject];
		[segment startPlaying];
	}
}

#pragma mark -

- (void)audioSegmentDidFinishPlaying:(ZAVAudioSegment *)segment
{
	[self.sequence removeObject:segment];

	ZAVAudioSegment *nextSegment = [self.sequence firstObject];
	if (nextSegment) {
		[nextSegment startPlaying];
	}
	else {
		self.playing = NO;
	}
}

- (void)audioSegmentDidStopPlaying:(ZAVAudioSegment *)segment
{
	self.playing = NO;
}

@end
