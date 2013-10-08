//
//  Toolbag.h
//  Tango
//
//  Created by Patrik Göthe on 10/3/13.
//  Copyright (c) 2013 Patrik Göthe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Toolbag : NSObject

@property UIColor* playerOneColor;


+ (UIColor*)colorFromHexString:(NSString *) hexString;
@end
