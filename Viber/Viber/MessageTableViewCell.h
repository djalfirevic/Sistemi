//
//  MessageTableViewCell.h
//  Viber
//
//  Created by Djuro Alfirevic on 3/11/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"

@interface MessageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *messageView;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) Message *message;
@end
