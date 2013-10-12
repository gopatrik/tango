//
//  GCTurnController.h
//  Tango
//
//  Created by Patrik Göthe on 10/12/13.
//  Copyright (c) 2013 Patrik Göthe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface GCTurnController : NSObject
- (GCTurnController*) initWithMatch:(GKTurnBasedMatch*)activeMatch;
@end
