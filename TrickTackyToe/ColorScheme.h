//
//  ColorScheme.h
//  Tango
//
//  Created by Patrik Göthe on 10/8/13.
//  Copyright (c) 2013 Patrik Göthe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorScheme : NSObject

@property UIColor *playerOneColor;
@property UIColor *playerTwoColor;
@property UIColor *backgroundColor;
@property UIColor *highlightColor;
@property UIColor *squareColor;
@property UIColor *boardBackgroundColor;

- (ColorScheme*) initWithPlayerOneColor: (NSString*)playerOneColor playerTwoColor:(NSString*)playerTwoColor backgroundColor:(NSString*)backgroundColor highlightColor:(NSString*)highlightColor squareColor:(NSString*)squareColor boardBackgroundColor:(NSString*)boardBackgroundColor;

@end
