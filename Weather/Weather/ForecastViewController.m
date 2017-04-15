//
//  ForecastViewController.m
//  Weather
//
//  Created by Djuro Alfirevic on 4/15/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "ForecastViewController.h"
#import "WeatherCollectionViewCell.h"
#import "TodayCollectionViewCell.h"

#define kTodayCellHeight 350.0f

@interface ForecastViewController() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@end

@implementation ForecastViewController

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.item == 0) {
        TodayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TodayCell" forIndexPath:indexPath];
        cell.weatherImageView.image = [UIImage imageNamed:@"weather_brokenclouds_day_light_big"];

        return cell;
    }

    WeatherCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WeatherCell" forIndexPath:indexPath];

    cell.dayLabel.text = [NSString stringWithFormat:@"Wednesday, May %ld", (long)indexPath.item];
    cell.temperatureLabel.text = [NSString stringWithFormat:@"2%ldº", (long)indexPath.item];

    switch (indexPath.item) {
        case 1:
            cell.weatherImageView.image = [UIImage imageNamed:@"weather_brokenclouds_day_light_big"];
            break;
        case 2:
            cell.weatherImageView.image = [UIImage imageNamed:@"weather_rain_day_light_big"];
            break;
        case 3:
            cell.weatherImageView.image = [UIImage imageNamed:@"weather_mist_day_light_big"];
            break;
        case 4:
            cell.weatherImageView.image = [UIImage imageNamed:@"weather_showerrain_night_light_big"];
            break;

        default:
            break;
    }

    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.item == 0) {
        return CGSizeMake(collectionView.frame.size.width, kTodayCellHeight);
    }

    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;

    return CGSizeMake(collectionView.frame.size.width, (screenHeight-kTodayCellHeight)/4);
}

@end
