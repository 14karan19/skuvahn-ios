//
//  GetPlayURLScoketClientTool.h
//  VideoSdk
//
//  Created by 李启云 on 2023/11/10.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "AsyncSocket.h"

@protocol GetPlayURLSocketDataPushDataDelegate <NSObject>


@optional
/// Disconnected callback
- (void)socketDidDisconnect;

///Proxy method for obtaining the video URL
- (void)FLVURLCallback:(NSString*)url;

///The playback video list proxy method is obtained
///When obtaining the playback list, please implement this proxy method. From this proxy method, you can obtain the playback data. Without this proxy method, the program will crash
- (void)histroyFile:(NSDictionary *)fileArray;

/// The proxy method when starting the intercom
///  When using the intercom function, please implement this proxy method. When you start the intercom, you will enter this proxy. If you do not implement this proxy method, it will crash
- (void)StartTheIntercom;

///Device status agent
///This method must be implemented to get some state at the time of the request. Without this method, the program will crash
- (void)DeviceStatus:(NSDictionary *)fileArray;

@end


@interface GetPlayURLScoketClientTool : NSObject<AsyncSocketDelegate>
@property (nonatomic, weak) id<GetPlayURLSocketDataPushDataDelegate> SocketDataDelegate;


/// Initialize the connection service
/// - Parameters:
///   - ipString: IP address
///   - onPortString: Port number
- (BOOL)SocketClientStart :(NSString *)ipString onPort:(NSInteger)onPortString;

///Closing Socket connection
- (void)SocketCloseClient;


/// Get the video playback list
/// - Parameters:
///   - DeviceNumber: Id of the device to be queried
///   - channel: You need to query the channel ID
///   - begintime: The start time is YYYYMMDDHHMMSS, for example, 2023-07-07 23:59:59. The value is 20230707235959
///   - endtime: The end time is YYYYMMDDHHMMSS, for example, 2023-07-07 23:59:59. The value is 20230707235959
///   - toKen: token at login
///   - session: Flags which request responds to random uid
///   - LanguageCode: Language of background response
- (void)PlayHistoryFileDeviceNumber:(NSString *)DeviceNumber
                       channel:(int)channel
                     begintime:(NSString *)begintime
                       endtime:(NSString *)endtime
                         toKen:(NSString *)toKen LanguageCode:(NSString *)LanguageCode;


/// View playback video request
/// - Parameters:
///   - DeviceNumber: Id of the device to be queried
///   - channel: You need to query the channel ID
///   - begintime: The start time is YYYYMMDDHHMMSS, for example, 2023-07-07 23:59:59. The value is 20230707235959
///   - endtime: The end time is YYYYMMDDHHMMSS, for example, 2023-07-07 23:59:59. The value is 20230707235959
///   - toKen: token at login
///   - session: Flags which request responds to random uid
///   - LanguageCode: Language of background response
- (void)playbackNumber:(NSString *)DeviceNumber
                       channel:(int)channel
                     begintime:(NSString *)begintime
                       endtime:(NSString *)endtime
                         toKen:(NSString *)toKen
                  username:(NSString *)username LanguageCode:(NSString *)LanguageCode;



/// Close video
/// - Parameters:
///   - DeviceNumber: Number of the disabled device
///   - tokenString: token
///  - channel:channel
- (void)CloseVideo:(NSString *)DeviceNumber token:(NSString *)tokenString channel:(NSString *)channel;


/// Close replay
/// - Parameters:
///   - DeviceNumber: DeviceNumber
///   - tokenString: tokenString
///   - channel: channel
- (void)CloseReplay:(NSString *)DeviceNumber token:(NSString *)tokenString channel:(NSString *)channel;

- (void)registeredDeviceNumber:(NSString *)DeviceNumber
                         toKen:(NSString *)toKen LanguageCode:(NSString *)LanguageCode playType:(NSInteger )typeInt;

/// Real-time video playback
/// - Parameters:
///   - DeviceNumber: Id of the device to be queried
///   - channel: Id of the channel to be queried
///   - toKen: token
///   - username: User name
///   - LanguageCode: Language of background response
- (void)PlayLiveVideo:(NSString *)DeviceNumber
                       channel:(int)channel
                         toKen:(NSString *)toKen
                 username:(NSString *)username LanguageCode:(NSString *)LanguageCode;


/// Request intercom function   Initialization is required each time you request an intercom
/// - Parameters:
///   - toKen: Login token
///   - DevicenumberString: Id of the device to be queried
///   - LanguageCode: Language of background response
///   - UsernameString: User name
///   - IPAddressString: IP address
///   - port: Port number   The port number for the intercom is different from the port number for viewing the video
- (void)walkieTalkietoken:(NSString *)toKen Devicenumber:(NSString *)DevicenumberString LanguageCode:(NSString *)LanguageCode Username:(NSString *)UsernameString IPAddress:(NSString *)IPAddressString port:(NSInteger)port;

/// Disable the intercom function
- (void)realtimeCloseIntercom;

@end
