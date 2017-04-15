//
//  ViewController.m
//  Weather
//
//  Created by Djuro Alfirevic on 4/15/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "ViewController.h"
#import "Weather.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinnerView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *minTemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxTemperatureLabel;
@property (copy, nonatomic) NSString *yahooWoeidURL;
@property (copy, nonatomic) NSString *woeid;
@property (copy, nonatomic) NSString *yahooWeatherURL;
@property (strong, nonatomic) Weather *weather;
@end

@implementation ViewController

#pragma mark - Properties

- (void)setYahooWoeidURL:(NSString *)yahooWoeidURL {
    _yahooWoeidURL = yahooWoeidURL;
    
    NSLog(@"Yahoo Woeid URL: %@", yahooWoeidURL);
    
    dispatch_queue_t downloadQueue = dispatch_queue_create("YahooWoeidDownloader", NULL);
    dispatch_async(downloadQueue, ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:yahooWoeidURL]];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSError *serializationError;
                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];
                NSLog(@"Woeid: %@", dictionary[@"query"][@"results"][@"place"][@"woeid"]);
                
                self.woeid = dictionary[@"query"][@"results"][@"place"][@"woeid"];
                
                NSString *url = [NSString stringWithFormat:@"https://query.yahooapis.com/v1/public/yql?q=select * from weather.forecast where woeid=%@&format=json&diagnostics=true&callback=", self.woeid];
                url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                
                self.yahooWeatherURL = url;
            }
        });
    });
}

- (void)setYahooWeatherURL:(NSString *)yahooWeatherURL {
    _yahooWeatherURL = yahooWeatherURL;
    
    NSLog(@"Yahoo Weather URL: %@", yahooWeatherURL);
    
    [self updateWeather];
}

- (void)setWeather:(Weather *)weather {
    _weather = weather;

    self.imageView.image = [weather getWeatherImage];
    self.minTemperatureLabel.text = [weather getMinTemperatureString];
    self.maxTemperatureLabel.text = [weather getMaxTemperatureString];

    // weak self
    // We have to provider it, because, we will create retain cycle and we will have zombie object.
    __weak __typeof__(self) weakSelf = self;

    [UIView animateWithDuration:0.3f animations:^{
        weakSelf.imageView.alpha = 1.0f;
        weakSelf.maxTemperatureLabel.alpha = 1.0f;
        weakSelf.minTemperatureLabel.alpha = 1.0f;
        [weakSelf.spinnerView stopAnimating];
    }];
}

#pragma mark - Private API

- (void)updateWeather {
    self.imageView.alpha = 0.0f;
    self.maxTemperatureLabel.alpha = 0.0f;
    self.minTemperatureLabel.alpha = 0.0f;

    if (self.yahooWeatherURL.length > 0) {
        dispatch_queue_t downloadQueue = dispatch_queue_create("YahooWeatherDownloader", NULL);
        dispatch_async(downloadQueue, ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.yahooWeatherURL]];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (data) {
                    NSError *serializationError;
                    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&serializationError];

                    self.weather = [[Weather alloc] initWithDictionary:dictionary[@"query"][@"results"]];
                    NSLog(@"Weather: %@", dictionary);
                }
            });
        });
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *urlString = @"https://query.yahooapis.com/v1/public/yql?q=SELECT%20*%20FROM%20geo.places%20WHERE%20text%3D%22(";
    urlString = [urlString stringByAppendingFormat:@"%.4f", -37.8054];
    urlString = [urlString stringByAppendingString:@"%2C"];
    urlString = [urlString stringByAppendingFormat:@"%.4f", 144.9549];
    urlString = [urlString stringByAppendingString:@")%22&format=json"];
    
    self.yahooWoeidURL = urlString;
}

@end
