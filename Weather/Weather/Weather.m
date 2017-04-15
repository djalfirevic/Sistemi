//
//  Weather.m
//  Weather
//
//  Created by Djuro Alfirevic on 4/15/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "Weather.h"
#import "JSONNullChecker.h"

@interface Weather()
@property (nonatomic) float divisor;
@property (nonatomic) NSInteger code;
@property (nonatomic) BOOL isFahrenheit;
@end

@implementation Weather

#pragma mark - Properties

- (float)divisor {
    return self.isFahrenheit ? 1.0f : 3.719f;
}

#pragma mark - Designated Initializer

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        //NSLog(@"%@", dictionary);
        
        if ([dictionary isKindOfClass:[NSDictionary class]]) {
            self.title = [JSONNullChecker parseSTRING:dictionary[@"channel"][@"location"][@"city"]];
            self.minTemperature = [JSONNullChecker parseINT:dictionary[@"channel"][@"item"][@"forecast"][0][@"low"]];
            self.maxTemperature = [JSONNullChecker parseINT:dictionary[@"channel"][@"item"][@"forecast"][0][@"high"]];
            self.temperature = [JSONNullChecker parseINT:dictionary[@"channel"][@"item"][@"condition"][@"temp"]];
            self.code = [JSONNullChecker parseINT:dictionary[@"channel"][@"item"][@"condition"][@"code"]];
        }
    }
    
    return self;
}

#pragma mark - Public API

- (NSString *)getMinTemperatureString {
    NSInteger minTemperature = self.minTemperature;
    minTemperature = minTemperature/self.divisor;
    return [NSString stringWithFormat:@"%ld%@", (long)minTemperature, [self suffix]];
}

- (NSString *)getMaxTemperatureString {
    NSInteger maxTemperature = self.maxTemperature;
    maxTemperature = maxTemperature/self.divisor;
    return [NSString stringWithFormat:@"%ld%@", (long)maxTemperature, [self suffix]];
}

- (NSString *)getTemperatureString {
    NSInteger temperature = self.temperature;
    temperature = temperature/self.divisor;
    return [NSString stringWithFormat:@"%ldº", (long)temperature];
}

- (UIImage *)getWeatherImage {
    // Rain
    if ([@[@5, @6, @7, @8, @9, @10, @35] containsObject:[NSNumber numberWithInteger:self.code]]) {
        if ([self isDay]) {
            return [UIImage imageNamed:@"weather_rain_day_light_big"];
        } else {
            return [UIImage imageNamed:@"weather_rain_night_light_big"];
        }
    }
    
    // Shower rain
    if ([@[@11, @12, @40] containsObject:[NSNumber numberWithInteger:self.code]]) {
        if ([self isDay]) {
            return [UIImage imageNamed:@"weather_rain_day_showerrain_day_light_big"];
        } else {
            return [UIImage imageNamed:@"weather_rain_day_showerrain_night_light_big"];
        }
    }
    
    // Mist
    if ([@[@19, @20, @21, @22] containsObject:[NSNumber numberWithInteger:self.code]]) {
        if ([self isDay]) {
            return [UIImage imageNamed:@"weather_mist_day_light_big"];
        } else {
            return [UIImage imageNamed:@"weather_mist_night_light_big"];
        }
    }
    
    // Broken clouds (night)
    if ([@[@25, @26, @27] containsObject:[NSNumber numberWithInteger:self.code]]) {
        return [UIImage imageNamed:@"weather_brokenclouds_night_light_big"];
    }
    
    // Broken clouds (day)
    if ([@[@25, @26, @27] containsObject:[NSNumber numberWithInteger:self.code]]) {
        return [UIImage imageNamed:@"weather_brokenclouds_day_light_big"];
    }
    
    // Few clouds (night)
    if ([@[@29, @33] containsObject:[NSNumber numberWithInteger:self.code]]) {
        return [UIImage imageNamed:@"weather_fewclouds_night_light_big"];
    }
    
    // Few clouds (day)
    if ([@[@30, @34, @44] containsObject:[NSNumber numberWithInteger:self.code]]) {
        return [UIImage imageNamed:@"weather_fewclouds_day_light_big"];
    }
    
    // Clear sky (night)
    if ([@[@31] containsObject:[NSNumber numberWithInteger:self.code]]) {
        return [UIImage imageNamed:@"weather_clearsky_night_light_big"];
    }
    
    // Clear sky (day)
    if ([@[@23, @24, @32, @36] containsObject:[NSNumber numberWithInteger:self.code]]) {
        return [UIImage imageNamed:@"weather_clearsky_day_light_big"];
    }
    
    // Thunderstorm
    if ([@[@0, @1, @2, @3, @4, @37, @38, @39, @45, @47] containsObject:[NSNumber numberWithInteger:self.code]]) {
        if ([self isDay]) {
            return [UIImage imageNamed:@"weather_thunderstorm_day_light_big"];
        } else {
            return [UIImage imageNamed:@"weather_thunderstorm_night_light_big"];
        }
    }
    
    // Snow
    if ([@[@13, @14, @15, @16, @17, @18, @41, @42, @43, @46] containsObject:[NSNumber numberWithInteger:self.code]]) {
        if ([self isDay]) {
            return [UIImage imageNamed:@"weather_snow_day_light_big"];
        } else {
            return [UIImage imageNamed:@"weather_snow_night_light_big"];
        }
    }
    
    return [UIImage imageNamed:@"weather_fewclouds_day_light_big"];
}

#pragma mark - Private API

- (NSString *)suffix {
    return self.isFahrenheit ? @"ºF" : @"ºC";
}

- (BOOL)isDay {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    NSString *time = [dateFormatter stringFromDate:[NSDate date]];
    
    NSArray *listItems = [time componentsSeparatedByString:@":"];
    NSString *hours = [listItems objectAtIndex:0];
    
    int h = [hours intValue];
    
    if (h > 6 && h <=22) {
        return YES;
    }
    
    return NO;
}

@end
