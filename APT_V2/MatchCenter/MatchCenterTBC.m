//
//  MatchCenterTBC.m
//  APT_V2
//
//  Created by apple on 07/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "MatchCenterTBC.h"
#import "MCOverViewVC.h"
#import "MCTossAndResultsVC.h"
#import "MCTeamCompVC.h"
#import "MCBattingRootVC.h"
#import "GroundVC.h"
#import "StandingVC.h"
#import "MCBowlingRootVC.h"
#import "TeamHeadToHead.h"
#import "TeamOverviewVC.h"

@interface MatchCenterTBC ()

@end

@implementation MatchCenterTBC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTabBar];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void) setUpTabBar {
    
    self.tabBar.barTintColor = [UIColor brownColor];
    
    //MCOverViewVC
    MCOverViewVC *firstViewController = [[MCOverViewVC alloc]init];
//    firstViewController.title = @"Overview";
//    firstViewController.tabBarItem = self.overviewBarItem;
    
//    firstViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"Overview_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
//    firstViewController.tabBarItem.image = [[UIImage imageNamed:@"Overview"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
    UIImage* overView_selected = [[UIImage imageNamed:@"Overview_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    UIImage* overView_Unselected = [[UIImage imageNamed:@"Overview"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//
//
    UITabBarItem* item1 = [[UITabBarItem alloc] initWithTitle:@"Overview" image:overView_Unselected selectedImage:overView_selected];
    item1.imageInsets = UIEdgeInsetsMake(0, 0, -6, 0);
    [firstViewController setTabBarItem:item1];

    
   
    //MCTossAndResultsVC
    MCTossAndResultsVC *secondViewController = [[MCTossAndResultsVC alloc]init];
    secondViewController.title = @"Toss & Result";
    secondViewController.tabBarItem = self.tossAndResultBarItem;
    
//    secondViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"Toss&Results_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
//    secondViewController.tabBarItem.image = [[UIImage imageNamed:@"Toss&Results"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];

    
   
    
    //MCTeamCompVC
    MCTeamCompVC *thirdViewController = [[MCTeamCompVC alloc]init];
    thirdViewController.title = @"Team Composition";
    thirdViewController.tabBarItem = self.tossAndResultBarItem;
    
//    thirdViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"Teamcomposition_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
//    thirdViewController.tabBarItem.image = [[UIImage imageNamed:@"Teamcomposition"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    //BattingVC
    MCBattingRootVC *fourthViewController = [[MCBattingRootVC alloc]init];
    fourthViewController.title = @"Batting";
    fourthViewController.tabBarItem = self.tossAndResultBarItem;
    
//    fourthViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"Batting_KPI_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
//    fourthViewController.tabBarItem.image = [[UIImage imageNamed:@"Batting_KPI"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
    //BowlingVC
    MCBowlingRootVC *bowlingViewController = [[MCBowlingRootVC alloc]init];
    bowlingViewController.title = @"Bowling";
    bowlingViewController.tabBarItem = self.tossAndResultBarItem;
    
//    bowlingViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"Bowling_KPI_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
//    bowlingViewController.tabBarItem.image = [[UIImage imageNamed:@"Bowling_KPI"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
  
    //GroundVC
    GroundVC *fifthViewController = [[GroundVC alloc]init];
    fifthViewController.title = @"Ground";
    fifthViewController.tabBarItem = self.tossAndResultBarItem;
    
//    fifthViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"Ground_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
//    fifthViewController.tabBarItem.image = [[UIImage imageNamed:@"Ground_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
    
    //Standings
    StandingVC *sixthViewController = [[StandingVC alloc]init];
    sixthViewController.title = @"Standings";
    sixthViewController.tabBarItem = self.tossAndResultBarItem;
    
//    sixthViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"Standings_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
//    sixthViewController.tabBarItem.image = [[UIImage imageNamed:@"Standings"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
    
    //H2H
    TeamHeadToHead *headtoheadController = [[TeamHeadToHead alloc]init];
    headtoheadController.title = @"H2H";
    headtoheadController.tabBarItem = self.tossAndResultBarItem;
    
//    headtoheadController.tabBarItem.selectedImage = [[UIImage imageNamed:@"Head2Head_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
//    headtoheadController.tabBarItem.image = [[UIImage imageNamed:@"Head2Head"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
    
//    //Team overview
//    TeamOverviewVC *teamOverviewController = [[TeamOverviewVC alloc]init];
//    teamOverviewController.title = @"Team";
//    teamOverviewController.tabBarItem = self.tossAndResultBarItem;
//
//    teamOverviewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"Team_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
//    teamOverviewController.tabBarItem.image = [[UIImage imageNamed:@"Team"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
//    self.tabBar.items
    
    self.viewControllers = [[NSArray alloc] initWithObjects:firstViewController, secondViewController,thirdViewController,fourthViewController,bowlingViewController,fifthViewController,sixthViewController,headtoheadController, nil];
    
    
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
