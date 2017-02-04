//
//  HomeViewController.m
//  Vesti
//
//  Created by Djuro Alfirevic on 2/3/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "HomeViewController.h"
#import "Article.h"
#import "ArticleTableViewCell.h"

//#define URL @"http://www.brzevesti.net/api/news"
static NSString *const URL = @"http://www.brzevesti.net/api/news";

@interface HomeViewController() <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *itemsArray;
@end

@implementation HomeViewController

#pragma mark - Private API

- (void)loadArticles {
    // Grand Central Dispatch (GCD)
    dispatch_queue_t downloadQueue = dispatch_queue_create("ArticlesDownloader", NULL);
    dispatch_async(downloadQueue, ^{
        // This code will be executed on BACKGROUND thread
        NSURL *url = [NSURL URLWithString:URL];
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

        self.itemsArray = [[NSMutableArray alloc] init];

        for (NSDictionary *articleDictionary in dictionary[@"news"]) {
            Article *article = [[Article alloc] initWithDictionary:articleDictionary];
            [self.itemsArray addObject:article];
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

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.article = self.itemsArray[indexPath.row];

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
