//
//  VCAssetReader.h
//  VideoCodecKit
//
//  Created by CmST0us on 2020/1/27.
//  Copyright © 2020 eric3u. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>
#import "HVCSampleBuffer.h"

NS_ASSUME_NONNULL_BEGIN

@class VCAssetReader;

@protocol VCAssetReaderDelegate <NSObject>
- (void)reader:(VCAssetReader *)reader didGetVideoFormatDescription:(CMFormatDescriptionRef)formatDescription;
- (void)reader:(VCAssetReader *)reader didGetVideoSampleBuffer:(HVCSampleBuffer *)sampleBuffer;
- (void)reader:(VCAssetReader *)reader didGetAudioFormatDescription:(CMFormatDescriptionRef)formatDescription;
- (void)reader:(VCAssetReader *)reader didGetAudioSampleBuffer:(HVCSampleBuffer *)sampleBuffer;
- (void)readerDidReachEOF:(VCAssetReader *)reader;
@end

@interface VCAssetReader : NSObject {
@protected
    CMFormatDescriptionRef _videoFormatDescription;
    CMFormatDescriptionRef _audioFormatDescription; 
}

@property (nonatomic, weak) id<VCAssetReaderDelegate> delegate;

@property (nonatomic, readonly) CMFormatDescriptionRef videoFormatDescription;
@property (nonatomic, readonly) CMFormatDescriptionRef audioFormatDescription;

- (void)startReading;
- (void)stopReading;

@end

NS_ASSUME_NONNULL_END
