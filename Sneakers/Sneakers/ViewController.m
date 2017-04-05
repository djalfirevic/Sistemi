//
//  ViewController.m
//  Sneakers
//
//  Created by Djuro Alfirevic on 4/5/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "ViewController.h"
#import "Sneaker.h"
#import "SneakerCollectionViewCell.h"

@interface ViewController() <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) NSMutableArray *itemsArray;
@end

@implementation ViewController

#pragma mark - Properties

- (NSMutableArray *)itemsArray {
    if (!_itemsArray) {
        _itemsArray = [[NSMutableArray alloc] init];
    }
    
    return _itemsArray;
}

#pragma mark - Private API

- (void)createDummyData {
    Sneaker *nike = [[Sneaker alloc] initWithName:@"AIR HUARACHE UTILITY"
                                      description:@"The Nike Air Huarache Utility Men's Shoe toughers up a famous running shoe with a nylon upper, fused mudguard and vibrant detail."
                                     abbreviation:@"SAP "
                                        imageName:@"nike"
                                           gender:MALE_GENDER
                                            price:140];
    [self.itemsArray addObject:nike];
    
    Sneaker *puma = [[Sneaker alloc] initWithName:@"TAZON 5"
                                      description:@"The Puma's Tazon 5 Men's Shoe are cross\ntraining shoe with a leather \nmudguard and nylon detail."
                                     abbreviation:@"TFS"
                                        imageName:@"puma"
                                           gender:MALE_GENDER
                                            price:120];
    [self.itemsArray addObject:puma];
    
    Sneaker *reebok = [[Sneaker alloc] initWithName:@"CROSSFIT LIFTER"
                                        description:@"The Crossfit Lifeter Women's Shoe are cross\ntraining shoes with a space look \nand design."
                                       abbreviation:@"SBK"
                                          imageName:@"reebok"
                                             gender:FEMALE_GENDER
                                              price:150];
    [self.itemsArray addObject:reebok];
    
    self.pageControl.numberOfPages = self.itemsArray.count;
    [self.collectionView reloadData];
}

- (void)animateCell:(UICollectionViewCell *)cell {
    CGRect frame = cell.frame;
    CGPoint translation = [self.collectionView.panGestureRecognizer translationInView:self.collectionView.superview];
    if (translation.x > 0.0f) {
        cell.frame = CGRectMake(frame.origin.x - 1000.0f, -500.0f, 0.0f, 0.0f);
    } else {
        cell.frame = CGRectMake(frame.origin.x + 1000.0f, -500.0f, 0.0f, 0.0f);
    }
    
    [UIView animateWithDuration:0.5f animations:^(void){
        cell.frame = frame;
    }];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.alpha = 0.0f;
    self.pageControl.alpha = 0.0f;
    [self createDummyData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.3f animations:^{
        self.view.backgroundColor = [UIColor colorWithRed:67.0f/255.0f green:91.0f/255.0f blue:251.0f/255.0f alpha:1.0f];
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3f delay:0.0f usingSpringWithDamping:0.8f initialSpringVelocity:0.4f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.collectionView.alpha = 1.0f;
            self.pageControl.alpha = 1.0f;
        } completion:NULL];
    });
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SneakerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.sneaker = self.itemsArray[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [self animateCell:cell];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, collectionView.frame.size.height);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat x = self.collectionView.contentOffset.x;
    CGFloat width = self.collectionView.bounds.size.width;

    self.pageControl.currentPage = ceil(x/width);
}

@end
