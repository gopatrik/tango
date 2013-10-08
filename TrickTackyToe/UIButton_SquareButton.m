//
//  UIButton_SquareButton.m
//  TrickTackyToe
//
//  Created by Patrik Göthe on 7/15/13.
//  Copyright (c) 2013 Patrik Göthe. All rights reserved.
//

#import "UIButton_SquareButton.h"

@implementation SquareButton

- (SquareButton*) initWithPosX:(int)posX andY:(int)posY {
	self = [super init];

	if(self){
		[self setGridX:posX];
		[self setGridY:posY];
		[self setIsOccupied:false];
	}
	return self;
}
@end
