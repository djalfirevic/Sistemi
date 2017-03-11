//
//  MessageTableViewCell.m
//  Viber
//
//  Created by Djuro Alfirevic on 3/11/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

#pragma mark - Properties

- (void)setMessage:(Message *)message {
    _message = message;
    
    self.messageLabel.text = message.text;
    self.timeLabel.text = [self getTime];
    
    self.messageView.clipsToBounds = YES;
    self.messageView.layer.cornerRadius = 5.0f;
}

#pragma mark - Private API

- (NSString *)getTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    
    return [dateFormatter stringFromDate:self.message.date];
}

@end
