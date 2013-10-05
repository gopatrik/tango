//
//  TangoController.h
//  Tango
//
//  Created by Patrik Göthe on 10/5/13.
//  Copyright (c) 2013 Patrik Göthe & Ville Petersson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIButton_SquareButton.h"
#import "ViewController.h"

@interface TangoController : NSObject
@property (nonatomic) ViewController *mainView;

- (void) squarePressed:(SquareButton*) button;
- (TangoController*) initWithView:(ViewController*)view;
@end
