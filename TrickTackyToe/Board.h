//
//  Board.h
//  Tango
//
//  Created by Patrik Göthe on 10/1/13.
//  Copyright (c) 2013 Patrik Göthe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIButton_SquareButton.h"
#import "Player.h"

@interface Board : NSObject
@property NSMutableArray *squares;
@property (nonatomic) BOOL isAvaliable;
@property (nonatomic) BOOL isWon;
@property (nonatomic) Player *wonBy;

- (void) delightBoard;
+ (void) setAviabilityOfAllBoardsTo:(BOOL)avaliable;
+ (void) setAviabilityOfAllBoardsTo:(BOOL)avaliable exeptFor:(Board*)board;
+ (NSMutableArray*) getBoards;

- (void) checkBoardWon;
@end
