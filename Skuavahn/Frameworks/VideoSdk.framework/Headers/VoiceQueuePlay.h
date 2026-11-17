//
//  AudioQueuePlay.h
//
//
//  Created by Johnny on 2017/12/12.
//  Copyright © 2017年 Johnny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface VoiceQueuePlay : NSObject

// 播放并顺带附上数据
- (void)playWithData: (NSData *)data;
//重新播放
- (void)resetPlay;
//关闭播放，释放
- (void)PlayDealloc;
@end
