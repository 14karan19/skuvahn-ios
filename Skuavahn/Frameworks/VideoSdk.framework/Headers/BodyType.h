//
//  BodyType.h
//  newboyunshikong
//
//  Created by fany on 2022/11/28.
//  Copyright © 2022 Johnny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BodyType : NSObject
//视频数据
@property (nonatomic, strong) NSData *h265Data;
///视频类型  1为H264   3为H265
@property (nonatomic, assign) int FormatInt;
@end

NS_ASSUME_NONNULL_END
