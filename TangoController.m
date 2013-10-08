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
#import "Toolbag.h"

@implementation TangoController{
	Player* playerOne;
	Player* playerTwo;
	Player* currentPlayer;
	NSMutableArray* boards;
	SquareButton* LastSquareOccupiedByPlayerOne;
	SquareButton* LastSquareOccupiedByPlayerTwo;
}

- (TangoController*) initWithView:(ViewController *)view{
	[self setMainView:view];
	boards = [Board getBoards];
	
	playerOne = [[Player alloc] initWithName:@"Patrik" andColor:[Toolbag colorFromHexString:@"#8CD1F4"]]; //@"#8CD1F4"]];
	playerTwo = [[Player alloc] initWithName:@"Simon" andColor:[Toolbag colorFromHexString:@"#E89797"]]; //@"#D9917B"]];
	
	[[[self mainView] playerOneName] setText:[playerOne name]];
	[[[self mainView] playerTwoName] setText:[playerTwo name]];
	
	currentPlayer = playerOne;
	[[[self mainView] playerTurnAnimation] setBackgroundColor:[currentPlayer color]];
	return self;
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
	if ([player isEqual:playerOne]) {
		[[self mainView] animateTurnCircleTo: ([player isEqual:playerOne]) ? [[[self mainView] playerOneName] center] : [[[self mainView] playerTwoName] center] withColor:[player color]];
		[[self mainView] animateWin];
	}
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
