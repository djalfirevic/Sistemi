//
//  WalkthroughCollectionViewCell.h
//  ToDo
//
//  Created by Djuro Alfirevic on 3/24/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WalkthroughItem.h"

@interface WalkthroughCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) WalkthroughItem *item;
@end
