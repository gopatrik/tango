//
//  GCTurnController.m
//  Tango
//
//  Created by Patrik Göthe on 10/12/13.
//  Copyright (c) 2013 Patrik Göthe. All rights reserved.
//

#import "GCTurnController.h"


@implementation GCTurnController {
	NSData *currentMatchData;
	GKTurnBasedMatch *currentMatch;
}

// Load current state
// Apply game logic
// save intermediate state, allows many devices
// choose next player sequence, fallback
// submit turn

- (GCTurnController *)initWithMatch:(GKTurnBasedMatch *)activeMatch {
	
	[activeMatch loadMatchDataWithCompletionHandler:^(NSData *matchData, NSError *error) {
		// present latest match state
		if (matchData) {
			currentMatchData = matchData;
		}else if (error){
			// handle
		}
	}];
	
	currentMatch = activeMatch;
	
	return self;
}

- (void) updateMatchData:(NSData*)currentData {
	// build new match data for intermediate state.. so that user can sync prepped data.
	[currentMatch saveCurrentTurnWithMatchData:currentData completionHandler:^(NSError *error) {
		//
	}];
}

- (void) setNextTurn {
	// update data
	
	// determine next player
	
	// custom localizable message
	// fallback if user not have your game installed
	// specify stri
	
	// Assemble the message key and args
	NSString *messageKey = [self turnMessageKey];
	NSString *strings[1];
	strings[0] = @"hjello";
	
	NSArray *messageArgs = [NSArray arrayWithObject:strings[0]];
	
	// set localizable message on match
	[currentMatch setLocalizableMessageWithKey:messageKey arguments:messageArgs];
	
	// send new game state to Game Center & pass turn, should not be messageargs here
	[currentMatch endTurnWithNextParticipants:messageArgs
								  turnTimeout:GKExchangeTimeoutDefault
									matchData:currentMatchData
							completionHandler:^(NSError *error) {  }];
}

- (NSString*) turnMessageKey {
	return @"i played this";
}


@end
