//
//  H264HwDecoderImpl.h
//  ShiPinHuiYi
//
//  Created by 徐杨 on 16/3/31.
//  Copyright (c) 2016年 feiyuxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VideoToolbox/VideoToolbox.h>
#import <AVFoundation/AVSampleBufferDisplayLayer.h>
#import "BodyType.h"

@protocol H264HwDecoderImplDelegate <NSObject>

- (void)displayDecodedFrame:(CVImageBufferRef )imageBuffer;

- (void)pushData:(Byte *)buffer lenght:(int)leng BodyTypeFor:(BodyType *)model;

@end

@interface bsj_H264HwDecoderImpl : NSObject
@property (weak, nonatomic) id<H264HwDecoderImplDelegate> delegate;
@property (assign, nonatomic) VTDecompressionSessionRef deocderSession;
/*开始播放，传入数据*/
-(void)decodeNalu:(uint8_t *)frame withSize:(uint32_t)frameSize BodyTypeFor:(BodyType *)model;
/*关闭播放*/
-(void)closePlay;
/*释放*/
-(void)DeallocH264Deocder;
@property (assign, nonatomic) BOOL isPlayToImage;

@property (assign, nonatomic) BOOL initH264DecoderTrue;

@property (assign, nonatomic) CFAbsoluteTime start;
 

@end
