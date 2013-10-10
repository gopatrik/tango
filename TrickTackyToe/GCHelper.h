//
//  GCHelper.h
//  Tango
//
//  Created by Patrik Göthe on 10/10/13.
//  Copyright (c) 2013 Patrik Göthe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface GCHelper : NSObject {
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
}

@property (assign, readonly) BOOL gameCenterAvailable;

+ (GCHelper *)sharedInstance;
- (void)authenticateLocalUser;

@end