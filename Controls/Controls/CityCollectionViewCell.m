//
//  CityCollectionViewCell.m
//  Controls
//
//  Created by Djuro Alfirevic on 2/1/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "CityCollectionViewCell.h"

@interface CityCollectionViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@end

@implementation CityCollectionViewCell

#pragma mark - Properties

- (void)setCity:(City *)city {
    _city = city;
    
    self.titleLabel.text = city.name;
    self.subtitleLabel.text = city.population;
}

@end
