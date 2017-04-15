//
//  JSONNullChecker.h
//  Weather
//
//  Created by Djuro Alfirevic on 4/15/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONNullChecker : NSObject
+ (NSString *)parseSTRING:(id)object;
+ (BOOL)parseBOOL:(id)object;
+ (int)parseINT:(id)object;
+ (long long)parseLONG:(id)object;
+ (float)parseFLOAT:(id)object;
@end
