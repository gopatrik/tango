//
//  TangoController.m
//  Tango
//
//  Created by Patrik Göthe on 10/5/13.
//  Copyright (c) 2013 Patrik Göthe. All rights reserved.
//

#import "TangoController.h"
#import "Board.h"
#import "ViewController.h"
#import "Player.h"
#import "ColorScheme.h"

@implementation TangoController{
	Player* playerOne;
	Player* playerTwo;
	Player* currentPlayer;
	NSMutableArray* boards;
	SquareButton* LastSquareOccupiedByPlayerOne;
	SquareButton* LastSquareOccupiedByPlayerTwo;
	GCHelper *gameCenter;
}

- (TangoController*) initWithView:(ViewController *)view{
	[self setMainView:view];
	
	// board tracking
	[self setUpBoards];
	boards = [Board getBoards];
	
	// Set colors
	ColorScheme *colorScheme = [[ColorScheme alloc] initWithPlayerOneColor:@"#8CD1F4" playerTwoColor:@"#E89797" backgroundColor:@"#ffffff" highlightColor:@"#BBDCCC" squareColor:@"#fcfcfc" boardBackgroundColor:@"#aaaaaa"];
	
	[[[self mainView] background] setBackgroundColor:[colorScheme backgroundColor]];
	[[[self mainView] mainView] setBackgroundColor:[colorScheme boardBackgroundColor]];
	
	// init players
	playerOne = [[Player alloc] initWithName:@"Patrik" andColor:[colorScheme playerOneColor]]; //@"#8CD1F4"]];
	playerTwo = [[Player alloc] initWithName:@"Simon" andColor:[colorScheme playerTwoColor]]; //@"#D9917B"]];
	currentPlayer = playerOne;
	
	// init labels
	[[[self mainView] playerOneName] setText:[playerOne name]];
	[[[self mainView] playerTwoName] setText:[playerTwo name]];
	
	// initiate turn indicator
	[[[self mainView] playerTurnAnimation] setBackgroundColor:[currentPlayer color]];
	
	// gamecenter
	gameCenter = [[GCHelper alloc] init];
	
	return self;
}

- (BOOL) retinaScreen {
	if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
		([UIScreen mainScreen].scale == 2.0)) {
		// Retina display
		return true;
	} else {
		// non-Retina display
		return false;
	}
}

// what follows in this method is not good code. Todo:
// Find it in your heart to make the board class have settings for buttonsize, spacing and such.
- (void) setUpBoards {
	int squaresPerPlane = 9;
	
	CGFloat buttonsize;
	CGFloat boardSize;
	
	UIView *mainView = [[self mainView] mainView];

	BOOL retina = [self retinaScreen];
	buttonsize = mainView.bounds.size.width/(squaresPerPlane) - ((retina) ? 0.1 : 0.5);
	boardSize = 3 * buttonsize +((retina) ? 0.5 : 1.5);

	int offset = 0;
	int buttonNo = 1;
	for (int row = 0; row<squaresPerPlane/3; row++) {
		for (int col = 0; col<squaresPerPlane/3; col++) {
			Board *board = [[Board alloc] init];
			
			int counter = 0;
			for(id button in [board squares]) {
				
				// Touch listeners
				[button addTarget:[self mainView] action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchDown];
				[button addTarget:[self mainView] action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
				
				// appearance
				[button setFrame:CGRectMake((counter%3)*buttonsize + (offset%3)*boardSize, (counter/3)* buttonsize + (offset/3)*boardSize, buttonsize-0.5, buttonsize-0.5)];
				
				[mainView addSubview:button];
				counter +=1;
				
				[button setButtonId:buttonNo];
				buttonNo++;
			}
			offset += 1;
		}
	}
}


-(void) squarePressed:(SquareButton *)button {
	Board *board = [self getBoardFromButton:button];
	
	if (![button isOccupied] && [board isAvaliable]) {
		// Set button to occupied state
		[button setIsOccupied:true];
		[button setOccupator:currentPlayer];
		if (currentPlayer == playerOne) {
			LastSquareOccupiedByPlayerOne = button;
		}else{
			LastSquareOccupiedByPlayerTwo = button;
		}
		
		// Check board won
		if (![board isWon]) [board checkBoardWon];
		
		[self checkGameOver];
		
		// switch active board to corresponding board
		Board *correspondingBoard = boards[[[board squares] indexOfObject:button]];
		if ([correspondingBoard isWon]) {
			[Board setAviabilityOfAllBoardsTo:true];
		}else{
			[Board setAviabilityOfAllBoardsTo:false exeptFor:correspondingBoard];
		}
		
		// Animate click
		[[self mainView] animateClick:button withColor:[currentPlayer color]];
		
		// Switch player
		[self nextPlayer];
	}else{
		// NSLog(@"Board not avaliable or square occupied");
	}

}

- (void) checkGameOver { // duplicate in board
	
	// Win conditions
	int matrix[8][3] = {
		{0,1,2},
		{3,4,5},
		{6,7,8},
		{0,3,6},
		{1,4,7},
		{2,5,8},
		{0,4,8},
		{2,4,6}
	};
	
	for(int i = 0; i < 8; i++){
		if([self hasSameOwner:matrix[i][0] as:matrix[i][1] and:matrix[i][2]]){
			break;
		}
	}
}

// Check if three boards has same owner
- (BOOL) hasSameOwner: (int)first as:(int)second and:(int)third {
	Player *p = [boards[first] wonBy];
	if([p isEqual: [boards[second] wonBy]]){

		if ([p isEqual:[boards[third] wonBy]]) {
			[self andTheWinnerIs:p];
			return true;
		}
	}
	return false;
}

- (void) andTheWinnerIs:(Player*)player {
	// [[self mainView] animateTurnCircleTo: ([player isEqual:playerOne]) ? [[[self mainView] playerOneName] center] : [[[self mainView] playerTwoName] center] withColor:[player color]];
//	[[self mainView] animateWin];
	
	[(([player isEqual:playerOne]) ? [[self mainView] playerOneName] : [[self mainView] playerTwoName]) setText:@"winner"];
}

- (Board*) getBoardFromButton:(SquareButton*)button {
	return boards[(([button buttonId]-1)/9)]; // magic equation
}

- (void) nextPlayer {
	if (currentPlayer == playerOne) {
		currentPlayer = playerTwo;
		[[self mainView] animateTurnCircleTo:[[[self mainView] playerTwoName] center] withColor:[currentPlayer color]];
	}else{
		currentPlayer = playerOne;
		[[self mainView] animateTurnCircleTo:[[[self mainView] playerOneName] center] withColor:[currentPlayer color]];
	}
	
	//[[[self mainView] playerTurnAnimation] setBackgroundColor:[currentPlayer color]];
}



@end
