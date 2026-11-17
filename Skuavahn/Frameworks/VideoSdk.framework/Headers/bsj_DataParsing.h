//
//  bsj_DataParsing.h
//  视频SDK
//
//  Created by Johnny on 2018/7/23.
//  Copyright © 2018年 Johnny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "bsj_H264HwDecoderImpl.h"
#import "YSTAudioUnit.h"
#import "BodyType.h"
@protocol voiceDelegate
- (void)voiceDisconnect:(NSString *)err;//type链路类型，closetype1主动断开或被动断开0
- (void)pushaudioUnitPcm:(NSData *)data;//pcm数据
-(void)pushVideoTime:(unsigned long long)framePresntTime;
@end

@interface bsj_DataParsing : NSObject <AudioUnitDelegate>
@property (strong , nonatomic) bsj_H264HwDecoderImpl * h264;
@property (assign , nonatomic) BOOL ISNeedToVoice;//是否需要声音
@property (weak, nonatomic) id<voiceDelegate>voiceDelegate;
@property (assign, nonatomic) CFAbsoluteTime start;

/*
 data：设备返回的原始视频或声频数据
 DeviceType:设备类型  （0：表示GA系列 1：表示GF—1078 2：表示GPRS-部标（不能播放））
 DataType:数据类型（0：表示实时视频  1：表示回放视频）
 */
- (void)PushWithData:(NSData *)Data DeviceType:(int)DeviceType DataType:(int)DataType;
/*
 关闭声音播放
 */
- (void)CloseVoice;
/*
 关闭视频播放
 */
- (void)CloseVideo;
@end
