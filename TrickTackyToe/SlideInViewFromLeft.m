//
//  SlideInViewFromLeft.m
//  Tango
//
//  Created by Patrik Göthe on 10/13/13.
//  Copyright (c) 2013 Patrik Göthe. All rights reserved.
//

#import "SlideInViewFromLeft.h"

@implementation SlideInViewFromLeft
-(void)perform{
	UIViewController *sourceViewController = (UIViewController *) self.sourceViewController;
	UIViewController *destinationViewController = (UIViewController *) self.destinationViewController;
	[sourceViewController.view addSubview:destinationViewController.view];
	[destinationViewController.view setFrame:sourceViewController.view.window.frame];
	[destinationViewController.view setTransform:CGAffineTransformMakeTranslation(-sourceViewController.view.frame.size.width, 0)];
	[destinationViewController.view setAlpha:1.0];
	
	[UIView animateWithDuration:0.2
						  delay:0.0
						options:UIViewAnimationOptionTransitionFlipFromTop
					 animations:^{
						 [destinationViewController.view setTransform:CGAffineTransformMakeTranslation(15, 0)];
						 [destinationViewController.view setAlpha:1.0];
					 }
					 completion:^(BOOL finished){
						 [UIView animateWithDuration:0.1 animations:^{
							 [destinationViewController.view setTransform:CGAffineTransformMakeTranslation(0, 0)];
						 } completion:^(BOOL finished) {
							 [destinationViewController.view removeFromSuperview];
							 [sourceViewController presentViewController:destinationViewController animated:NO completion:nil];
						 }];
					 }];
}
@end
