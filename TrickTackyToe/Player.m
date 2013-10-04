//
//  Player.m
//  TrickTackyToe
//
//  Created by Patrik Göthe on 10/1/13.
//  Copyright (c) 2013 Patrik Göthe & Ville Petersson. All rights reserved.
//

#import "Player.h"

@implementation Player 
-(Player*)initWithName:(NSString *)name andColor:(UIColor *)color {
	self = [super init];
	
	if(self){
		[self setColor:color];
		[self setName:name];
	}
	return self;
	
}
@end
