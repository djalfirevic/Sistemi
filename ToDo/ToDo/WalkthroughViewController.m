//
//  WalkthroughViewController.m
//  ToDo
//
//  Created by Djuro Alfirevic on 3/18/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "WalkthroughViewController.h"
#import "WalkthroughCollectionViewCell.h"
#import "WalkthroughItem.h"

@interface WalkthroughViewController() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) NSArray *itemsArray;
@end

@implementation WalkthroughViewController

#pragma mark - Actions

- (IBAction)closeButtonTapped:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.itemsArray = @[
                        [[WalkthroughItem alloc] initWithImage:[UIImage imageNamed:@"calendar"] andText:@"Keep your work organized and quickly check your reminders with simple calendar."],
                        [[WalkthroughItem alloc] initWithImage:[UIImage imageNamed:@"phone"] andText:@"Manage your tasks quick and easy from your phone"],
                        [[WalkthroughItem alloc] initWithImage:[UIImage imageNamed:@"tasks"] andText:@"Quickly add tasks from home screen"]
                        ];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WalkthroughCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    cell.item = self.itemsArray[indexPath.item];

    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // We're adding this in order for pageControl to work properly when switching currentPage.
    CGFloat x = self.collectionView.contentOffset.x;
    CGFloat width = self.collectionView.bounds.size.width;

    self.pageControl.currentPage = ceil(x/width);
}

@end
