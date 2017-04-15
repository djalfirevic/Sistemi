//
//  Weather.h
//  Weather
//
//  Created by Djuro Alfirevic on 4/15/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Weather : NSObject
@property (copy, nonatomic) NSString *title;
@property (nonatomic) NSInteger minTemperature;
@property (nonatomic) NSInteger maxTemperature;
@property (nonatomic) NSInteger temperature;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (NSString *)getMinTemperatureString;
- (NSString *)getMaxTemperatureString;
- (NSString *)getTemperatureString;
- (UIImage *)getWeatherImage;
@end
