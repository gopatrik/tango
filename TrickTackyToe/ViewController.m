//
//  ViewController.m
//  TrickTackyToe
//
//  Created by Patrik Göthe on 7/14/13.
//  Copyright (c) 2013 Patrik Göthe. All rights reserved.
//

#import "ViewController.h"
#import "UIButton_SquareButton.h"
#import "Player.h"
#import "Board.h"
#import "TangoController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ();

@end

@implementation ViewController{
	TangoController *tangoController;
}
@synthesize mainView;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	// Circle that moves back and forth
	CGRect rect = [[self playerTurnAnimation] frame];
	CGFloat labelheight = rect.size.height;
	[[self playerTurnAnimation] setText:@""];
	[[[self playerTurnAnimation] layer] setCornerRadius:(labelheight/2)];

	
	// init controller
	tangoController = [[TangoController alloc] initWithView:self];
}

- (void) buttonPressed:(SquareButton*)button {
	[tangoController squarePressed:button];
}

- (void) animateTurnCircleTo:(CGPoint)xy withColor:(UIColor *)color{
	CGFloat delta = ([[self playerTurnAnimation] center].x > xy.x) ? -8 : 8;
	CGPoint bounceDelta = CGPointMake(xy.x + delta, xy.y);
	
	[UIView animateWithDuration:0.2 animations:^{
		[[self playerTurnAnimation] setCenter:bounceDelta];
		[[self playerTurnAnimation] setBackgroundColor:color]; // (cant animate this, yet)
	}completion:^(BOOL finished) {
		[UIView animateWithDuration:0.05 animations:^{
			[[self playerTurnAnimation] setCenter:xy];
		}];
	}];
}

- (void) buttonTouched:(SquareButton*) button {

}

- (void) animateClick:(SquareButton*) button withColor:(UIColor *)color{
	CGFloat constant = button.frame.size.width;
	CGFloat halfConstant = constant/2;
	
	[UIView animateWithDuration:0.1 animations:^{
		[button setFrame:CGRectMake(button.frame.origin.x+halfConstant, button.frame.origin.y, 0, button.frame.size.height)];
	} completion:^(BOOL finished) {
		[UIView animateWithDuration:0.1 animations:^{
			[button setBackgroundColor:color];
			[button setFrame:CGRectMake(button.frame.origin.x-halfConstant, button.frame.origin.y, constant, button.frame.size.height)];
		} completion:NO];
	}];
}

- (void) animateWin {
//	[UIView animateWithDuration:0.1 animations:^{
//		[[self playerTurnAnimation] setFrame:CGRectMake([[self playerTurnAnimation] frame].origin.x, [[self playerTurnAnimation] frame].origin.y, 100, 100)];
//	} completion:^(BOOL finished) {
//
//	}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
