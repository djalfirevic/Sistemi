//
//  HomeViewController.m
//  Vesti
//
//  Created by Djuro Alfirevic on 2/3/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "HomeViewController.h"
#import "Article.h"

//#define URL @"http://www.brzevesti.net/api/news"
static NSString *const URL = @"http://www.brzevesti.net/api/news";

@interface HomeViewController()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *articlesArray;
@end

@implementation HomeViewController

#pragma mark - Private API

- (void)loadArticles {
    // Grand Central Dispatch (GCD)
    dispatch_queue_t downloadQueue = dispatch_queue_create("ArticlesDownloader", nil);
    dispatch_async(downloadQueue, ^{
        // This code will be executed on BACKGROUND thread
        NSURL *url = [NSURL URLWithString:URL];
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%@", url);
        NSLog(@"%@", dictionary);

        self.articlesArray = [[NSMutableArray alloc] init];

        for (NSDictionary *articleDictionary in dictionary[@"news"]) {
            Article *article = [[Article alloc] initWithDictionary:articleDictionary];
            [self.articlesArray addObject:article];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            // This code will be executed on MAIN thread
            [self.tableView reloadData];
        });
    });
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadArticles];
}

@end
