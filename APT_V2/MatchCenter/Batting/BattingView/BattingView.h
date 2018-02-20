//
//  BattingView.h
//  APT_V2
//
//  Created by apple on 19/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Charts;

@interface BattingView : UIView <ChartViewDelegate>

@property (nonatomic, strong) IBOutlet BarChartView *chartView;
-(void) loadChart;

@end
