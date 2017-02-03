//
//  ArticleTableViewCell.m
//  Vesti
//
//  Created by Djuro Alfirevic on 2/3/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "ArticleTableViewCell.h"

@implementation ArticleTableViewCell

#pragma mark - Properties

- (void)setArticle:(Article *)article {
    _article = article;

    self.titleLabel.text = article.title;
}

@end
