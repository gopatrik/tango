//
//  Board.m
//  Tango
//
//  Created by Patrik Göthe on 10/1/13.
//  Copyright (c) 2013 Patrik Göthe & Ville Petersson. All rights reserved.
//

#import "Board.h"
#import "Toolbag.h"

@implementation Board

static UIColor *squareColor;
static NSMutableArray *boards;

- (id)init
{
    self = [super init];
	
    if (self) {
		squareColor = [Toolbag colorFromHexString:@"#fcfcfc"];
		
		int squareSideCount = 3;
		[self setSquares:[[NSMutableArray alloc] initWithCapacity:squareSideCount*squareSideCount]];

		BOOL even = false;
		for (int row = 0; row<squareSideCount; row++) {
			for (int col = 0; col<squareSideCount; col++) {
				SquareButton *button = [[SquareButton alloc] initWithPosX:row andY:col];
				[button setBackgroundColor: squareColor];
				even=!even;
				
				
				// add
				[[self squares] addObject:button];
			}
		}
		[self setIsAvaliable:true];
		if(!boards){
			boards = [[NSMutableArray alloc] initWithCapacity:9];
		}
		[boards addObject:self];
		

    }
    return self;
}

+ (void) setAviabilityOfAllBoardsTo:(BOOL)avaliable {
	for (Board *board in boards) {
		BOOL previous = [board isAvaliable];
		[board setIsAvaliable:avaliable];
		if(avaliable){
			[self lightUpBoard:board];
		}else if(previous != avaliable){ // make board inactive if was previously active
			[self delightBoard:board];
		}
	}
}

+ (void) setAviabilityOfAllBoardsTo:(BOOL)avaliable exeptFor:(Board *)board	{
	[self setAviabilityOfAllBoardsTo:avaliable];
	[board setIsAvaliable:!avaliable];
	if(!avaliable){
		[self lightUpBoard:board];
	}
}

+ (void) lightUpBoard: (Board*)board {
	for (SquareButton *sq in [board squares]) {
		if(![sq isOccupied]){
			[UIView animateWithDuration:0.1 animations:^{
				[sq setBackgroundColor: [Toolbag colorFromHexString:@"#A7EFDB"]];
			} completion:NO];
		}
	}
}

+ (void) delightBoard: (Board*)board {
	for (SquareButton *sq in [board squares]) {
		if(![sq isOccupied]){
			[UIView animateWithDuration:0.1 animations:^{
				[sq setBackgroundColor: squareColor];
			} completion:NO];
		}
	}
}

+ (NSMutableArray*) getBoards {
	return boards;
}

- (void) checkBoardWon {
	
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
			NSLog(@"board won!");
			[self setIsWon:true];
		}
	}
}

// Check if three squares has same owner
- (BOOL) hasSameOwner: (int)first as:(int)second and:(int)third {
	Player *p = [[self squares][first] occupator];
	if([p isEqual: [[self squares][second] occupator]]){
		return [p isEqual:[[self squares][third] occupator]];
	}
	return false;
}

@end
