//
//  ArticleTableViewCell.h
//  Vesti
//
//  Created by Djuro Alfirevic on 2/3/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

@interface ArticleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) Article *article;
@end
