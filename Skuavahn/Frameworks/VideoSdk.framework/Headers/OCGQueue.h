#import <Foundation/Foundation.h>

typedef enum PlayStatus{
    PlayStatusWaiting = 0,
    PlayStatusStart,
    PlayStatusPlaying,
    PlayStatusEnd,
} PlayStatus;

@interface OCGQueue : NSObject

@property(nonatomic, readonly, getter=isEmpty) BOOL empty;
@property(nonatomic, assign) PlayStatus playStatus;


//+ (instancetype)instance;
//+ (instancetype)queueWithObjects:(id)obj, ... NS_REQUIRES_NIL_TERMINATION;

- (void)pushObject:(id)object;

- (id)popObject;

- (NSUInteger)size;

-(void)cleanAll;

@end
