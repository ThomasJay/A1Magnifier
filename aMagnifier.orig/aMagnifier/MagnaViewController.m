//
//  MagnaViewController.m
//  aMagnifier
//
//  Created by Tom Jay on 4/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MagnaViewController.h"

@implementation MagnaViewController

@synthesize captureManager;
@synthesize zoomControl;
@synthesize lightButton;
//@synthesize adBannerView;
@synthesize overlayImageView;
@synthesize minusOverlayButton;
@synthesize plusOverlayButton;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        x = 1.0;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor redColor];
    
//    self.captureManager = [[CaptureSessionManager alloc] init];
//    
//	[self.captureManager addVideoInput];
//    
//	[self.captureManager addVideoPreviewLayer];
//	CGRect layerRect = [[[self view] layer] bounds];
//	[[self.captureManager previewLayer] setBounds:layerRect];
//	[[self.captureManager previewLayer] setPosition:CGPointMake(CGRectGetMidX(layerRect),
//                                                                  CGRectGetMidY(layerRect))];
//	[[[self view] layer] addSublayer:[self.captureManager previewLayer]];
//    
//    overlayImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"overlay.png"]];
//    [overlayImageView setFrame:CGRectMake(0, 0, 320, 460)];
//    [[self view] addSubview:overlayImageView];
//    
//    self.plusOverlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.plusOverlayButton setImage:[UIImage imageNamed:@"zoom_in.png"] forState:UIControlStateNormal];
//    [self.plusOverlayButton setFrame:CGRectMake(275, 420, 40, 40)];
//    [self.plusOverlayButton addTarget:self action:@selector(zoomOutPressed) forControlEvents:UIControlEventTouchUpInside];
//    [[self view] addSubview:self.plusOverlayButton];
//    
//    self.minusOverlayButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.minusOverlayButton setImage:[UIImage imageNamed:@"zoom_out.png"] forState:UIControlStateNormal];
//    [self.minusOverlayButton setFrame:CGRectMake(8, 420, 40, 40)];
//    [self.minusOverlayButton addTarget:self action:@selector(zoomInPressed) forControlEvents:UIControlEventTouchUpInside];
//    [[self view] addSubview:self.minusOverlayButton];
//    
//    self.lightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.lightButton setTitle: @"Turn On Light" forState: UIControlStateNormal];
//    [self.lightButton setBackgroundImage:[UIImage imageNamed:@"blue_button.png"] forState:UIControlStateNormal];
//    [self.lightButton setFrame:CGRectMake(95, 2, 140, 30)];
//    [self.lightButton addTarget:self action:@selector(lightToggle) forControlEvents:UIControlEventTouchUpInside];
//    [[self view] addSubview:self.lightButton];
//    
//    
//    
//    self.zoomControl = [ [ UISlider alloc ] initWithFrame: CGRectMake(60, 418, 195, 40) ];
//    self.zoomControl.minimumValue = 1.0;
//    self.zoomControl.maximumValue = 10.0;
//    self.zoomControl.value = 1.0;
//    self.zoomControl.continuous = YES;
//    [self.zoomControl addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
//
//    [[self view] addSubview:self.zoomControl];
//    
//    
//    
//    UIButton *infoButton =  [UIButton buttonWithType:UIButtonTypeInfoLight ] ;
//    
//    [infoButton addTarget:self action:@selector(infoPage) forControlEvents:UIControlEventTouchUpInside];
//    [infoButton setFrame:CGRectMake(290, 4, 30, 30)];
//    [infoButton setEnabled:TRUE];
//    [[self view] addSubview:infoButton];

    // Only one Ad per app
//    self.adBannerView = [[ADBannerView alloc] initWithFrame:CGRectZero];
//    adBannerView.delegate = self;
    
//    adBannerView.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifier320x50];
//    adBannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifier320x50;
//    adBannerView.frame = CGRectMake(325, 410, 320, 50);
//    [[self view] addSubview:adBannerView];
    
//	[[self.captureManager captureSession] startRunning];
}
    
-(void) infoPage {
    FlipsideViewController *controller = [[[FlipsideViewController alloc] initWithNibName:@"FlipsideViewController" bundle:nil] autorelease];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];

}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}


//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    NSLog(@"touchesEnded Started");
//    
//    UITouch *touch = [[event allTouches] anyObject];
//    CGPoint point = [touch locationInView: [UIApplication sharedApplication].keyWindow];
//    
//    [captureManager focusAtPoint:point];
//}


