//
//  YSTAudioUnitTool.h


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

#ifndef max
#define max( a, b ) ( ((a) > (b)) ? (a) : (b) )
#endif

#ifndef min
#define min( a, b ) ( ((a) < (b)) ? (a) : (b) )
#endif


@protocol AudioUnitToolDelegate <NSObject>
- (void)audioUnitPcm:(NSData *)data;//pcm数据
- (void)audioUnitBuffer:(AudioBufferList *)bufferList;//bufferlist
@end

@interface YSTAudioUnitTool : NSObject {
	AudioComponentInstance audioUnit;
	AudioBuffer tempBuffer; // this will hold the latest data from the microphone
}

typedef void (^XBEchoCancellation_outputBlock)(AudioBufferList *bufferList,UInt32 inNumberFrames);
///播放的回调，回调的参数 buffer 为要向播放设备（扬声器、耳机、听筒等）传的数据，在回调里把数据传给 buffer
@property (nonatomic, copy) XBEchoCancellation_outputBlock bl_output;

@property (nonatomic, weak)id<AudioUnitToolDelegate>delegate;
@property (readonly) AudioComponentInstance audioUnit;
@property (readonly) AudioBuffer tempBuffer;

@property (assign, nonatomic) char * PCMBuffer;//保存的数据
@property (strong, nonatomic) NSLock *sysnLock;
@property (assign, nonatomic) long PCMLength;
@property (assign, nonatomic) long PCMReadLength;
@property (assign, nonatomic) long PCMSumLength;
@property (strong, nonatomic) NSMutableData *mIn;

@property (assign, nonatomic) long pcmLength;
@property (assign, nonatomic) long pcmsubLength;

@property (assign, nonatomic) long pcmRead;
@property (assign, nonatomic) long pcmWrit;
@property (assign, nonatomic) long pcmUnWrit;

@property (assign, nonatomic) BOOL isConsistent;

@property (strong, nonatomic) NSMutableArray * pcmArr;

- (void) start:(BOOL)isIntercom;
- (void) stop;
- (void) remove;
- (void) processAudio: (AudioBufferList*) bufferList;

- (void) plyaAudio: (Byte *) pcm length:(int)size;

- (void)audioUnitStartRecordAndPlay;
- (void)audioUnitStop;
@end

extern YSTAudioUnitTool* ystAudioTool;
