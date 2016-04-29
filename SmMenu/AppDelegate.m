//
//  AppDelegate.m
//  SmMenu
//
//  Created by 厦航 on 16/4/6.
//  Copyright © 2016年 厦航. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "DlHomeViewController.h"
#import "DnHomeViewController.h"
#import "WJMenuViewController.h"
#import "DhlHomeViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    DlHomeViewController *dlHomeView = [[DlHomeViewController alloc]init];
    HomeViewController *homeView = [[HomeViewController alloc]init];
    DnHomeViewController *dnHomeView = [[DnHomeViewController alloc]init];
    WJMenuViewController *wjmenu = [[WJMenuViewController alloc]init];
    DhlHomeViewController *dhlHomeView = [[DhlHomeViewController alloc]init];
    
    UINavigationController *navHomeView = [[UINavigationController alloc]initWithRootViewController:homeView];
    UINavigationController *navdlHomeView = [[UINavigationController alloc]initWithRootViewController:dlHomeView];
    UINavigationController *navdnHomeView = [[UINavigationController alloc]initWithRootViewController:dnHomeView];
    UINavigationController *navWjmenu = [[UINavigationController alloc]initWithRootViewController:wjmenu];
    UINavigationController *navDhlHomeView = [[UINavigationController alloc]initWithRootViewController:dhlHomeView];
    
 
    
    navHomeView.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"有毒Home" image:nil selectedImage:nil];
    navdlHomeView.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"DlHome" image:nil selectedImage:nil];
    navdnHomeView.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"DnHome" image:nil selectedImage:nil];
    navWjmenu.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"Wj" image:nil selectedImage:nil];
    navDhlHomeView.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"抄袭导航栏" image:nil selectedImage:nil];
    [navDhlHomeView.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:14.0],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    
    
    UITabBarController *tabBar = [[UITabBarController alloc]init];
    tabBar.viewControllers = @[navHomeView,navdlHomeView,navdnHomeView,navWjmenu,navDhlHomeView];
    /*设置UITabBarTitle的字体大小颜色*/
    tabBar.tabBar.tintColor = [UIColor whiteColor];
    tabBar.tabBar.barTintColor = [UIColor blackColor];
    for (UITabBarItem *item in tabBar.tabBar.items) {
        [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:12.0]} forState:UIControlStateNormal];
    }

    
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barTintColor = [UIColor blackColor];
    navBar.tintColor = [UIColor redColor];
    [navBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:30],NSForegroundColorAttributeName:[UIColor whiteColor]}];

//    UITabBar *tab = [UITabBar appearance];
//    tab.barTintColor = [UIColor blackColor];
//    tab.tintColor = [UIColor redColor];
    

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = tabBar;
    
    /**
     *      3DTouch
     */
    
    UIApplicationShortcutItem *shortItem1 = [[UIApplicationShortcutItem alloc]initWithType:@"3DTouch测试1" localizedTitle:@"厦航"];
    UIApplicationShortcutItem *shortItem2 = [[UIApplicationShortcutItem alloc]initWithType:@"3DTouch测试2" localizedTitle:@"夏龙"];
    NSArray *shortItemArrays = [[NSArray alloc]initWithObjects:shortItem1,shortItem2, nil];
    [[UIApplication sharedApplication] setShortcutItems:shortItemArrays];

    return YES;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    if ([shortcutItem.localizedTitle isEqualToString:@"厦航"]) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"测试1" message:@"我只是测试" delegate:nil cancelButtonTitle:@"我知道是测试" otherButtonTitles:@"好", nil];
        [alert show];
    }
    else if([shortcutItem.localizedTitle isEqualToString:@"夏龙"]){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"测试1" message:@"我只是测试" delegate:nil cancelButtonTitle:@"我知道是测试" otherButtonTitles:@"好", nil];
        [alert show];
    }

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
