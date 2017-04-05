//
//  SneakerCollectionViewCell.h
//  Sneakers
//
//  Created by Djuro Alfirevic on 4/5/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Sneaker;

@interface SneakerCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIImageView *gradientImageView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *abbreviationLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *wishlistButton;
@property (strong, nonatomic) Sneaker *sneaker;
@end
