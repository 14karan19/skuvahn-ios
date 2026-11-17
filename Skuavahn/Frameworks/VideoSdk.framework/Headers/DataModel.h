//
//  DataModel.h
//  newboyunshikong
//
//  Created by 李启云 on 2023/7/4.
//  Copyright © 2023 Johnny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataModel : NSObject
@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, copy) NSString *info;
//数据
@property (nonatomic, copy) NSMutableArray *listFile;
//文件大小
@property (nonatomic, assign) NSInteger recordFileSize;
//记录
@property (nonatomic, assign) NSInteger records;
//会话
@property (nonatomic, copy) NSString *session;
//状态
@property (nonatomic, assign) NSInteger status;
//页数
@property (nonatomic, assign) NSInteger totalPage;

@end

NS_ASSUME_NONNULL_END
