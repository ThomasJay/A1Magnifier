//
//  CaptureSessionManager.h
//  aMagnifier
//
//  Created by Tom Jay on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>


@interface CaptureSessionManager : NSObject


@property (retain) AVCaptureVideoPreviewLayer *previewLayer;
@property (retain) AVCaptureSession *captureSession;
@property (retain) AVCaptureDevice *videoDevice;


- (void)addVideoPreviewLayer;
- (void)addVideoInput;

- (void) focusAtPoint:(CGPoint)point;

@end
