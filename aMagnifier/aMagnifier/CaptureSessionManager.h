//
//  CaptureSessionManager.h
//  aMagnifier
//
//  Created by Tom Jay on 11/16/14.
//  Copyright (c) 2014 Tom Jay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface CaptureSessionManager : NSObject


@property (retain) AVCaptureVideoPreviewLayer *previewLayer;
@property (retain) AVCaptureSession *captureSession;
@property (retain) AVCaptureDevice *videoDevice;

@property(nonatomic, retain) AVCaptureStillImageOutput *stillImageOutput;
@property(nonatomic, retain) UIImage *vImage;

- (void)addVideoPreviewLayer;
- (void)addVideoInput;

- (void) focusAtPoint:(CGPoint)point;

-(void) captureNow;

@end
