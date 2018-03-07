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


@end
