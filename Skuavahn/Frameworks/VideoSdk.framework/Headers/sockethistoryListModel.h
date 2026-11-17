//
//  historyListModel.h
//  newboyunshikong
//
//  Created by 李启云 on 2023/7/4.
//  Copyright © 2023 Johnny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface sockethistoryListModel : NSObject
//报警信号
@property (nonatomic, assign) NSInteger alarmSign;
///开始时间
@property (nonatomic, assign) NSInteger begintime;
//通道
@property (nonatomic, assign) NSInteger channel;
//清晰度
@property (nonatomic, assign) NSInteger codetype;
//数据类型
@property (nonatomic, assign) NSInteger datatype;
//设备号
@property (nonatomic, copy) NSString *device;
//结束时间
@property (nonatomic, copy) NSString *endtime;
//文件名称
@property (nonatomic, copy) NSString *fileName;
//文件大小
@property (nonatomic, copy) NSString *filesize;
@property (nonatomic, copy) NSString *storgetype;

@end

NS_ASSUME_NONNULL_END
