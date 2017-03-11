//
//  Message.h
//  Viber
//
//  Created by Djuro Alfirevic on 3/11/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SenderType) {
    SenderTypeMe,
    SenderTypeHim
};

@interface Message : NSObject
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSDate *date;
@property (nonatomic) SenderType senderType;

- (instancetype)initWithText:(NSString *)text andSenderType:(SenderType)type;
@end
