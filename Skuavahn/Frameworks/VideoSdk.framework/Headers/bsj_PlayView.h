//
//  bsj_PlayView.h
//  视频SDK
//
//  Created by Johnny on 2018/7/20.
//  Copyright © 2018年 Johnny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "bsj_DataParsing.h"
#import "bsj_H264HwDecoderImpl.h"
#import "AAPLEAGLLayer.h"
#import "OCGQueue.h"
@protocol bsj_DecodingDataDelegate

/*
 解码成功的回调
 */
- (void)PLaySuccess:(NSString *)Success;

@end


@interface bsj_PlayView : UIView <H264HwDecoderImplDelegate>
@property (nonatomic, strong) AVSampleBufferDisplayLayer *displayLayer;
@property (strong, nonatomic) UIImageView *PlayImage;
@property (strong, nonatomic) OCGQueue *imageQueue;


@property (weak, nonatomic) id<bsj_DecodingDataDelegate> DecodingDataDelegate;

@property (strong, nonatomic) bsj_H264HwDecoderImpl *h264;
@property (strong, nonatomic) bsj_DataParsing *dataParsing;
- (void)reset;
//清空图像
-(void)newPlay;

//开始播放图片
-(void)startPlayImagesByCheckingCacheQueue;
//结束播放图片
- (void)endPlayImages;

 
@end
