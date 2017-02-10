//
//  ViewController.m
//  Polimorfizam
//
//  Created by Djuro Alfirevic on 2/10/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "ViewController.h"
#import "ColorTableViewCell.h"

@interface ViewController() <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *itemsArray;
@end

@implementation ViewController

#pragma mark - Private API

- (void)configureArray {
    self.itemsArray = [[NSMutableArray alloc] init];
    [self.itemsArray addObject:@"ColorCell"];
    [self.itemsArray addObject:@"GreenCell"];
    [self.itemsArray addObject:@"ColorCell"];
    [self.itemsArray addObject:@"BlueCell"];
    [self.itemsArray addObject:@"ColorCell"];
    [self.itemsArray addObject:@"YellowCell"];
    [self.itemsArray addObject:@"ColorCell"];
    [self.itemsArray addObject:@"BlackCell"];
    [self.itemsArray addObject:@"ColorCell"];
    [self.itemsArray addObject:@"ColorCell"];
    [self.itemsArray addObject:@"ColorCell"];
    [self.itemsArray addObject:@"BlackCell"];

    [self.tableView reloadData];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.tableFooterView = [[UIView alloc] init];
    [self configureArray];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = self.itemsArray[indexPath.row];
    ColorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ColorTableViewCell *cell = (ColorTableViewCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];

    // [tableView cellForRowAtIndexPath:indexPath] -> Segue
    // [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    return [cell height];
}

@end
