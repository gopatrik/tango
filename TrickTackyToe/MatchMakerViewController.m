//
//  MatchMakerViewController.m
//  Tango
//
//  Created by Patrik Göthe on 10/12/13.
//  Copyright (c) 2013 Patrik Göthe. All rights reserved.
//

#import "MatchMakerViewController.h"

@implementation MatchMakerViewController

- (MatchMakerViewController*) init {
	
	// Get friends to invite
	NSArray *friendIDs = [NSArray arrayWithObject: [[GKPlayer alloc] init].playerID];

	// set up match request
	GKMatchRequest *request = [[GKMatchRequest alloc] init];
	request.minPlayers = 2;
	request.maxPlayers = 2;
	
	request.playersToInvite = friendIDs;
	request.inviteMessage = @"lets do the tango";
	
	[GKTurnBasedMatch findMatchForRequest:request withCompletionHandler:^(GKTurnBasedMatch *match, NSError *error) {
		NSLog(@"%@",error);
	}];
	
	// listing matches make into listview
	[GKTurnBasedMatch loadMatchesWithCompletionHandler:^(NSArray *matches, NSError *error) {
		NSLog(@"%@",error);
	}];
	
	// removing match
	// [match removeWithCompletionhan...
	//ALternatavly use GKTurnbasedmatchmakerviewcontroller...

	return self;
}

@end
