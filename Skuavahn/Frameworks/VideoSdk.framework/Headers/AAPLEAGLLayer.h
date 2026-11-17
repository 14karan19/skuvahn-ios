//
//  AAPLEAGLLayer.h
//  newboyunshikong
//
//  Created by fany on 2021/6/1.
//  Copyright © 2021 Johnny. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <QuartzCore/QuartzCore.h>
#include <CoreVideo/CoreVideo.h>
NS_ASSUME_NONNULL_BEGIN



@interface AAPLEAGLLayer : CAEAGLLayer
@property CVPixelBufferRef pixelBuffer;
- (id)initWithFrame:(CGRect)frame;
- (void)resetRenderBuffer;
@end

NS_ASSUME_NONNULL_END
