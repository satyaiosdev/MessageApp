//
//  AppDelegate.h
//  MessageApp
//
//  Created by Satya Venkata Krishna Achanta on 5/19/17.
//  Copyright © 2017 Satya Venkata Krishna Achanta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

