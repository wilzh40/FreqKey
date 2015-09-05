//
//  AudioDemo.h
//  FSK-Demo
//
//  Created by Ezequiel Franca dos Santos on 20/04/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "EZAudio.h"
#import "FSKRecognizer.h"

#import "CharReceiver.h"

@class AudioSignalAnalyzer, FSKSerialGenerator;

@interface AudioDemo : NSObject <AVAudioSessionDelegate, CharReceiver>{
    char local_input;
}
@property (strong, nonatomic) AudioSignalAnalyzer* analyzer;
@property (strong, nonatomic) FSKRecognizer* recognizer;

@property (strong, nonatomic) FSKSerialGenerator* generator;
@property (nonatomic, strong) EZRecorder *recorder;
@property (nonatomic, strong) EZMicrophone *microphone;


@property (readwrite) NSMutableString *decodedText;
+ (id)shared;

- (void)signalArduino:(BOOL)on;
- (char)returnChar;
@end