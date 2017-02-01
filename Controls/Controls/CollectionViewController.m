//
//  CollectionViewController.m
//  Controls
//
//  Created by Djuro Alfirevic on 2/1/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "CollectionViewController.h"
#import "CityCollectionViewCell.h"
#import "City.h"

@interface CollectionViewController() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *southCitiesArray;
@end

@implementation CollectionViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    City *vranje = [[City alloc] initWithName:@"Vranje"
                                   population:@"20.000"];
    City *beograd = [[City alloc] initWithName:@"Beograd"
                                    population:@"2.000.000"];
    City *noviSad = [[City alloc] initWithName:@"Novi Sad"
                                    population:@"1.000.000"];
    City *smederevo = [[City alloc] initWithName:@"Smederevo"
                                      population:@"500.000"];
    self.southCitiesArray = @[vranje, beograd, noviSad, smederevo];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.southCitiesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.city = self.southCitiesArray[indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    City *city = self.southCitiesArray[indexPath.row];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"City" message:city.name preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {
                                                         NSLog(@"Clicked on: %@", city.name);
                                                     }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = collectionView.frame.size.width/4 - 30.0f;
    CGFloat height = 50.0f;
    return CGSizeMake(width, height);
}

@end
