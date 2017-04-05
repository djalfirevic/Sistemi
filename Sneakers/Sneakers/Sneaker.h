//
//  Sneaker.h
//  Sneakers
//
//  Created by Djuro Alfirevic on 4/5/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, Gender) {
    MALE_GENDER = 0,
    FEMALE_GENDER
};

@interface Sneaker : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) NSString *abbreviation;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImage *logoImage;
@property (nonatomic) Gender gender;
@property (nonatomic) NSInteger price;

- (instancetype)initWithName:(NSString *)name
                 description:(NSString *)desc
                abbreviation:(NSString *)abbreviation
                   imageName:(NSString *)imageName
                      gender:(Gender)gender
                       price:(NSInteger)price;
- (NSString *)formattedPrice;
- (NSString *)formattedGender;
@end
