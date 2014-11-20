//
//  ViewController.m
//  aMagnifier
//
//  Created by Tom Jay on 11/16/14.
//  Copyright (c) 2014 Tom Jay. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    mLastScale = 99.0f;
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    CGRect fullScreenRect = [[[self view] layer] bounds];

    self.captureManager = [[CaptureSessionManager alloc] init];
    
    [self.captureManager addVideoInput];
    
    [self.captureManager addVideoPreviewLayer];
    
    zoomView = [[UIView alloc] initWithFrame:CGRectMake(10, 120, fullScreenRect.size.width - 20, fullScreenRect.size.height - 210)];
    //zoomView.backgroundColor = [UIColor redColor];
    zoomView.clipsToBounds = YES;
    
    UIPinchGestureRecognizer* pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGesture:)];
    [zoomView addGestureRecognizer:pinchRecognizer];


    
    CGRect layerRect = [[[self view] layer] bounds];
    layerRect = CGRectMake(0, 0, zoomView.frame.size.width, zoomView.frame.size.height);
    
    [[self.captureManager previewLayer] setBounds:layerRect];
    [[self.captureManager previewLayer] setPosition:CGPointMake(CGRectGetMidX(layerRect),
                                                                      CGRectGetMidY(layerRect))];
    
    [self.view addSubview:zoomView];
    
    [[zoomView layer] addSublayer:[self.captureManager previewLayer]];

    self.plusOverlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.plusOverlayButton setImage:[UIImage imageNamed:@"plus_button.png"] forState:UIControlStateNormal];
    [self.plusOverlayButton setFrame:CGRectMake(fullScreenRect.size.width - 60, fullScreenRect.size.height - 60, 40, 40)];
    [self.plusOverlayButton addTarget:self action:@selector(zoomOutPressed) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:self.plusOverlayButton];
    
    self.minusOverlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.minusOverlayButton setImage:[UIImage imageNamed:@"minus_button.png"] forState:UIControlStateNormal];
    [self.minusOverlayButton setFrame:CGRectMake(20, fullScreenRect.size.height - 60, 40, 40)];
    [self.minusOverlayButton addTarget:self action:@selector(zoomInPressed) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:self.minusOverlayButton];
    
    
        self.zoomControl = [ [ UISlider alloc ] initWithFrame: CGRectMake(80, fullScreenRect.size.height - 58, fullScreenRect.size.width - 160, 40) ];
        self.zoomControl.minimumValue = 1.0;
        self.zoomControl.maximumValue = 10.0;
        self.zoomControl.value = 1.0;
        self.zoomControl.continuous = YES;
        [self.zoomControl addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    
        [[self view] addSubview:self.zoomControl];
    
    
    //
    //    UIButton *infoButton =  [UIButton buttonWithType:UIButtonTypeInfoLight ] ;
    //
    //    [infoButton addTarget:self action:@selector(infoPage) forControlEvents:UIControlEventTouchUpInside];
    //    [infoButton setFrame:CGRectMake(290, 4, 30, 30)];
    //    [infoButton setEnabled:TRUE];
    //    [[self view] addSubview:infoButton];
    
    
    [[self.captureManager captureSession] startRunning];

}

- (void)pinchGesture:(UIPinchGestureRecognizer*)gesture
{
    
    float mScale = [gesture scale];
    
    NSLog(@"latscale = %f",[gesture scale]);
    
    if (mLastScale > [gesture scale]) {
        [self zoomInPressed];
    }
    else {
        [self zoomOutPressed];
    }
    
    mLastScale = mScale;

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void) lightOnButtonPressed {
    
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    
    for (AVCaptureDevice *device in devices) {
        
        if ([device hasFlash] == YES) {
            [device lockForConfiguration:nil];
            [device setTorchMode:AVCaptureTorchModeOn];
            [device unlockForConfiguration];
        }
        
    }
    
}

-(void) lightOFFButtonPressed {
    
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo]; for (AVCaptureDevice *device in devices) {
        
        if ([device hasFlash] == YES) {
            [device lockForConfiguration:nil];
            [device setTorchMode:AVCaptureTorchModeOff];
            [device unlockForConfiguration];
        }
        
    }
}

-(IBAction) lightToggle:(id) sender {
    if (lightOn) {
        [self lightOFFButtonPressed];
        lightOn = NO;
    }
    else {
        [self lightOnButtonPressed];
        lightOn = YES;
    }
}

- (void)sliderAction:(UISlider*)sender
{
    
    x = [sender value];
    
    CGRect layerRect = [[[self view] layer] bounds];
    layerRect = CGRectMake(0, 0, zoomView.frame.size.width, zoomView.frame.size.height);
    
    [[self.captureManager previewLayer] setBounds:layerRect];
    
    [self.captureManager previewLayer].frame = CGRectMake([self.captureManager previewLayer].frame.origin.x * x,
                                                          [self.captureManager previewLayer].frame.origin.y * x,
                                                          [self.captureManager previewLayer].frame.size.width * x,
                                                          [self.captureManager previewLayer].frame.size.height * x);
    
    [[self.captureManager previewLayer] setPosition:CGPointMake(CGRectGetMidX(layerRect),
                                                                CGRectGetMidY(layerRect))];
    
}

-(void) zoomInPressed {
    
    x = x - .2;
    
    if (x < 1.0) {
        x = 1.0;
    }
    
    self.zoomControl.value = x;
    
    [self sliderAction:self.zoomControl];


}

-(void) zoomOutPressed {
    
    x = x + .2;
    
    if (x > 10) {
        x = 10;
    }
    
    self.zoomControl.value = x;

    [self sliderAction:self.zoomControl];

}




-(IBAction) snapshot:(id) sender {
    
    [self.captureManager captureNow];
    
}


@end
