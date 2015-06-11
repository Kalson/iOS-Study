//
//  CDAppDelegate.h
//  Core Data
//
//  Created by KaL on 9/7/14.
//  Copyright (c) 2014 KaL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// the 3 essential Core Data objects
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext; // the beating heart of Core Data (the one will need to use a lot) -> we'll need to get this repeatedly from that new tableViewC class so we can call save, fetch, and so on
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
