//
//  ViewController.m
//  Delegat
//
//  Created by Djuro Alfirevic on 3/4/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "ViewController.h"
#import "Client.h"
#import "Worker.h"

@implementation ViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    Client *client = [[Client alloc] init];
    Worker *worker = [[Worker alloc] init];
    [client hire:worker];

    [client giveNotice];
}

@end
