//
//  HomeViewController.m
//  ToDo
//
//  Created by Djuro Alfirevic on 2/11/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "HomeViewController.h"
#import "TaskViewController.h"
#import "DateCollectionViewCell.h"
#import "TaskTableViewCell.h"

#define kSearchTextViewHeight 64.0f

@interface HomeViewController() <UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UIImageView *filterImageView;
@property (weak, nonatomic) IBOutlet UILabel *tasksLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthYearLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchTextFieldViewTopConstraint;
@property (strong, nonatomic) NSMutableArray *datesArray;
@property (strong, nonatomic) NSMutableArray *tasksArray;
@property (strong, nonatomic) NSMutableArray *filteredTasksArray;
@property (strong, nonatomic) NSDate *selectedDate;
@property (strong, nonatomic) DBTask *selectedTask;
@property (nonatomic, readonly) BOOL filterActive;
@end

@implementation HomeViewController

#pragma mark - Properties

- (NSMutableArray *)datesArray {
    if (!_datesArray) {
        _datesArray = [[NSMutableArray alloc] init];
    }

    return _datesArray;
}

- (NSMutableArray *)filteredTasksArray {
    if (!_filteredTasksArray) {
        _filteredTasksArray = [[NSMutableArray alloc] init];
    }

    return _filteredTasksArray;
}

- (void)setSelectedDate:(NSDate *)selectedDate {
    _selectedDate = selectedDate;

    [self configureCalendar];
    [self configureTasks];
}

- (BOOL)filterActive {
    return self.searchTextField.text.length > 0;
}

#pragma mark - Actions

- (IBAction)menuButtonTapped {
    [[NSNotificationCenter defaultCenter] postNotificationName:OPEN_SIDE_MENU_NOTIFICATION object:nil];
}

- (IBAction)searchButtonTapped {
    self.searchTextFieldViewTopConstraint.constant = 0.0f;
    [UIView animateWithDuration:kAnimationDuration animations:^{
        [self.view layoutIfNeeded];
    }];

    [self.searchTextField becomeFirstResponder];
}

- (IBAction)previousButtonTapped {
    [self updateMonth:-1];
}

- (IBAction)nextButtonTapped {
    [self updateMonth:1];
}

- (IBAction)userImageViewTapped:(UITapGestureRecognizer *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Choose source:" message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    // Photo Library
    UIAlertAction *photoLibraryAction = [UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        if (picker) {
            picker.allowsEditing = YES;
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:nil];
        }
    }];
    [alertController addAction:photoLibraryAction];

    // Camera
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            if (picker) {
                picker.allowsEditing = YES;
                picker.delegate = self;
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:picker animated:YES completion:nil];
            }
        }];
        [alertController addAction:cameraAction];
    }

    // Cancel
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];

    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)searchTextFieldEditingChanged:(UITextField *)sender {
    [self performSearchWithText:sender.text];
}

#pragma mark - Private API

- (void)configureWelcomeLabel {
    if ([Helpers isMorning]) {
        self.welcomeLabel.text = @"Good Morning!";
    } else {
        self.welcomeLabel.text = @"Good Afternoon!";
    }
}

- (void)configureTasks {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = DATE_FORMAT;

    NSString *filter = [NSString stringWithFormat:@"date LIKE '%@'", [dateFormatter stringFromDate:self.selectedDate]];

    self.tasksArray = [DATA_MANAGER fetchEntity:NSStringFromClass(DBTask.class) withFilter:filter withSortAsc:YES forKey:@"date"];
    [self.tableView reloadData];

    [self configureTasksLabel];
}

- (void)configureTasksLabel {
    self.tasksLabel.text = [NSString stringWithFormat:@"%ld", self.tasksArray.count];
    self.tasksLabel.hidden = (self.tasksArray.count == 0) ? YES : NO;
}

- (void)configureCalendar {
    [self.datesArray removeAllObjects];
    self.monthYearLabel.text = [Helpers valueFrom:self.selectedDate withFormat:@"MMMM yyyy"].uppercaseString;

    NSInteger days = [Helpers numberOfDaysInMonthForDate:self.selectedDate];

    for (int i = 1; i <= days; i++) {
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *dateComponents = [calendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:self.selectedDate];
        dateComponents.day = i;
        NSDate *date = [calendar dateFromComponents:dateComponents];
        [self.datesArray addObject:date];
    }

    [self.collectionView reloadData];
    [self performSelector:@selector(scrollToCurrentDay) withObject:nil afterDelay:0.25];
}

- (void)configureUserImage {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:USER_IMAGE]) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:USER_IMAGE];
        UIImage *image = [[UIImage alloc] initWithData:data];
        self.userImageView.image = image;
    }
}

- (void)configurePlaceholder {
    NSDictionary *attributes = @{ NSForegroundColorAttributeName: [UIColor whiteColor] };

    self.searchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.searchTextField.placeholder attributes:attributes];
}

- (void)scrollToCurrentDay {
    NSInteger currentDay = [[NSCalendar currentCalendar] component:NSCalendarUnitDay fromDate:self.selectedDate];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:currentDay-1 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void)updateMonth:(NSInteger)value {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:self.selectedDate];
    dateComponents.day = 1;
    dateComponents.month += value;

    self.selectedDate = [calendar dateFromComponents:dateComponents];
}

- (void)performSearchWithText:(NSString *)text {
    self.filterImageView.hidden = (text.length > 0) ? NO : YES;

    // Remove all tasks from filteredTasksArray.
    [self.filteredTasksArray removeAllObjects];

    // Find tasks containing search text.
    for (DBTask *task in self.tasksArray) {
        if ([task.title containsString:text]) {
            [self.filteredTasksArray addObject:task];
        }
    }

    // Reload table view.
    [self.tableView reloadData];
}

- (DBTask *)taskForIndexPath:(NSIndexPath *)indexPath {
    return (self.filterActive) ? self.filteredTasksArray[indexPath.row] : self.tasksArray[indexPath.row];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self configureWelcomeLabel];
    [self configureUserImage];
    [self configurePlaceholder];
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.selectedDate = [NSDate date];
    self.selectedTask = nil;
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // if ([segue.identifier isEqualToString:@"TaskSegue"]) {
    if ([segue.destinationViewController isKindOfClass:TaskViewController.class]) {
        TaskViewController *toViewController = segue.destinationViewController;
        toViewController.task = self.selectedTask;
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.date = self.datesArray[indexPath.row];

    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedDate = self.datesArray[indexPath.item];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.filterActive) {
        return self.filteredTasksArray.count;
    }

    return self.tasksArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    cell.task = [self taskForIndexPath:indexPath];

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    self.selectedTask = [self taskForIndexPath:indexPath];
    [self performSegueWithIdentifier:@"TaskSegue" sender:nil];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        DBTask *task = [self taskForIndexPath:indexPath];

        if (self.filterActive) {
            [self.filteredTasksArray removeObject:task];
        } else {
            [self.tasksArray removeObject:task];
        }

        [DATA_MANAGER deleteObject:task];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [self configureTasksLabel];
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }

    self.userImageView.image = image;

    // Store image to NSUserDefaults
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:USER_IMAGE];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];

    // Hide Search Text Field View.
    self.searchTextFieldViewTopConstraint.constant = -kSearchTextViewHeight;
    [UIView animateWithDuration:kAnimationDuration animations:^{
        [self.view layoutIfNeeded];
    }];

    return YES;
}

@end
