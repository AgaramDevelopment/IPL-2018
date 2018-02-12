//
//  PlayerProfileChartsVC.h
//  APT_V2
//
//  Created by MAC on 09/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Charts;

@interface PlayerProfileChartsVC : UIViewController

@property (strong, nonatomic) IBOutlet UIView *wellnessRatingView;
@property (strong, nonatomic) IBOutlet UIView *RecentFitnessView;
@property (strong, nonatomic) IBOutlet LineChartView *chartView;
@property (strong, nonatomic) IBOutlet CombinedChartView *combinedChartView;

@property (nonatomic, strong) IBOutlet NSArray *options;
@end
