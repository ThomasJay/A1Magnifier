//
//  FlipsideViewController.h
//  XYZ
//
//  Created by Tom Jay on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController {
    IBOutlet UITextView *textView;
}

@property (assign, nonatomic) IBOutlet id <FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
