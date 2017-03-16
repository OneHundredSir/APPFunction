//
//  AppDelegate.m
//  DetailView
//
//  Created by hundred on 2017/3/15.
//  Copyright © 2017年 hundred. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "PictureViewController.h"
#import <objc/runtime.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
//    ViewController *vc = [[ViewController alloc]init];
    UIViewController *vc = [[NSClassFromString(@"PictureViewController") alloc]init];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    
    
    
    
    return YES;
}



@end
