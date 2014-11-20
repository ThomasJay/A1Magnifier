//
//  MagnaViewController.h
//  aMagnifier
//
//  Created by Tom Jay on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaptureSessionManager.h"
#import "FlipsideViewController.h"
//#import "iAd/ADBannerView.h"

@interface MagnaViewController : UIViewController <FlipsideViewControllerDelegate, UIImagePickerControllerDelegate , UINavigationControllerDelegate> {
    float x;
    
    BOOL lightOn;
    
    BOOL adLoaded;
    
}

//@property (nonatomic, retain) ADBannerView *adBannerView;

@property (retain) UISlider *zoomControl;
@property (retain) CaptureSessionManager *captureManager;
@property (retain) UIButton *lightButton;
@property (retain) UIImageView *overlayImageView;
@property (retain) UIButton *minusOverlayButton;
@property (retain) UIButton *plusOverlayButton;

@end
