//
//  DataManager.m
//  ToDo
//
//  Created by Djuro Alfirevic on 2/25/17.
//  Copyright © 2017 Djuro Alfirevic. All rights reserved.
//

#import "DataManager.h"
#import "AppDelegate.h"

@interface DataManager()
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end

@implementation DataManager

#pragma mark - Properties

- (void)setUserLocation:(CLLocation *)userLocation {
    _userLocation = userLocation;

    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:userLocation completionHandler:^(NSArray *placemarks, NSError *error) {
         if (error) {
            NSLog(@"CLGeocoder error: %@", error.localizedDescription);
         }

         if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks firstObject];

            self.userLocality = placemark.locality;

            NSLog(@"ISO country code: %@", placemark.ISOcountryCode);
            NSLog(@"Country: %@", placemark.country);
            NSLog(@"Postal code: %@", placemark.postalCode);
            NSLog(@"Administrative area: %@", placemark.administrativeArea);
            NSLog(@"Locality: %@", placemark.locality);
            NSLog(@"Sub locality; %@", placemark.subLocality);
            NSLog(@"Sub thoroughfare: %@", placemark.subThoroughfare);
         }
     }];
}

- (void)setUserLocality:(NSString *)userLocality {
    _userLocality = userLocality;

    // Via delegate
    if (self.delegate) {
        [self.delegate dataManagerDidUpdateLocality];
    }

    // Via notification
    [[NSNotificationCenter defaultCenter] postNotificationName:LOCALITY_UPDATED_NOTIFICATION object:nil];
}

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        _managedObjectContext = appDelegate.persistentContainer.viewContext;
    }

    return _managedObjectContext;
}

#pragma mark - Designated Initializer

+ (instancetype)sharedManager {
    static DataManager *shared;

    @synchronized(self)	{
        if (shared == nil) {
            shared = [[DataManager alloc] init];
        }
    }

    return shared;
}

#pragma mark - Public API

- (NSMutableArray *)fetchEntity:(NSString *)entityName
                     withFilter:(NSString *)filter
                    withSortAsc:(BOOL)sortAscending
                         forKey:(NSString *)sortKey {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entityDescription];

    // Sorting
    if (sortKey != nil) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:sortAscending];
        //NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        NSArray *sortDescriptors = @[sortDescriptor];
        [fetchRequest setSortDescriptors:sortDescriptors];
    }

    // Filtering
    if (filter != nil) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:filter];
        [fetchRequest setPredicate:predicate];
    }

    NSError *error;
    //NSMutableArray *resultsArray = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];

    NSArray *array = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *resultsArray = [NSMutableArray arrayWithArray:array];

    if (resultsArray == nil) NSLog(@"Error fetching %@(s).", entityName);

    return resultsArray;
}

- (void)deleteObject:(NSManagedObject *)object {
    [self.managedObjectContext deleteObject:object];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    if ([appDelegate respondsToSelector:@selector(saveContext)]) {
        [appDelegate saveContext];
    }
}

- (void)updateObject:(NSManagedObject *)object {
    NSError *error = nil;
    if ([object.managedObjectContext hasChanges] && ![object.managedObjectContext save:&error]) {
        NSLog(@"Error updating object in database: %@, %@", [error localizedDescription], [error userInfo]);
        abort();
    }
}

- (void)logObject:(NSManagedObject *)object {
    NSEntityDescription *description = [object entity];
    NSDictionary *attributes = [description attributesByName];

    for (NSString *attribute in attributes) {
        NSLog(@"%@ = %@,", attribute, [object valueForKey:attribute]);
    }
}

- (NSInteger)numberOfTasksPerTaskGroup:(TaskGroup)group {
    NSArray *tasksArray = [self fetchEntity:NSStringFromClass([DBTask class])
                                 withFilter:[NSString stringWithFormat:@"group = %ld", group]
                                withSortAsc:NO
                                     forKey:nil];

    return tasksArray.count;
}

- (void)saveTaskWithTitle:(NSString *)title
              description:(NSString *)description
                    group:(NSInteger)group {
    DBTask *task = (DBTask *)[NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([DBTask class])
                                                       inManagedObjectContext:self.managedObjectContext];
    task.title = title;
    task.desc = description;

    if (self.userLocation) {
        task.latitude = self.userLocation.coordinate.latitude;
        task.longitude = self.userLocation.coordinate.longitude;
    }

    task.date = [NSDate date];
    task.group = group;

    [self saveToDatabase];
}

@end
