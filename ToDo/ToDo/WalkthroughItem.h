//
//  WalkthroughItem.h
//  ToDo
//
//  Created by Djuro Alfirevic on 3/24/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WalkthroughItem : NSObject
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *text;

- (instancetype)initWithImage:(UIImage *)image andText:(NSString *)text;
@end
