//
//  ViewController.m
//  Viber
//
//  Created by Djuro Alfirevic on 3/11/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "ViewController.h"
#import "MessageTableViewCell.h"
#import "Message.h"

@interface ViewController() <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
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

#pragma mark - Actions

- (IBAction)addButtonTapped {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please enter your message:" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:nil];
    
    // OK.
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSInteger senderType = [self getRandomNumberBetween:0 to:1];

        UITextField *textField = alertController.textFields[0];
        Message *message = [[Message alloc] initWithText:textField.text
                                           andSenderType:senderType];

        [self.tableView beginUpdates];

        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.itemsArray.count inSection:0]]
                              withRowAnimation:UITableViewRowAnimationBottom];
        [self.itemsArray addObject:message];
        
        [self.tableView endUpdates];
    }]];
    
    // Cancel.
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {}]];
    
    [self presentViewController:alertController animated:YES completion:NULL];
}

#pragma mark - Private API

- (NSInteger)getRandomNumberBetween:(NSInteger)from to:(NSInteger)to {
    return (NSInteger)from + arc4random() % (to - from + 1);
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.estimatedRowHeight = 75.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Message *message = self.itemsArray[indexPath.row];
    
    // Choose the right cell.
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeCell"];
    if (message.senderType == SenderTypeHim) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"HimCell"];
    }
    
    cell.message = message;

    return cell;
}

@end
