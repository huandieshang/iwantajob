//
//  AppDelegate.m
//  weico
//
//  Created by 高超 on 3/2/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "SinaWeibo.h"
#import "LoginViewController.h"
#import "RootViewController.h"

@implementation AppDelegate
{
    RootViewController *_rootVC;
}
- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    
    //判断是否已经授权新浪微博
    if ([self _ininSinaWeibo]) {
        //创建主控制器
        MainViewController *mainVC = [[MainViewController alloc] init];
        _sinaweibo.delegate = mainVC;
        
        //创建左右菜单控制器
        _rootVC = [[RootViewController alloc] initWithRootViewController:mainVC];
        
        [self.window setRootViewController:_rootVC];
        [mainVC release];
    }else{
        //初始化登陆界面
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        _sinaweibo.delegate = loginVC;
        [self.window setRootViewController:loginVC];
        [loginVC release];
    }
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)_ininSinaWeibo
{
    _sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:nil];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        _sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        _sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        _sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
        return YES;
    }else{
        return NO;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
