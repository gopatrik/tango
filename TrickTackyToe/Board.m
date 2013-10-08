//
//  Board.m
//  Tango
//
//  Created by Patrik Göthe on 10/1/13.
//  Copyright (c) 2013 Patrik Göthe. All rights reserved.
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
			[board lightUpBoard];
		}else if(previous != avaliable){ // make board inactive if was previously active
			[board delightBoard];
		}
	}
}

+ (void) setAviabilityOfAllBoardsTo:(BOOL)avaliable exeptFor:(Board *)board	{
	[self setAviabilityOfAllBoardsTo:avaliable];
	[board setIsAvaliable:!avaliable];
	if(!avaliable){
		[board lightUpBoard];
	}
}

- (void) lightUpBoard {
	if (![self isWon]) {
		for (SquareButton *sq in [self squares]) {
			if(![sq isOccupied]){
				[UIView animateWithDuration:0.1 animations:^{
					[sq setBackgroundColor: [Toolbag colorFromHexString:@"#BBDCCC"]];//A7EFDB
				} completion:NO];
			}
		}
	}
}

- (void) delightBoard {
	// generate brighter color
	UIColor *colBright;
	if ([self isWon]) {
		colBright = [self brightenColor:[[self wonBy] color] by:60];
	}
	
	for (SquareButton *sq in [self squares]) {
		if(![sq isOccupied]){
			[sq setBackgroundColor:  ([self isWon]) ? colBright : squareColor];
		}else if([self isWon] && ![[self wonBy] isEqual:[sq occupator]]){
			// [sq setBackgroundColor: [self brightenColor:[[sq occupator] color] by:80]];
			// [sq setBackgroundColor: [self brightenColor:[[[sq occupator] color] colorWithAlphaComponent:0.1] by:80]];
			[sq setBackgroundColor: [[self wonBy] color]];
		}
	}
}

// brightness between 0 and 255
- (UIColor*) brightenColor: (UIColor*)color by: (CGFloat)brightness {
	CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
	[color getRed:&red green:&green blue:&blue alpha:&alpha];

	red = red + (brightness/255.0);
	green = green + (brightness/255.0);
	blue = blue + (brightness/255.0);

	return [UIColor colorWithRed:red green:green blue:blue alpha:1];
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
			[self setIsWon:true];
			[self delightBoard];
		}
	}
}

- (void) colorBoard: (UIColor*)color {
	for (SquareButton *sq in [self squares]) {
		[sq setBackgroundColor:color];
	}
}

// Check if three squares has same owner
- (BOOL) hasSameOwner: (int)first as:(int)second and:(int)third {
	Player *p = [[self squares][first] occupator];
	if([p isEqual: [[self squares][second] occupator]]){
		if ([p isEqual:[[self squares][third] occupator]]) {
			[self setWonBy:p];
			return true;
		}
	}
	return false;
}

@end
