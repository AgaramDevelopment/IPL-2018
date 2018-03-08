//
//  BattingView.h
//  APT_V2
//
//  Created by apple on 19/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Charts;

@interface BowlingView : UIView <ChartViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>
{
    NSString *innNum;
    NSString *Result;
    NSString *types;
}

@property (nonatomic, strong) IBOutlet BarChartView *chartView;
//-(void) loadChart;
-(void) loadTableFreez;
@property (strong, nonatomic) IBOutlet UICollectionView *resultCollectionView;
@property (strong, nonatomic) IBOutlet UIView *filterView;

@property (nonatomic, strong)IBOutlet  NSLayoutConstraint *tableWidth;
@property (nonatomic, strong)IBOutlet  NSLayoutConstraint *tableXposition;
@property (nonatomic, strong) IBOutlet UITableView *PoplistTable;
@property (nonatomic, strong) IBOutlet UILabel *overViewlbl;
@property (nonatomic, strong) IBOutlet UILabel *runslbl;


@property (nonatomic, strong) IBOutlet NSMutableArray *ChartValuesArray;
@property (nonatomic, strong) IBOutlet NSMutableArray *ChartXAxisValuesArray;
@property (nonatomic, strong) IBOutlet NSMutableArray *TableValuesArray;

@end
