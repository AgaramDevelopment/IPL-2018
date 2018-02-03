//
//  AppDelegate.m
//  APT_V2
//
//  Created by user on 02/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "AppDelegate.h"
#import "Header.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize window,viewController;

@synthesize storyBoard;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"];

    UIViewController *frontViewController = [storyBoard instantiateViewControllerWithIdentifier:(isLogin ? @"frontViewController" : @"LoginVC")];;
    RearViewController *rearViewController = [[RearViewController alloc] init];
    

    UINavigationController *frontNavigationController = [[UINavigationController alloc] initWithRootViewController:frontViewController];
    UINavigationController *rearNavigationController = [[UINavigationController alloc] initWithRootViewController:rearViewController];
    
    viewController = [[SWRevealViewController alloc] initWithRearViewController:rearNavigationController frontViewController:frontNavigationController];
    [frontNavigationController setNavigationBarHidden:YES];
    [rearNavigationController setNavigationBarHidden:YES];
    [viewController setFrontViewPosition:FrontViewPositionLeftSide animated:YES];
    
    window.rootViewController = viewController;
    
    [window setBackgroundColor:[UIColor yellowColor]];
    [window makeKeyAndVisible];

    return YES;
}

#pragma mark - SWRevealViewDelegate

- (id <UIViewControllerAnimatedTransitioning>)revealController:(SWRevealViewController *)revealController animationControllerForOperation:(SWRevealControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
//    if ( operation != SWRevealControllerOperationReplaceRightController )
//        return nil;
//
//    if ( [toVC isKindOfClass:[RightViewController class]] )
//    {
//        if ( [(RightViewController*)toVC wantsCustomAnimation] )
//        {
//            id<UIViewControllerAnimatedTransitioning> animationController = [[CustomAnimationController alloc] init];
//            return animationController;
//        }
//    }
    
    return nil;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
