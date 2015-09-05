//
//  AudioSignalGenerator.m
//  FSK Terminal
//
//  Created by George Dean on 1/6/09.
//  Copyright 2009 Perceptive Development. All rights reserved.
//
//  Edited by Ezequiel Franca on 20/04/14

#include <AudioToolbox/AudioToolbox.h>
#import "AudioQueueObject.h"
#import "AudioSignalGenerator.h"

#define kAudioFilePath @"Recording.m4a"



static void playbackCallback (
							  void					*inUserData,
							  AudioQueueRef			inAudioQueue,
							  AudioQueueBufferRef		bufferReference
) {
    
	// This is not a Cocoa thread, it needs a manually allocated pool
//    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	// This callback, being outside the implementation block, needs a reference to the AudioSignalGenerator object
	AudioSignalGenerator *player = (__bridge AudioSignalGenerator *) inUserData;
	if ([player stopped]) return;
    if ([player allocatedBuffers]) {
    [player.recorder appendDataFromBufferList:bufferReference->mAudioData
                               withBufferSize:bufferReference->mAudioDataBytesCapacity];
    }f  23
	[player fillBuffer:bufferReference->mAudioData];

	bufferReference->mAudioDataByteSize = player.bufferByteSize;
    AudioQueueEnqueueBuffer (
								 inAudioQueue,
								 bufferReference,
								 player.bufferPacketCount,
								 player.packetDescriptions
								 );
   


//	[pool release];
}


@implementation AudioSignalGenerator 

@synthesize packetDescriptions;
@synthesize bufferByteSize;
@synthesize bufferPacketCount;
@synthesize stopped;
@synthesize allocatedBuffers;
@synthesize audioPlayerShouldStopImmediately;


- (void) recordBufferData: (void *) buffer {
    
    
}
- (NSURL *)testFilePathURL
{
    NSLog(@" Recording to %@", [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",
                                         [self applicationDocumentsDirectory],
                                                       kAudioFilePath]] );
    return [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",
                                   [self applicationDocumentsDirectory],
                                   kAudioFilePath]];
}
- (NSArray *)applicationDocuments
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
}

- (NSString *)applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}
- (id) init {

	self = [super init];

	if (self != nil) {
		[self setupAudioFormat];
		[self setupPlaybackAudioQueueObject];
		self.stopped = NO;
		self.audioPlayerShouldStopImmediately = NO;
        
        
       // self.microphone = [EZMicrophone microphoneWithDelegate:self];
        NSArray *inputs = [EZAudioDevice inputDevices];
        [self.microphone setDevice:[inputs objectAtIndex:0]];
        self.recorder = [EZRecorder recorderWithURL:[self testFilePathURL]
                                       clientFormat:audioFormat
                                           fileType:EZRecorderFileTypeM4A
                                           delegate:self];
        
      
	}

	return self;
}

- (void) setupAudioFormat {
}

- (void) fillBuffer: (void*) buffer
{
}

- (void) setupPlaybackAudioQueueObject {

	// create the playback audio queue object
	AudioQueueNewOutput (
						 &audioFormat,
						 playbackCallback,
						 (__bridge void *)(self),
						 nil,
						 nil,
						 0,								// run loop flags
						 &queueObject
						 );

	AudioQueueSetParameter (
							queueObject,
							kAudioQueueParam_Volume,
							1.0f
							);

}

- (void) setupAudioQueueBuffers {

	// prime the queue with some data before starting
	// allocate and enqueue buffers
	int bufferIndex;

	for (bufferIndex = 0; bufferIndex < 3; ++bufferIndex) {

		AudioQueueAllocateBuffer (
								  [self queueObject],
								  [self bufferByteSize],
								  &buffers[bufferIndex]
								  );

		playbackCallback (
						  (__bridge void *)(self),
						  [self queueObject],
						  buffers[bufferIndex]
						  );

		if ([self stopped]) break;
        
	}
    self.allocatedBuffers = true;
}


- (void) play {

	[self setupAudioQueueBuffers];

	AudioQueueStart (
					 self.queueObject,
					 NULL			// start time. NULL means ASAP.
					 );
}

- (void) stop {

	AudioQueueStop (
					self.queueObject,
					self.audioPlayerShouldStopImmediately
					);

}


- (void) pause {

	AudioQueuePause (
					 self.queueObject
					 );
}


- (void) resume {

	AudioQueueStart (
					 self.queueObject,
					 NULL			// start time. NULL means ASAP
					 );
}

@end
