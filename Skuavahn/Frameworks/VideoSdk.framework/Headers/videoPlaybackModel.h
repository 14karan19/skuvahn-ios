//
//  videoPlaybackModel.h
//  Smart video
//
//  Created by 李启云 on 2023/7/29.
//  Copyright © 2023 Johnny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mediaAddressModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface videoPlaybackModel : NSObject
@property (nonatomic, assign) NSInteger status;
///描述
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *session;
///视频高清1  标清0
@property (nonatomic, assign) NSInteger codetype;
@property (nonatomic, strong) NSDictionary *media_address;
@end


NS_ASSUME_NONNULL_END
