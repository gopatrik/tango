//
//  Player.h
//  TrickTackyToe
//
//  Created by Patrik Göthe on 10/1/13.
//  Copyright (c) 2013 Patrik Göthe & Ville Petersson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) UIColor *color;

- (Player *) initWithName: (NSString*)name andColor:(UIColor*)color;

@end
