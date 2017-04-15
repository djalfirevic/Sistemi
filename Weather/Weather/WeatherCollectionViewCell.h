//
//  WeatherCollectionViewCell.h
//  Weather
//
//  Created by Djuro Alfirevic on 4/15/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@end
