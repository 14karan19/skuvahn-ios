//
//  VCRawH264Reader.h
//  VideoCodecKit
//
//  Created by CmST0us on 2020/1/27.
//  Copyright © 2020 eric3u. All rights reserved.
//

#import "VCAssetReader.h"
#import "HVCSampleBuffer.h"

NS_ASSUME_NONNULL_BEGIN

@interface VCRawH264Reader : VCAssetReader

- (instancetype)initWithURL:(NSURL *)fileURL;
@property (nonatomic, strong) NSData *h265Data;
@end

NS_ASSUME_NONNULL_END
