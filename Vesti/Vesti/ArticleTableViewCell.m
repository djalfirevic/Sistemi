//
//  ArticleTableViewCell.m
//  Vesti
//
//  Created by Djuro Alfirevic on 2/3/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "ArticleTableViewCell.h"
#import "UIImageView+Utilities.h"

@interface ArticleTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *portalLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@end

@implementation ArticleTableViewCell

#pragma mark - Properties

- (void)setArticle:(Article *)article {
    _article = article;

    self.titleLabel.text = article.title;
    self.portalLabel.text = article.portal;
    self.coverImageView.layer.cornerRadius = self.coverImageView.frame.size.width/2;
    [self.coverImageView loadImageFromURL:article.imageURL];
}

@end
