//
//  AudioQueuePlayTool.h
//  博实结运维宝
//
//  Created by Johnny on 2017/12/12.
//  Copyright © 2017年 Johnny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface AudioQueuePlayTool : NSObject
// 播放并顺带附上数据
- (void)playWithData: (NSData *)data;
//- (void)start;//开始
- (void)end;//结束
// reset
- (void)resetPlay;

@end
