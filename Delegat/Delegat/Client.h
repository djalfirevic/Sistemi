//
//  Client.h
//  Delegat
//
//  Created by Djuro Alfirevic on 3/4/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContractAgreement.h"
#import "Worker.h"

@interface Client : NSObject
@property (weak, nonatomic) id<ContractAgreement> delegate;
- (void)hire:(Worker *)worker;
- (void)giveNotice;
@end
