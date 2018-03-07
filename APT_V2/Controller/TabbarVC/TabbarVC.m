//
//  TabbarVC.m
//  APT_V2
//
//  Created by Apple on 06/03/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "TabbarVC.h"
#import "ScoreCardVC.h"
#import "PlayersVC.h"
#import "SessionSummaryVC.h"
#import "FieldSummaryVC.h"

@interface TabbarVC ()
{
    ScoreCardVC *firstViewController;
    PlayersVC *secondViewController;
    PlayersVC *thirdViewController;
    FieldSummaryVC *fourthVC;
    SessionSummaryVC *fifthVC;
}

@end

@implementation TabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)viewDidAppear:(BOOL)animated
{
  // [self setUpTabBar];
    
    [self changeTabbar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void) setUpTabBar {
    
    self.tabBar.barTintColor = [UIColor brownColor];
    
    //MCOverViewVC
    firstViewController = [[ScoreCardVC alloc]init];
    firstViewController.title = @"ScoreCard";
    firstViewController.tabBarItem = self.overviewBarItem;
    //firstViewController.matchDetails = self.matchDetails;
    //firstViewController.matchCode = self.matchCode;
    firstViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"ico_calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    firstViewController.tabBarItem.image = [[UIImage imageNamed:@"ico_calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
    
    //MCTossAndResultsVC
   secondViewController = [[PlayersVC alloc]init];
    secondViewController.title = @"BattingKPI";
    secondViewController.tabBarItem = self.tossAndResultBarItem;
    
    secondViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"ico_calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    secondViewController.tabBarItem.image = [[UIImage imageNamed:@"ico_calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
    
    
    
    //MCTeamCompVC
    thirdViewController = [[PlayersVC alloc]init];
    thirdViewController.title = @"BowlingKPI";
    thirdViewController.tabBarItem = self.tossAndResultBarItem;
    
    thirdViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"ico_calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    thirdViewController.tabBarItem.image = [[UIImage imageNamed:@"ico_calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
    fourthVC = [[FieldSummaryVC alloc]init];
    fourthVC.title = @"Fielding Summary";
    fourthVC.tabBarItem = self.tossAndResultBarItem;
    
    fourthVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"ico_calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    fourthVC.tabBarItem.image = [[UIImage imageNamed:@"ico_calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
    fifthVC = [[SessionSummaryVC alloc]init];
    fifthVC.title = @"Session Summary";
    fifthVC.tabBarItem = self.tossAndResultBarItem;
    
    fifthVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"ico_calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    fifthVC.tabBarItem.image = [[UIImage imageNamed:@"ico_calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
    
    self.viewControllers = [[NSArray alloc] initWithObjects:firstViewController, secondViewController,thirdViewController,fourthVC,fifthVC, nil];
    
    
    self.tabBar.barTintColor=[UIColor colorWithRed:(24/255.0f) green:(40/255.0f) blue:(126/255.0f) alpha:1.0f];
    
    // Add this code to change StateNormal text Color,
    [UITabBarItem.appearance setTitleTextAttributes:
     @{NSForegroundColorAttributeName : [UIColor grayColor]}
                                           forState:UIControlStateNormal];
    
    // then if StateSelected should be different, you should add this code
    [UITabBarItem.appearance setTitleTextAttributes:
     @{NSForegroundColorAttributeName : [UIColor whiteColor]}
                                           forState:UIControlStateSelected];
    
}

-(void)changeTabbar
{
    UITabBar *tabBar = self.tabBar;
    
    UITabBarItem *tabItem1 = [tabBar.items objectAtIndex:0];
    tabItem1.selectedImage = [[UIImage imageNamed:@"ico_calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabItem1.image = [[UIImage imageNamed:@"ico_calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabItem1.title = @"SCORECARD";
    
    
    UITabBarItem *tabItem2 = [tabBar.items objectAtIndex:1];
    tabItem2.selectedImage = [[UIImage imageNamed:@"ico_calendar"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabItem2.image = [[UIImage imageNamed:@"ico_calendar"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabItem2.title = @"BATTING KPI";
    
    UITabBarItem *tabItem3 = [tabBar.items objectAtIndex:2];
    tabItem3.selectedImage = [[UIImage imageNamed:@"ico_calendar"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabItem3.image = [[UIImage imageNamed:@"ico_calendar"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabItem3.title = @"BOWLING KPI";
    
    
    UITabBarItem *tabItem4 = [tabBar.items objectAtIndex:3];
    tabItem4.selectedImage = [[UIImage imageNamed:@"ico_calendar"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabItem4.image = [[UIImage imageNamed:@"ico_calendar"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabItem4.title = @"FIELDING SUMMARY";
    
    
    UITabBarItem *tabItem5 = [tabBar.items objectAtIndex:4];
    tabItem5.selectedImage = [[UIImage imageNamed:@"ico_calendar"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabItem5.image = [[UIImage imageNamed:@"ico_calendar"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    tabItem5.title = @"SESSION SUMMARY";
    
  
    self.tabBar.barTintColor=[UIColor colorWithRed:(24/255.0f) green:(40/255.0f) blue:(126/255.0f) alpha:1.0f];
    //self.tabBar.tintColor = [UIColor whiteColor];
    //self.tabBar.unselectedItemTintColor = [UIColor colorWithRed:(80/255.0f) green:(177/255.0f) blue:(215/255.0f) alpha:1.0f];
    
    //
    
    // Add this code to change StateNormal text Color,
    [UITabBarItem.appearance setTitleTextAttributes:
     @{NSForegroundColorAttributeName : [UIColor colorWithRed:(80/255.0f) green:(177/255.0f) blue:(215/255.0f) alpha:1.0f]}
                                           forState:UIControlStateNormal];
    
    // then if StateSelected should be different, you should add this code
    [UITabBarItem.appearance setTitleTextAttributes:
     @{NSForegroundColorAttributeName : [UIColor whiteColor]}
                                           forState:UIControlStateSelected];
    
   
}


@end
