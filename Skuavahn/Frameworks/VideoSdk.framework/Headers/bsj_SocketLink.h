//
//  SocketClient.h
//  TS
//
//  Created by Johnny on 15/6/6.
//  Copyright (c) 2015年 Johnny. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, BSJLinkType) {
    BSJLinkTypeNone = 0,
    BSJLinkTypeCommand,
    BSJLinkTypeData,
};

typedef NS_ENUM(NSInteger, BSJSessionType) {
    BSJSessionTypeNone = 0,
    BSJSessionTypeRegist,
    BSJSessionTypeLiveVideoAddress,
    BSJSessionTypeHistoryList,
    BSJSessionTypeHistoryVideoAddress,
    BSJSessionTypeCloseHistoryVideo,
//    BSJSessionTypeCloseLiveVideo,//后台暂无回调，不需要处理
};

typedef NS_ENUM(NSInteger, BSJVideoType) {
    BSJVideoTypeNone = 0,
    BSJVideoTypeLiveVideo,
    BSJVideoTypeHistoryVideo,
    BSJVideoTypeTalk
};

@protocol SocketClientDelegate<NSObject>
- (void)Disconnect:(NSString *)type CloseType:(int)CloseType;//type链路类型，closetype1主动断开或被动断开0

- (void)zcRequest:(NSDictionary *)dictionary;
- (void)playRequestAddress:(NSDictionary *)dictionary;
- (void)playRequest:(NSData *)data;
- (void)intercomplayRequest:(NSData *)data;

- (void)historyFileRequest:(NSDictionary *)dic error:(NSError *)error jsonString:(NSString *)jsonString;
- (void)historyPlayRequestAddress:(NSDictionary *)dictionary;
- (void)historyPlayRequest:(NSData *)data;

- (BSJSessionType)typeOfSessionId:(NSString *)sessionId;
- (void)removeSessionId:(NSString *)sessionId;

- (void)playError:(NSString *)Error errorCode:(NSInteger)code socketType:(NSString *)socketType;
- (void)playSuccess:(NSString *)Success successCode:(NSInteger)code socketType:(NSString *)socketType;
/// 请求数据回调
/// - Parameter dictionary: 请求数据回调
- (void)InstructionResponse:(NSString*)jsonString;
@end

@interface bsj_SocketLink : NSObject 

@property (weak, nonatomic) id<SocketClientDelegate>socketDelegate;
@property (nonatomic, assign) BSJLinkType linkType;
@property (nonatomic, assign) BSJVideoType videoType;
@property (nonatomic, copy) NSString* socketType;

- (BOOL)clientStart_IP:(NSString *)IP Prot:(int)Prot;
- (void)clienSendData:(NSData *)data type:(int)type device:(NSString *)device;
- (void)closeClient;

static dispatch_queue_t tcpDataQueue();

@end
