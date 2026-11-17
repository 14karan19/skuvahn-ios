//
//  bsj_RequestClass.h
//  视频SDK
//
//  Created by fany on 2020/12/16.
//  Copyright © 2020 Johnny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "bsj_SocketLink.h"
#import "bsj_PlayView.h"
#import "bsj_DataParsing.h"


NS_ASSUME_NONNULL_BEGIN



@class bsj_RequestClass;
@protocol bsj_RequestClassDataDelegate<voiceDelegate,NSObject>
/*
 操作失败的回调
 */
- (void)PLayError:(NSString *)Error PlayCH:(int)PlayCH ErrorCode:(NSInteger)errorCode socketType:(NSString *)socketType;
/*
 操作成功的提示
 */
- (void)PLaySuccess:(NSString *)Success PlayCH:(int)PlayCH SuccessCode:(NSInteger)successCode socketType:(NSString *)socketType;

/*是否在播放   PlayCH通道*/
- (void)playerIsPlaying:(BOOL)play PlayCH:(int)PlayCH;

/// 请求数据回调
/// - Parameter dictionary: 请求数据回调
- (void)RequestDataCallback:(NSString*)jsonString;
////播放Flv URL
- (void)FLVURLCallback:(NSString*)url;
/*
 历史视频文件回调
 */
- (void)histroyFile:(NSMutableArray *)fileArray;

-(void)VideoTime:(unsigned long long)videoTime;

/*
  观影已到autoCloseTimePerMinute分钟，停止播放
 timePerMinute:结束时候分钟
 isRealVideo:YES为实时视频，NO为历史视频
 */
- (void)autoStopPlayVideoFinished:(int )timePerMinute
                      isRealVideo:(BOOL)isRealVideo;

@end

@interface bsj_RequestClass : NSObject<SocketClientDelegate,voiceDelegate>
@property (weak, nonatomic) id<bsj_RequestClassDataDelegate> RequestDelegate;
//设置n分钟后停止播放实时和历史视频,默认120分钟后会暂停播放
@property (assign, nonatomic) int autoCloseTimePerMinute;
/*
 ==============实时视频================
 IP:服务器ip
 commandProt：命令链路端口
 dataProt ：数据链路端口
 DeviceNumber:设备号
 DeviceType:设备类型  （0：表示GA系列 1：表示GF—1078 2：表示GPRS-部标（不能播放））
 ACC:  0表示开，1表示关
 onLine：在线状态   默认从未上线    0：从未上线     1：行驶      2：停车     3：离线    4：过期
 PlayCH:播放的通道号 1-8
 toKen:登录TOKEN
 userName:登录账号
 guangDong:0表示不是粤标车，1表示粤标车
 CodeType 清晰度标清传1   高清传0
 packType 打包类型   0：裸流，1：http-flv。

 */
- (void)BSJ_PlayVideo_IP:(NSString *)IP
             commandProt:(int)commandProt
                dataProt:(int)dataProt
            DeviceNumber:(NSString *)DeviceNumber
              DeviceType:(int)DeviceType
                     ACC:(int)ACC
                  onLine:(int)onLine
                  PlayCH:(int)PlayCH
                   toKen:(NSString *)toKen
                userName:(NSString *)userName
                playView:(bsj_PlayView *)PlayView
               guangDong:(BOOL)guangDong CodeType:(int)codeType packType:(int)packType;

///关闭播放   释放socket
- (void)closePlayBack;  //回放
- (void)closeRealPlay;  //直播

//暂停播放 保持socket
- (void)stopRealPlay;//直播
- (void)stopPlayBack;//回放

@property (nonatomic, assign)BOOL isPlaying;

/*
 ==============历史视频================
 历史视频文件请求
 IP：服务器地址
 commandProt：命令链路的端口
 DeviceNumber:设备号
 DeviceType:设备类型  （0：表示GA系列 1：表示GF—1078 2：表示GPRS-部标（不能播放））
 ACC:  0表示开，1表示关
 onLine：在线状态   默认从未上线    0：从未上线     1：行驶      2：停车     3：离线    4：过期
 PlayCH:播放的通道号 1-8
 toKen:登录TOKEN
 userName:登录账号
 StartTime:搜索文件的开始时间
 EndTime：搜索文件的结束时间
 CodeType 清晰度标清传1   高清传0
 packType:(int)packType
*/
- (void)BSJ_PlayHistoryFile_IP:(NSString *)IP
                   commandProt:(int)commandProt
                      dataProt:(int)dataProt
                  DeviceNumber:(NSString *)DeviceNumber
                    DeviceType:(int)DeviceType
                           ACC:(int)ACC
                        onLine:(int)onLine
                        PlayCH:(int)PlayCH
                         toKen:(NSString *)toKen
                      userName:(NSString *)userName
                     StartTime:(NSTimeInterval)StartTime
                       EndTime:(NSTimeInterval)EndTime CodeType:(int)codeType packType:(int)packType;
/*
 StartTime:播放的开始时间
 EndTime：播放的结束时间
 palyCH:播放通道号
 guangDong:0表示不是粤标车，1表示粤标车
 CodeType 清晰度标清传1   高清传0
*/
- (void)BSJ_PlayHistory_FileName:(NSString *)name StartTime:(NSString *)startTime EndTime:(NSString *)endTime playCH:(NSString *)playCH PlayView:(bsj_PlayView *)playView guangDong:(BOOL)guangDong CodeType:(int)codeType;


/*
 时间转时间戳
 */
- (NSTimeInterval)TimeToTimestamp:(NSString *)time;
/*
 时间戳转时间
 */
- (NSString *)TimestampToTime:(NSString *)Timestamp;
/*
 ==============对讲================
 对讲
 IP:服务器ip
 commandProt：命令链路端口
 dataProt ：数据链路端口
 DeviceNumber:设备号
 DeviceType:设备类型  （0：表示GA系列 1：表示GF—1078 2：表示GPRS-部标（不能播放））
 ACC:  0表示开，1表示关
 onLine：在线状态   默认从未上线    0：从未上线     1：行驶      2：停车     3：离线    4：过期
 toKen:登录TOKEN
 userName:登录账号
 
 */
- (void)BSJ_IntercomOpen_IP:(NSString *)IP
             commandProt:(int)commandProt
                dataProt:(int)dataProt
            DeviceNumber:(NSString *)DeviceNumber
              DeviceType:(int)DeviceType
                     ACC:(int)ACC
                  onLine:(int)onLine
                   toKen:(NSString *)toKen
                userName:(NSString *)userName;
/*
 关闭
 */
- (void)BSJ_IntercomClose;

/// 切换高清度
/// - Parameter codeType: 默认1
- (void)ClaritySwitching:(int)codeType;


///声音
@property (nonatomic, assign) BOOL ISNeedToVoice;
@end
NS_ASSUME_NONNULL_END
