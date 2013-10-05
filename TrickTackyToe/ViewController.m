//
//  ViewController.m
//  TrickTackyToe
//
//  Created by Patrik Göthe on 7/14/13.
//  Copyright (c) 2013 Patrik Göthe & Ville Petersson. All rights reserved.
//

#import "ViewController.h"
#import "UIButton_SquareButton.h"
#import "Player.h"
#import "Board.h"
#import "Toolbag.h"
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
	
	int squaresPerPlane = 9;
	
	[mainView setBackgroundColor:[Toolbag colorFromHexString:@"#bdbdbd"]];

	CGFloat buttonsize = mainView.bounds.size.width/(squaresPerPlane);

	int offset = 0;
	CGFloat boardSize = 3*buttonsize;
	int buttonNo = 1;
	
	for (int row = 0; row<squaresPerPlane/3; row++) {
		for (int col = 0; col<squaresPerPlane/3; col++) {
			Board *board = [[Board alloc] init];
	
			int counter = 0;
			for(id button in [board squares]) {
				
				// Touch listeners
				[button addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchDown];
				[button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
				
				// appearance
				[button setFrame:CGRectMake((counter%3)*buttonsize + (offset%3)*boardSize, (counter/3)* buttonsize + (offset/3)*boardSize, buttonsize-1, buttonsize-1)];
				
				
				[mainView addSubview:button];
				counter +=1;
				
				[button setButtonId:buttonNo];
				buttonNo++;
			}
			offset += 1;
		}
	}
	
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
		[[self playerTurnAnimation] setBackgroundColor:color]; // cant animate this
		//[[[self playerTurnAnimation] layer] setBackgroundColor:[color CGColor]];
	}completion:^(BOOL finished) {
		[UIView animateWithDuration:0.05 animations:^{
			[[self playerTurnAnimation] setCenter:xy];
		}];
	}];
}

- (void) buttonTouched:(SquareButton*) button {

}

- (void) animateClick:(SquareButton*) button withColor:(UIColor *)color{
	CGFloat constant = button.frame.size.width;//12;
	CGFloat halfConstant = constant/2;
	
	[UIView animateWithDuration:0.1 animations:^{
		//[button setFrame:CGRectMake(button.frame.origin.x+halfConstant, button.frame.origin.y+halfConstant, button.frame.size.width-constant, button.frame.size.height-constant)];
		
		[button setFrame:CGRectMake(button.frame.origin.x+halfConstant, button.frame.origin.y, 0, button.frame.size.height)];
		
		
//		[button setBackgroundColor:color];
		
	} completion:^(BOOL finished) {
		[UIView animateWithDuration:0.1 animations:^{
			[button setBackgroundColor:color];
			//[button setFrame:CGRectMake(button.frame.origin.x-halfConstant, button.frame.origin.y-halfConstant, button.frame.size.width+constant, button.frame.size.height+constant)];
			
			[button setFrame:CGRectMake(button.frame.origin.x-halfConstant, button.frame.origin.y, constant, button.frame.size.height)];
			
			
		} completion:NO];
	}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