-(void) zoomInPressed {
    
//    NSLog(@"zoomInPressed Started");
    
    
    
    x = x - .2;
    
    if (x < 1.0) {
        x = 1.0;
    }
    
    CGRect layerRect = [[[self view] layer] bounds];
	[[self.captureManager previewLayer] setBounds:layerRect];
    [self.captureManager previewLayer].frame = CGRectMake([self.captureManager previewLayer].frame.origin.x * x,
                                                          [self.captureManager previewLayer].frame.origin.y * x,
                                                          [self.captureManager previewLayer].frame.size.width * x,
                                                          [self.captureManager previewLayer].frame.size.height * x);
    
	[[self.captureManager previewLayer] setPosition:CGPointMake(CGRectGetMidX(layerRect),
                                                                CGRectGetMidY(layerRect))];
    
//    NSLog(@"zoomInPressed x=%f", x);
    
    self.zoomControl.value = x;

}


- (void)sliderAction:(UISlider*)sender
{
    
    x = [sender value];
    
    
    CGRect layerRect = [[[self view] layer] bounds];
	[[self.captureManager previewLayer] setBounds:layerRect];
    [self.captureManager previewLayer].frame = CGRectMake([self.captureManager previewLayer].frame.origin.x * x,
                                                          [self.captureManager previewLayer].frame.origin.y * x,
                                                          [self.captureManager previewLayer].frame.size.width * x,
                                                          [self.captureManager previewLayer].frame.size.height * x);
    
	[[self.captureManager previewLayer] setPosition:CGPointMake(CGRectGetMidX(layerRect),
                                                                CGRectGetMidY(layerRect))];

}



-(void) lightOnButtonPressed {
    
    
    [self.lightButton setTitle: @"Turn Off Light" forState: UIControlStateNormal];
    
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
    
    
    [self.lightButton setTitle: @"Turn On Light" forState: UIControlStateNormal];
    
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo]; for (AVCaptureDevice *device in devices) {
        
        if ([device hasFlash] == YES) {
            [device lockForConfiguration:nil];
            [device setTorchMode:AVCaptureTorchModeOff];
            [device unlockForConfiguration];
        }
        
    }
}

-(void) lightToggle {
    if (lightOn) {
        [self lightOFFButtonPressed];
        lightOn = NO;
    }
    else {
        [self lightOnButtonPressed];
        lightOn = YES;
    }
}



-(void) zoomOutPressed {
    
//    NSLog(@"zoomOutPressed Started");

    
    x = x + .2;
    
    CGRect layerRect = [[[self view] layer] bounds];
	[[self.captureManager previewLayer] setBounds:layerRect];
    [self.captureManager previewLayer].frame = CGRectMake([self.captureManager previewLayer].frame.origin.x * x,
                                                          [self.captureManager previewLayer].frame.origin.y * x,
                                                          [self.captureManager previewLayer].frame.size.width * x,
                                                          [self.captureManager previewLayer].frame.size.height * x);
    
	[[self.captureManager previewLayer] setPosition:CGPointMake(CGRectGetMidX(layerRect),
                                                                CGRectGetMidY(layerRect))];

//    NSLog(@"zoomOutPressed x=%f", x);
    
    self.zoomControl.value = x;

    
}

-(void) viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];

//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.delegate = self;
////    picker.allowsImageEditing = YES;
//    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//    [self presentModalViewController: picker animated:YES];
//    [picker release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
//    
////    NSLog(@"bannerViewDidLoadAd Started");
//    
//    if (!adLoaded) {
//        adBannerView.frame = CGRectMake(0, adBannerView.frame.origin.y, adBannerView.frame.size.width, adBannerView.frame.size.height);
//        
//        overlayImageView.image = [UIImage imageNamed:@"overlay-short.png"];
//        [overlayImageView setFrame:CGRectMake(0, 0, 320, 410)];
//        
//        self.zoomControl.frame = CGRectMake(60, 370, 195, 40);
//
//        self.minusOverlayButton.frame = CGRectMake(8, 370, 40, 40);
//        
//        self.plusOverlayButton.frame = CGRectMake(275, 370, 40, 40);
//
//    }
//    
//    adLoaded = YES;
//    
//    
//    
//}

//- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
//{
////    NSLog(@"didFailToReceiveAdWithError Started");
//    
//    if (adLoaded) {
//        adBannerView.frame = CGRectMake(325, adBannerView.frame.origin.y, adBannerView.frame.size.width, adBannerView.frame.size.height);
//        
//        overlayImageView.image = [UIImage imageNamed:@"overlay.png"];
//        [overlayImageView setFrame:CGRectMake(0, 0, 320, 460)];
//        
//        self.zoomControl.frame = CGRectMake(60, 418, 195, 40);
//        
//        self.minusOverlayButton.frame = CGRectMake(8, 420, 40, 40);
//
//        self.plusOverlayButton.frame = CGRectMake(275, 420, 40, 40);
//
//
//    }
//    
//    adLoaded = NO;
//    
//    
//}


@end
