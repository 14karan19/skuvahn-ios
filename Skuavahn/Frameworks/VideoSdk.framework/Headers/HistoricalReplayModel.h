//
//  HistoricalReplayModel.h
//  Smart video
//
//  Created by 李启云 on 2023/8/3.
//  Copyright © 2023 Johnny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HistoricalReplayListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HistoricalReplayModel : NSObject
@property (nonatomic , assign) NSInteger records;
@property (nonatomic , assign) NSInteger status;
@property (nonatomic , assign) NSInteger totalPage;
@property (nonatomic , copy) NSArray *listFile;
@property (nonatomic , copy) NSString *session;
@property (nonatomic , assign) NSInteger curPage;
@property (nonatomic , copy) NSString *info;

@end

NS_ASSUME_NONNULL_END
