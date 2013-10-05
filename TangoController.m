//
//  TangoController.m
//  Tango
//
//  Created by Patrik Göthe on 10/5/13.
//  Copyright (c) 2013 Patrik Göthe & Ville Petersson. All rights reserved.
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
}

- (TangoController*) initWithView:(ViewController *)view{
	[self setMainView:view];
	boards = [Board getBoards];
	
	playerOne = [[Player alloc] initWithName:@"Patrik" andColor:[Toolbag colorFromHexString:@"#7EAAB4"]];
	playerTwo = [[Player alloc] initWithName:@"Simon" andColor:[Toolbag colorFromHexString:@"#C15B40"]];
	
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
		
		// Check board won
		if (![board isWon]) [board checkBoardWon];
		
		// switch active board to corresponding board
		Board *correspondingBoard = boards[[[board squares] indexOfObject:button]];
		if ([correspondingBoard isWon]) {
			[Board setAviabilityOfAllBoardsTo:true];
		}else{
			[Board setAviabilityOfAllBoardsTo:false exeptFor:correspondingBoard];
		}
		
		// Animate click
		[[self mainView] animateClick:button withColor:[currentPlayer color]];
		
		// Change color of button
		[button setBackgroundColor:[currentPlayer color]];
		
		
		// Switch player
		[self nextPlayer];
	}else{
		// NSLog(@"Board not avaliable or square occupied");
	}

}

- (Board*) getBoardFromButton:(SquareButton*)button {
	return boards[(([button buttonId]-1)/9)]; // magic equation
}

- (void) nextPlayer {
	if (currentPlayer == playerOne) {
		[[self mainView] animateTurnCircleTo:[[[self mainView] playerTwoName] center]];
		currentPlayer = playerTwo;
	}else{
		[[self mainView] animateTurnCircleTo:[[[self mainView] playerOneName] center]];
		currentPlayer = playerOne;
	}
	
	[[[self mainView] playerTurnAnimation] setBackgroundColor:[currentPlayer color]];
}



@end
