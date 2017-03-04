//
//  Client.m
//  Delegat
//
//  Created by Djuro Alfirevic on 3/4/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "Client.h"

@implementation Client

#pragma mark - Public API

- (void)hire:(Worker *)worker {
    self.delegate = worker;
}

- (void)giveNotice {
    NSLog(@"Firing workers...");

    if (self.delegate) {
        [self.delegate didReceiveNotice];
    }
}

@end
