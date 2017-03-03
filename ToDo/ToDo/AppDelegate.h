//
//  AppDelegate.h
//  ToDo
//
//  Created by Djuro Alfirevic on 12/14/16.
//  Copyright © 2016 Djuro Alfirevic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, readonly) NSPersistentContainer *persistentContainer;
- (void)saveContext;
@end
