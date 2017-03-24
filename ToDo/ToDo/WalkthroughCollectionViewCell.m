//
//  WalkthroughCollectionViewCell.m
//  ToDo
//
//  Created by Djuro Alfirevic on 3/24/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "WalkthroughCollectionViewCell.h"

@implementation WalkthroughCollectionViewCell

#pragma mark - Properties

- (void)setItem:(WalkthroughItem *)item {
    _item = item;

    self.imageView.image = item.image;
    self.label.text = item.text;
}

@end
