//
//  Sneaker.m
//  Sneakers
//
//  Created by Djuro Alfirevic on 4/5/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "Sneaker.h"

@implementation Sneaker

#pragma mark - Designated Initializer

- (instancetype)initWithName:(NSString *)name
                 description:(NSString *)desc
                abbreviation:(NSString *)abbreviation
                   imageName:(NSString *)imageName
                      gender:(Gender)gender
                       price:(NSInteger)price {
    if (self = [super init]) {
        self.name = name;
        self.desc = desc;
        self.abbreviation = abbreviation;
        self.gender = gender;
        
        self.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_shoes", imageName]];
        self.logoImage = [UIImage imageNamed:imageName];
        
        self.price = price;
    }
    
    return self;
}

#pragma mark - Public API

- (NSString *)formattedPrice {
    return [NSString stringWithFormat:@"$%ld", self.price];
}

- (NSString *)formattedGender {
    return self.gender == MALE_GENDER ? @"MEN'S SHOE" : @"WOMEN'S SHOE";
 }

@end
