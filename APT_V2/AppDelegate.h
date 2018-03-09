//
//  AppDelegate.h
//  APT_V2
//
//  Created by user on 02/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "RearViewController.h"
@class SWRevealViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>



@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SWRevealViewController *revealViewController;
@property (strong, nonatomic) UIStoryboard *storyBoard;
@property (strong, nonatomic) UINavigationController *frontNavigationController;
@property (strong, nonatomic) RearViewController *rearViewController;
@property (strong, nonatomic) UINavigationController *rearNavigationController;

@property (strong, readwrite) NSString *Currentmatchcode;
@property (strong, readwrite) NSMutableArray *Scorearray;
//Batting KPI
@property (strong, readwrite) NSMutableArray *BatsmanDetailsArray1;
@property (strong, readwrite) NSMutableArray *BatsmanDetailsArray2;
@property (strong, readwrite) NSMutableArray *BatsmanDetailsArray3;
@property (strong, readwrite) NSMutableArray *BatsmanDetailsArray4;
@property (strong, readwrite) NSMutableArray *inningsDetailsArray;
@property (readwrite) NSInteger indexPath;

//Bowling KPI

@property (nonatomic,strong)  NSMutableArray *BowlingDetailsArray1;
@property (nonatomic,strong) NSMutableArray *BowlingDetailsArray2;
@property (nonatomic,strong) NSMutableArray *BowlingDetailsArray3;
@property (nonatomic,strong) NSMutableArray *BowlingDetailsArray4;
@property (strong, readwrite) NSMutableArray *inningsDetailsArray2;
@property (readwrite) NSInteger indexPath2;
@property (strong, readwrite) NSArray *ArrayCompetition;
@property (strong, readwrite) NSArray *ArrayTeam;



//FieldingKPI
@property (strong, readwrite) NSString *matchHeaderDetails;
@property (readwrite) BOOL isTest;

@end

