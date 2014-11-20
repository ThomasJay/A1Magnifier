//
//  CaptureSessionManager.m
//  aMagnifier
//
//  Created by Tom Jay on 11/16/14.
//  Copyright (c) 2014 Tom Jay. All rights reserved.
//

#import "CaptureSessionManager.h"
#import <ImageIO/CGImageProperties.h>
#import <UIKit/UIKit.h>

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
    [self setPreviewLayer:[[AVCaptureVideoPreviewLayer alloc] initWithSession:[self captureSession]]];
    [[self previewLayer] setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [self.stillImageOutput setOutputSettings:outputSettings];
    
    [[self captureSession] addOutput:self.stillImageOutput];
    
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
    
    previewLayer = nil;
    captureSession = nil;
    
}

-(void) captureNow
{
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in self.stillImageOutput.connections)
    {
        for (AVCaptureInputPort *port in [connection inputPorts])
        {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] )
            {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) { break; }
    }
    
    NSLog(@"about to request a capture from: %@", self.stillImageOutput);
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error)
     {
         CFDictionaryRef exifAttachments = CMGetAttachment( imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
         if (exifAttachments)
         {
             // Do something with the attachments.
             NSLog(@"attachements: %@", exifAttachments);
         }
         else
             NSLog(@"no attachments");
         
         NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
         UIImage *image = [UIImage imageWithData:imageData];
         
         self.vImage = image;
         
         UIImageWriteToSavedPhotosAlbum(self.vImage, nil, nil, nil );
         


     }];
}

@end
