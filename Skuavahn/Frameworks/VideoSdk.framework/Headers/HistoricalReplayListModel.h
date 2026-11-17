//
//  HistoricalReplayListModel.h
//  Smart video
//
//  Created by 李启云 on 2023/8/3.
//  Copyright © 2023 Johnny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistoricalReplayListModel : NSObject
//设备名称
@property (nonatomic , copy) NSString *device;
//通道
@property (nonatomic , assign) NSInteger channel;
//
@property (nonatomic , assign) CGFloat filesize;
//文件名称
@property (nonatomic , assign) NSInteger fileName;
//开始时间
@property (nonatomic , copy) NSString *begintime;
@property (nonatomic , assign) NSInteger codetype;
@property (nonatomic , assign) NSInteger alarmSign;
@property (nonatomic , assign) NSInteger datatype;
@property (nonatomic , assign) NSInteger storgetype;
//结束时间
@property (nonatomic , copy) NSString *endtime;
@end

NS_ASSUME_NONNULL_END
