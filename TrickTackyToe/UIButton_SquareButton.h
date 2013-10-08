//
//  UIButton_SquareButton.h
//  TrickTackyToe
//
//  Created by Patrik Göthe on 7/19/13.
//  Copyright (c) 2013 Patrik Göthe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@interface SquareButton: UIButton
@property (nonatomic) int gridX;
@property (nonatomic) int gridY;
@property (nonatomic) int buttonId;
@property (nonatomic) BOOL isOccupied;
@property (nonatomic) Player* occupator;

- (SquareButton *) initWithPosX: (int)posX andY:(int)posY;
@end
