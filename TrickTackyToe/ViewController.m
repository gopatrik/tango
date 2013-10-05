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

@interface ViewController ();

@end

@implementation ViewController{

	NSMutableArray *boards;
	TangoController *tangoController;
}
@synthesize mainView;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	int squaresPerPlane = 9;
	boards = [[NSMutableArray alloc] initWithCapacity:9];
	
	[mainView setBackgroundColor:[Toolbag colorFromHexString:@"#dddddd"]];

	CGFloat buttonsize = mainView.bounds.size.width/(squaresPerPlane);

	int offset = 0;
	CGFloat boardSize = 3*buttonsize;
	int buttonNo = 1;
	
	for (int row = 0; row<squaresPerPlane/3; row++) {
		for (int col = 0; col<squaresPerPlane/3; col++) {
			Board *board = [[Board alloc] init];
	
			int counter = 0;
			for(id button in [board squares]) {
				[button addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchDown];
				[button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
				[button setFrame:CGRectMake((counter%3)*buttonsize + (offset%3)*boardSize, (counter/3)* buttonsize + (offset/3)*boardSize, buttonsize-2, buttonsize-2)];
				[mainView addSubview:button];
				counter +=1;
				
				[button setButtonId:buttonNo];
				buttonNo++;
			}
			offset += 1;
		}
	}
	
	boards = [Board getBoards];

	tangoController = [[TangoController alloc] initWithView:self];
}

- (void) buttonPressed:(SquareButton*)button {
	[tangoController squarePressed:button];
}

- (void) buttonTouched:(SquareButton*) button {
//	Board *board = [self getBoardFromButton:button];
//	if (![button isOccupied] && [board isAvaliable]) {
//		int constant = 6;
//		int halfConstant = 3;
//		[UIView animateWithDuration:0.02 animations:^{
//			[button setFrame:CGRectMake(button.frame.origin.x+halfConstant, button.frame.origin.y+halfConstant, button.frame.size.width-constant, button.frame.size.height-constant)];
//		
//			[button setBackgroundColor:[currentPlayer color]];
//		}];
//	}
}

- (void) animateClick:(SquareButton*) button withColor:(UIColor *)color{
	int constant = 6;
	int halfConstant = 3;
	
	[UIView animateWithDuration:0.02 animations:^{
		[button setFrame:CGRectMake(button.frame.origin.x+halfConstant, button.frame.origin.y+halfConstant, button.frame.size.width-constant, button.frame.size.height-constant)];
		
		[button setBackgroundColor:color];
		
	} completion:^(BOOL finished) {
		[UIView animateWithDuration:0.05 animations:^{ // delay:0.01 options:NO
			[button setFrame:CGRectMake(button.frame.origin.x-halfConstant, button.frame.origin.y-halfConstant, button.frame.size.width+constant, button.frame.size.height+constant)];
		} completion:NO];
	}];
	
		

	
//		[UIView animateWithDuration:0.05 animations:^{ // delay:0.01 options:NO
//			[button setFrame:CGRectMake(button.frame.origin.x-halfConstant, button.frame.origin.y-halfConstant, button.frame.size.width+constant, button.frame.size.height+constant)];
//		} completion:NO];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
