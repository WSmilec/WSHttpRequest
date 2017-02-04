//
//  AppDelegate.h
//  WSHttpRequest
//
//  Created by WangS on 17/2/4.
//  Copyright © 2017年 WangS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

