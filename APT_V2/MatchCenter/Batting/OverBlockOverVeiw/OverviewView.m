//
//  OverviewView.m
//  APT_V2
//
//  Created by apple on 23/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "OverviewView.h"

@implementation OverviewView


BOOL isXAxis;
BOOL isYAxis;

/* Filter */


#pragma mark - UITableViewDataSource
// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(isXAxis==YES)
    {
        return 7;
    }
    if(isYAxis==YES)
    {
        return 7;
        
    }else{
        return 0;
    }
    
}
// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *MyIdentifier = @"cellid";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MyIdentifier];
    }
    
   cell.textLabel.text = indexPath.row == 0 ? @"Runs" : indexPath.row == 1 ? @"Wickets" : indexPath.row == 2 ? @"Strick Rate" :  indexPath.row == 3 ? @"Runs per over" :  indexPath.row == 4 ? @"Average" :  indexPath.row == 5 ? @"Dot balls %" :  @"Boundaries %";
    
    
    cell.selectionStyle = UIAccessibilityTraitNone;
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(isXAxis==YES)
    {
      
        
        self.overViewlbl.text  = indexPath.row == 0 ? @"Runs" : indexPath.row == 1 ? @"Wickets" : indexPath.row == 2 ? @"Strick Rate" :  indexPath.row == 3 ? @"Runs per over" :  indexPath.row == 4 ? @"Average" :  indexPath.row == 5 ? @"Dot balls %" :  @"Boundaries %";
        
    }else if(isYAxis==YES)
    {
        self.runslbl.text  = indexPath.row == 0 ? @"Runs" : indexPath.row == 1 ? @"Wickets" : indexPath.row == 2 ? @"Strick Rate" :  indexPath.row == 3 ? @"Runs per over" :  indexPath.row == 4 ? @"Average" :  indexPath.row == 5 ? @"Dot balls %" :  @"Boundaries %";
    }
    
    isXAxis = NO;
    isYAxis = NO;
    self.PoplistTable.hidden = YES;
    
}

- (IBAction)onClickOverViewDD:(id)sender
{
    
    if(isXAxis){
        
        isXAxis = NO;
        isYAxis = NO;
        self.PoplistTable.hidden = YES;
        
        
    }else{
        
        isXAxis = YES;
        isYAxis = NO;
        
        self.PoplistTable.hidden = NO;
        
        self.tableWidth.constant = 142;
        self.tableXposition.constant = self.filterView.frame.origin.x+8;
        [self.PoplistTable reloadData];
    }
}

- (IBAction)onClickRunsDD:(id)sender
{
    if(isYAxis){
        
        isXAxis = NO;
        isYAxis = NO;
        self.PoplistTable.hidden = YES;
        
        
    }else{
        isXAxis = NO;
        isYAxis = YES;
        self.PoplistTable.hidden = NO;
        self.tableWidth.constant = 142;
        self.tableXposition.constant = self.filterView.frame.origin.x+8+142+16;
        [self.PoplistTable reloadData];
    }
}

/*  Chart  */
-(void) loadChart{
    self.PoplistTable.delegate = self;
    self.PoplistTable.dataSource = self;
    
    [self chartPP1];

    [self chartPP2];
}
-(void) chartPP1
{
    
    
    
    
    //    [self setupBarLineChartView:_chartView];
    
    self.barChartPP1.delegate = self;
    
    self.barChartPP1.drawBarShadowEnabled = NO;
    self.barChartPP1.drawValueAboveBarEnabled = YES;
    
    self.barChartPP1.maxVisibleCount = 60;
    
    ChartXAxis *xAxis = self.barChartPP1.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:10.f];
    xAxis.drawGridLinesEnabled = NO;
    xAxis.granularity = 1.0; // only intervals of 1 day
    xAxis.labelCount = 7;
    // xAxis.valueFormatter = [[DayAxisValueFormatter alloc] initForChart:_chartView];
    
    NSNumberFormatter *leftAxisFormatter = [[NSNumberFormatter alloc] init];
    leftAxisFormatter.minimumFractionDigits = 0;
    leftAxisFormatter.maximumFractionDigits = 1;
    leftAxisFormatter.negativeSuffix = @"";
    leftAxisFormatter.positiveSuffix = @"";
    
    ChartYAxis *leftAxis = self.barChartPP1.leftAxis;
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
    leftAxis.labelCount = 8;
    leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:leftAxisFormatter];
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    leftAxis.spaceTop = 0.15;
    leftAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    ChartYAxis *rightAxis = self.barChartPP1.rightAxis;
    rightAxis.enabled = YES;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.labelFont = [UIFont systemFontOfSize:10.f];
    rightAxis.labelCount = 8;
    rightAxis.valueFormatter = leftAxis.valueFormatter;
    rightAxis.spaceTop = 0.15;
    rightAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    ChartLegend *l = self.barChartPP1.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
    l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    l.orientation = ChartLegendOrientationHorizontal;
    l.drawInside = NO;
    l.form = ChartLegendFormSquare;
    l.formSize = 9.0;
    l.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
    l.xEntrySpace = 4.0;
    
    [self setDataCount2: 10 range: 20];
    
    
    //    XYMarkerView *marker = [[XYMarkerView alloc]
    //                            initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
    //                            font: [UIFont systemFontOfSize:12.0]
    //                            textColor: UIColor.whiteColor
    //                            insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)
    //                            xAxisValueFormatter: _chartView.xAxis.valueFormatter];
    //    marker.chartView = _chartView;
    //    marker.minimumSize = CGSizeMake(80.f, 40.f);
    //    _chartView.marker = marker;
    //
    //    _sliderX.value = 12.0;
    //    _sliderY.value = 50.0;
    //   [self slidersValueChanged:nil];
}




