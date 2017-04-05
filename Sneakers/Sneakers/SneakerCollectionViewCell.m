//
//  SneakerCollectionViewCell.m
//  Sneakers
//
//  Created by Djuro Alfirevic on 4/5/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "SneakerCollectionViewCell.h"
#import "Sneaker.h"

static CGFloat DegreesToRadians(CGFloat degrees) { return degrees * M_PI / 180; };

@implementation SneakerCollectionViewCell

#pragma mark - Properties

- (void)setSneaker:(Sneaker *)sneaker {
    _sneaker = sneaker;
    
    self.logoImageView.image = sneaker.logoImage;
    self.priceLabel.text = [sneaker formattedPrice];
    self.titleLabel.text = sneaker.name;
    self.descriptionLabel.text = sneaker.desc;
    self.genderLabel.text = [sneaker formattedGender];
    
    // Abbreviation
    self.abbreviationLabel.lineBreakMode = NSLineBreakByClipping;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:sneaker.abbreviation];
    [attributedString addAttribute:NSKernAttributeName
                             value:@(15.0f)
                             range:NSMakeRange(0, attributedString.length)];
    [attributedString addAttribute:NSFontAttributeName
                             value:self.abbreviationLabel.font
                             range:NSMakeRange(0, attributedString.length)];
    
    self.abbreviationLabel.attributedText = attributedString;
    
    // Container
    self.containerView.layer.cornerRadius = 10.0f;
    self.containerView.clipsToBounds = NO;
    self.containerView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.containerView.layer.shadowOffset = CGSizeZero;
    self.containerView.layer.shadowRadius = 5.0f;
    self.containerView.layer.shadowOpacity = 0.4f;
    self.gradientImageView.layer.cornerRadius = 10.0f;
    self.gradientImageView.clipsToBounds = YES;
    
    // Image
    self.imageView.image = sneaker.image;
    [self rotateView:self.imageView byDegree:10.0f];
    self.imageView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.imageView.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    self.imageView.layer.shadowRadius = 5.0f;
    self.imageView.layer.shadowOpacity = 0.8f;
    
    // Wishlist
    self.wishlistButton.layer.borderColor = [UIColor colorWithRed:67.0f/255.0f green:91.0f/255.0f blue:251.0f/255.0f alpha:1.0f].CGColor;
    self.wishlistButton.layer.borderWidth = 2.0f;
    self.wishlistButton.layer.cornerRadius = self.wishlistButton.bounds.size.height/2;
}

#pragma mark - Private API

- (void)rotateView:(UIView *)view byDegree:(CGFloat)degrees {
    CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
    view.transform = t;
}

@end
