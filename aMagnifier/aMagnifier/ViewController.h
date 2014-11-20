//
//  ViewController.h
//  aMagnifier
//
//  Created by Tom Jay on 11/16/14.
//  Copyright (c) 2014 Tom Jay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaptureSessionManager.h"

@interface ViewController : UIViewController {
    float x;
    
    BOOL lightOn;
    
    BOOL adLoaded;
    
    UIView *zoomView;
    
    float mLastScale;
    
}

@property (retain) UISlider *zoomControl;

@property (retain) CaptureSessionManager *captureManager;
@property (retain) IBOutlet UIButton *lightButton;
@property (retain) IBOutlet UIImageView *overlayImageView;
@property (retain) IBOutlet UIButton *minusOverlayButton;
@property (retain) IBOutlet UIButton *plusOverlayButton;


-(IBAction) lightToggle:(id) sender;
-(IBAction) snapshot:(id) sender;


@end

