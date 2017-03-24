//
//  WalkthroughItem.m
//  ToDo
//
//  Created by Djuro Alfirevic on 3/24/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "WalkthroughItem.h"

@implementation WalkthroughItem

#pragma mark - Designated Initializer

- (instancetype)initWithImage:(UIImage *)image andText:(NSString *)text {
    if (self = [super init]) {
        self.image = image;
        self.text = text;
    }

    return self;
}

@end
