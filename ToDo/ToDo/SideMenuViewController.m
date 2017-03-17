//
//  SideMenuViewController.m
//  ToDo
//
//  Created by Djuro Alfirevic on 3/17/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "SideMenuViewController.h"
#import "SideMenuTableViewCell.h"

@interface SideMenuViewController() <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *itemsArray;
@end

@implementation SideMenuViewController

#pragma mark - Actions

- (IBAction)closeButtonTapped:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:CLOSE_SIDE_MENU_NOTIFICATION object:nil];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.itemsArray = @[@"Home", @"Walkthrough", @"Statistics", @"Add Task", @"Log Out"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SideMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    cell.subtitleLabel.hidden = (indexPath.row == 0) ? NO : YES;
    cell.subtitleLabel.text = [NSString stringWithFormat:@"%ld", [DATA_MANAGER numberOfTasksForToday]];
    cell.titleLabel.text = self.itemsArray[indexPath.row];

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
