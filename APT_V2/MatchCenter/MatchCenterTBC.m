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
    firstViewController.title = @"Overview";
    firstViewController.tabBarItem = self.overviewBarItem;
    
    firstViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"ico_calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    firstViewController.tabBarItem.image = [[UIImage imageNamed:@"ico_calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];

   
    //MCTossAndResultsVC
    MCTossAndResultsVC *secondViewController = [[MCTossAndResultsVC alloc]init];
    secondViewController.title = @"Toss & Result";
    secondViewController.tabBarItem = self.tossAndResultBarItem;
    
    secondViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"ico_calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    secondViewController.tabBarItem.image = [[UIImage imageNamed:@"ico_calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];

    
   
    
    //MCTeamCompVC
    MCTeamCompVC *thirdViewController = [[MCTeamCompVC alloc]init];
    thirdViewController.title = @"Team Composition";
    thirdViewController.tabBarItem = self.tossAndResultBarItem;
    
    thirdViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"ico_calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    thirdViewController.tabBarItem.image = [[UIImage imageNamed:@"ico_calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    
    
  
    self.viewControllers = [[NSArray alloc] initWithObjects:firstViewController, secondViewController,thirdViewController, nil];
    
    
    
    
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
