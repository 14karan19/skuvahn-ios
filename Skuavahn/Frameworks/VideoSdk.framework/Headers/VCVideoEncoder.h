//
//  VCVideoEncoder.h
//  VideoCodecKit
//
//  Created by CmST0us on 2019/1/19.
//  Copyright © 2019 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class HVCSampleBuffer;
@protocol VCVideoEncoder <NSObject>
@required
- (OSStatus)encodeSampleBuffer:(HVCSampleBuffer *)sampleBuffer;
@end

@protocol VCVideoEncoderDelegate <NSObject>
- (void)videoEncoder:(id<VCVideoEncoder>)encoder didOutputSampleBuffer:(HVCSampleBuffer *)sampleBuffer;
- (void)videoEncoder:(id<VCVideoEncoder>)encoder didOutputFormatDescription:(CMFormatDescriptionRef)description;
@end

NS_ASSUME_NONNULL_END
