//
//  ViewController.h
//  TrickTackyToe
//
//  Created by Patrik Göthe on 7/14/13.
//  Copyright (c) 2013 Patrik Göthe & Ville Petersson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton_SquareButton.h"

@interface ViewController : UIViewController
@property IBOutlet UIView *mainView;
@property IBOutlet UILabel *playerOneName;
@property IBOutlet UILabel *playerTwoName;
@property IBOutlet UILabel *playerTurnAnimation;

@property IBOutlet UIView *playerDataView;

- (void) animateClick:(SquareButton*) button withColor:(UIColor*)color;
- (void) animateTurnCircleTo:(CGPoint)xy;
@end
