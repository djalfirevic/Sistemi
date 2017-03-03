//
//  DBTask+Utilities.m
//  ToDo
//
//  Created by Djuro Alfirevic on 3/3/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "DBTask+Utilities.h"

@implementation DBTask (Utilities)

#pragma mark - Properties

- (UIColor *)groupColor {
    if (self.group == TaskGroupCompleted) {
        return kColorCompleted;
    } else if (self.group == TaskGroupNotCompleted) {
        return kColorNotCompleted;
    } else {
        return kColorInProgress;
    }
}

@end
