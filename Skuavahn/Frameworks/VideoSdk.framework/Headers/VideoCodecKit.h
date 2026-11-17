//
//  VideoCodecKit.h
//  VideoCodecKit
//
//  Created by CmST0us on 2018/10/1.
//  Copyright © 2018年 eric3u. All rights reserved.
//
#if TARGET_OS_IOS
#import <UIKit/UIKit.h>

//! Project version number for VideoCodecKit.
FOUNDATION_EXPORT double VideoCodecKitVersionNumber;

//! Project version string for VideoCodecKit.
FOUNDATION_EXPORT const unsigned char VideoCodecKitVersionString[];
#endif

#import "VCByteArray.h"
//#import "HVCSafeObjectQueue.h"

#import "VCAnnexBFormatStream.h"
#import "VCAnnexBFormatParser.h"
#import "VCAVCFormatStream.h"
//#import "VCAVCConfigurationRecord.h"
//#import "VCAudioSpecificConfig.h"
#import "VCH264NALU.h"

#import "VCAssetReader.h"

#import "VCRawH264Reader.h"
#import "VCRawH265Reader.h"

#import "VCVideoDecoder.h"
#import "VCVideoEncoder.h"
#import "VCH264HardwareEncoder.h"
#import "VCH264HardwareDecoder.h"
#import "VCH265HardwareDecoder.h"

#import "VCMicRecorder.h"