- (void)setDataCount2:(int)count range:(double)range
{
    double start = 1.0;
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (int i = start; i < start + count + 1; i++)
    {
        double mult = (range + 1);
        double val = (double) (arc4random_uniform(mult));
        if (arc4random_uniform(100) < 25) {
            [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:val icon: [UIImage imageNamed:@"icon"]]];
        } else {
            [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:val]];
        }
    }
    
    BarChartDataSet *set1 = nil;
    if (self.barChartPP1.data.dataSetCount > 0)
    {
        set1 = (BarChartDataSet *)self.barChartPP1.data.dataSets[0];
        set1.values = yVals;
        [self.barChartPP1.data notifyDataChanged];
        [self.barChartPP1 notifyDataSetChanged];
    }
    else
    {
        set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@"The year 2017"];
        [set1 setColors:ChartColorTemplates.material];
        set1.drawIconsEnabled = NO;
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
        
        data.barWidth = 0.9f;
        
        self.barChartPP1.data = data;
    }
}


-(void) chartPP2
{
    
    
    
    
    //    [self setupBarLineChartView:_chartView];
    
    self.barChartPP2.delegate = self;
    
    self.barChartPP2.drawBarShadowEnabled = NO;
    self.barChartPP2.drawValueAboveBarEnabled = YES;
    
    self.barChartPP2.maxVisibleCount = 60;
    
    ChartXAxis *xAxis = self.barChartPP2.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:10.f];
    xAxis.drawGridLinesEnabled = NO;
    xAxis.granularity = 1.0; // only intervals of 1 day
    xAxis.labelCount = 7;
    // xAxis.valueFormatter = [[DayAxisValueFormatter alloc] initForChart:_chartView];
    
    NSNumberFormatter *leftAxisFormatter = [[NSNumberFormatter alloc] init];
    leftAxisFormatter.minimumFractionDigits = 0;
    leftAxisFormatter.maximumFractionDigits = 1;
    leftAxisFormatter.negativeSuffix = @"";
    leftAxisFormatter.positiveSuffix = @"";
    
    ChartYAxis *leftAxis = self.barChartPP2.leftAxis;
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
    leftAxis.labelCount = 8;
    leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:leftAxisFormatter];
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    leftAxis.spaceTop = 0.15;
    leftAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    ChartYAxis *rightAxis = self.barChartPP2.rightAxis;
    rightAxis.enabled = YES;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.labelFont = [UIFont systemFontOfSize:10.f];
    rightAxis.labelCount = 8;
    rightAxis.valueFormatter = leftAxis.valueFormatter;
    rightAxis.spaceTop = 0.15;
    rightAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    ChartLegend *l = self.barChartPP2.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
    l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    l.orientation = ChartLegendOrientationHorizontal;
    l.drawInside = NO;
    l.form = ChartLegendFormSquare;
    l.formSize = 9.0;
    l.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
    l.xEntrySpace = 4.0;
    
    [self setDataCount: 10 range: 20];
    
    
    //    XYMarkerView *marker = [[XYMarkerView alloc]
    //                            initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
    //                            font: [UIFont systemFontOfSize:12.0]
    //                            textColor: UIColor.whiteColor
    //                            insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)
    //                            xAxisValueFormatter: _chartView.xAxis.valueFormatter];
    //    marker.chartView = _chartView;
    //    marker.minimumSize = CGSizeMake(80.f, 40.f);
    //    _chartView.marker = marker;
    //
    //    _sliderX.value = 12.0;
    //    _sliderY.value = 50.0;
    //   [self slidersValueChanged:nil];
}



- (void)updateChartData
{
    //    if (self.shouldHideData)
    //    {
    //        _chartView.data = nil;
    //        return;
    //    }
    
    //  [self setDataCount:_sliderX.value + 1 range:_sliderY.value];
}

- (void)setDataCount:(int)count range:(double)range
{
    double start = 1.0;
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (int i = start; i < start + count + 1; i++)
    {
        double mult = (range + 1);
        double val = (double) (arc4random_uniform(mult));
        if (arc4random_uniform(100) < 25) {
            [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:val icon: [UIImage imageNamed:@"icon"]]];
        } else {
            [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:val]];
        }
    }
    
    BarChartDataSet *set1 = nil;
    if (self.barChartPP2.data.dataSetCount > 0)
    {
        set1 = (BarChartDataSet *)self.barChartPP2.data.dataSets[0];
        set1.values = yVals;
        [self.barChartPP2.data notifyDataChanged];
        [self.barChartPP2 notifyDataSetChanged];
    }
    else
    {
        set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@"The year 2017"];
        [set1 setColors:ChartColorTemplates.material];
        set1.drawIconsEnabled = NO;
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
        
        data.barWidth = 0.9f;
        
        self.barChartPP2.data = data;
    }
}


#pragma mark - Actions



#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    NSLog(@"chartValueSelected");
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}

@end
