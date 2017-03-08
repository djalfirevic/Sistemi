//
//  TaskViewController.m
//  ToDo
//
//  Created by Djuro Alfirevic on 2/22/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "TaskViewController.h"
#import <MapKit/MapKit.h>

@interface TaskViewController() <UITextFieldDelegate, DataManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mapImageView;
@property (weak, nonatomic) IBOutlet UIImageView *selectorImageView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *viewsArray;
@property (nonatomic) NSInteger group;
@end

@implementation TaskViewController

#pragma mark - Actions

- (IBAction)backButtonTapped:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addButtonTapped:(UIButton *)sender {
    if ([self validationPassed]) {
        [[DataManager sharedManager] saveTaskWithTitle:self.titleTextField.text
                                           description:self.descriptionTextField.text
                                                 group:self.group];

        [self backButtonTapped:nil];
    }
}

- (IBAction)groupButtonTapped:(UIButton *)sender {
    self.group = sender.tag;

    for (UIView *view in self.viewsArray) {
        if (view.tag == sender.tag) {
            [UIView animateWithDuration:kAnimationDuration animations:^{
                self.selectorImageView.center = view.center;
            }];
        }
    }
}

#pragma mark - Private API

- (BOOL)validationPassed {
    if (self.titleTextField.text.length == 0) {
        [self showAlertWithTitle:@"Error"
                      andMessage:@"Please enter task title"];
        return NO;
    }

    if (self.descriptionTextField.text.length == 0) {
        [self showAlertWithTitle:@"Error"
                      andMessage:@"Please enter task description"];
        return NO;
    }

    return YES;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.group = TaskGroupNotCompleted;
    self.locationLabel.text = [DataManager sharedManager].userLocality;

    // Via delegate
    [DataManager sharedManager].delegate = self;

    // Via notification
    [[NSNotificationCenter defaultCenter] addObserverForName:LOCALITY_UPDATED_NOTIFICATION object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        self.locationLabel.text = [DataManager sharedManager].userLocality;
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];

    return YES;
}

#pragma mark - DataManagerDelegate

- (void)dataManagerDidUpdateLocality {
    self.locationLabel.text = [DataManager sharedManager].userLocality;
}

@end
