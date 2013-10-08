//
//  ColorScheme.m
//  Tango
//
//  Created by Patrik Göthe on 10/8/13.
//  Copyright (c) 2013 Patrik Göthe. All rights reserved.
//

#import "ColorScheme.h"
#import "Toolbag.h"

@implementation ColorScheme

- (ColorScheme*) initWithPlayerOneColor: (NSString*)playerOneColor playerTwoColor:(NSString*)playerTwoColor backgroundColor:(NSString*)backgroundColor highlightColor:(NSString*)highlightColor squareColor:(NSString*)squareColor boardBackgroundColor:(NSString*)boardBackgroundColor {
	
	[self setPlayerOneColor: [Toolbag colorFromHexString:playerOneColor]];
	[self setPlayerTwoColor: [Toolbag colorFromHexString:playerTwoColor]];
	[self setBackgroundColor: [Toolbag colorFromHexString:backgroundColor]];
	[self setHighlightColor: [Toolbag colorFromHexString:highlightColor]];
	[self setSquareColor: [Toolbag colorFromHexString:squareColor]];
	[self setBoardBackgroundColor: [Toolbag colorFromHexString:boardBackgroundColor]];

	return self;
}

@end
