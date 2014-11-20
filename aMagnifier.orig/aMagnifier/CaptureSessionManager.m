//
//  CaptureSessionManager.m
//  aMagnifier
//
//  Created by Tom Jay on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CaptureSessionManager.h"

@implementation CaptureSessionManager



@synthesize captureSession;
@synthesize previewLayer;
@synthesize videoDevice;

#pragma mark Capture Session Configuration

- (id)init {
	if ((self = [super init])) {
		[self setCaptureSession:[[AVCaptureSession alloc] init]];
	}
	return self;
}

- (void) focusAtPoint:(CGPoint)point

{
    
    
    if ([self.videoDevice isFocusPointOfInterestSupported] && [self.videoDevice isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
        
        NSError *error;
        
        if ([self.videoDevice lockForConfiguration:&error]) {
            
            [self.videoDevice setFocusPointOfInterest:point];
            
            [self.videoDevice setFocusMode:AVCaptureFocusModeAutoFocus];
            
            [self.videoDevice unlockForConfiguration];
            
        }
//        else {
//            
//            id delegate = [self delegate];
//            
//            if ([delegate respondsToSelector:@selector(acquiringDeviceLockFailedWithError:)]) {
//                
//                [delegate acquiringDeviceLockFailedWithError:error];
//                
//            }
//            
//        }        
        
    }
    
}



- (void)addVideoPreviewLayer {
	[self setPreviewLayer:[[[AVCaptureVideoPreviewLayer alloc] initWithSession:[self captureSession]] autorelease]];
	[[self previewLayer] setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        
}

- (void)addVideoInput {
	self.videoDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
	if (self.videoDevice) {
		NSError *error;
		AVCaptureDeviceInput *videoIn = [AVCaptureDeviceInput deviceInputWithDevice:self.videoDevice error:&error];
		if (!error) {
			if ([[self captureSession] canAddInput:videoIn])
				[[self captureSession] addInput:videoIn];
			else
				NSLog(@"Couldn't add video input");
		}
		else
			NSLog(@"Couldn't create video input");
	}
	else
		NSLog(@"Couldn't create video capture device");
}

- (void)dealloc {
    
	[[self captureSession] stopRunning];
    
	[previewLayer release], previewLayer = nil;
	[captureSession release], captureSession = nil;
    
	[super dealloc];
}

@end
