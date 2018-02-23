//
//  OverviewView.h
//  APT_V2
//
//  Created by apple on 23/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Charts;

@interface OverviewView : UIView<ChartViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) IBOutlet BarChartView *barChartPP1;
-(void) loadChart;
@property (strong, nonatomic) IBOutlet UIView *filterView;

@property (nonatomic, strong)IBOutlet  NSLayoutConstraint *tableWidth;
@property (nonatomic, strong)IBOutlet  NSLayoutConstraint *tableXposition;
@property (nonatomic, strong) IBOutlet UITableView *PoplistTable;
@property (nonatomic, strong) IBOutlet UILabel *overViewlbl;
@property (nonatomic, strong) IBOutlet UILabel *runslbl;
@property (strong, nonatomic) IBOutlet BarChartView *barChartPP2;


@end
