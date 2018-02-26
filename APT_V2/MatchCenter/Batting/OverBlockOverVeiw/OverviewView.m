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
NSMutableArray *months;

/* ----------------------------------Filter----------------------------------------- */


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

/*  ---------------------------------------------------------Chart --------------------------------------- */
-(void) loadChart{
    self.PoplistTable.delegate = self;
    self.PoplistTable.dataSource = self;
    
    months = [[NSMutableArray alloc]init];

       months = @[
                   @"Match1", @"Match2", @"Match3",
                   @"Match4", @"Match5"
                   ];
    
    
    
    [self chartPP1];
    [self chartPP2];
    [self chartPP3];
    
}
/*  ---------------------------------------------------------Chart PP1--------------------------------------- */
-(void) chartPP1
{
    
    
    self.barChartPP1.delegate = self;
    
    self.barChartPP1.chartDescription.enabled = NO;
    
    self.barChartPP1.drawGridBackgroundEnabled = NO;
    self.barChartPP1.drawBarShadowEnabled = NO;
    self.barChartPP1.highlightFullBarEnabled = NO;
    
    self.barChartPP1.drawOrder = @[
                             @(CombinedChartDrawOrderBar),
                             @(CombinedChartDrawOrderBubble),
                             @(CombinedChartDrawOrderCandle),
                             @(CombinedChartDrawOrderLine),
                             @(CombinedChartDrawOrderScatter)
                             ];
    
    ChartLegend *l = self.barChartPP1.legend;
    l.wordWrapEnabled = YES;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentCenter;
    l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    l.orientation = ChartLegendOrientationHorizontal;
    l.drawInside = NO;
    
    ChartYAxis *rightAxis = self.barChartPP1.rightAxis;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    ChartYAxis *leftAxis = self.barChartPP1.leftAxis;
    leftAxis.drawGridLinesEnabled = NO;
    leftAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    ChartXAxis *xAxis = self.barChartPP1.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBothSided;
    xAxis.axisMinimum = 0.0;
    xAxis.granularity = 1.0;
    xAxis.valueFormatter = self;
    
    
    [self setChartData];

}



- (void)setChartData
{
    CombinedChartData *data = [[CombinedChartData alloc] init];
    data.barData = [self generateBarData];
    data.lineData = [self generateLineData];
    //data.bubbleData = [self generateBubbleData];
    //data.scatterData = [self generateScatterData];
    //data.candleData = [self generateCandleData];
    
    self.barChartPP1.xAxis.axisMaximum = data.xMax + 0.25;
    
    self.barChartPP1.data = data;
}


- (LineChartData *)generateLineData
{
    LineChartData *d = [[LineChartData alloc] init];
    
    NSMutableArray *entries = [[NSMutableArray alloc] init];
    
    
    for (int index = 0; index < 5; index++)
    {
        [entries addObject:[[ChartDataEntry alloc] initWithX:index + 0.5 y:(arc4random_uniform(65) + 5)]];

//        int value = [[self.lineValuesArray objectAtIndex:index] intValue];
//
//        [entries addObject:[[ChartDataEntry alloc] initWithX:index + 0.5 y:value]];
    }
    
    LineChartDataSet *set = [[LineChartDataSet alloc] initWithValues:entries label:@"Axis 2"];
    [set setColor:[UIColor colorWithRed:240/255.f green:0/255.f blue:0/255.f alpha:1.f]];
    set.lineWidth = 2.5;
    [set setCircleColor:[UIColor colorWithRed:240/255.f green:0/255.f blue:0/255.f alpha:1.f]];
    set.circleRadius = 5.0;
    set.circleHoleRadius = 2.5;
    set.fillColor = [UIColor colorWithRed:240/255.f green:0/255.f blue:0/255.f alpha:1.f];
    set.mode = LineChartModeCubicBezier;
    set.drawValuesEnabled = YES;
    set.valueFont = [UIFont systemFontOfSize:10.f];
    set.valueTextColor = [UIColor colorWithRed:240/255.f green:0/255.f blue:0/255.f alpha:1.f];
    
    set.axisDependency = AxisDependencyLeft;
    
    [d addDataSet:set];
    
    return d;
}

- (BarChartData *)generateBarData
{
    NSMutableArray<BarChartDataEntry *> *entries1 = [[NSMutableArray alloc] init];
    NSMutableArray<BarChartDataEntry *> *entries2 = [[NSMutableArray alloc] init];
    
    for (int index = 0; index < 5; index++)
    {
        [entries1 addObject:[[BarChartDataEntry alloc] initWithX:index + 0.5 y:(arc4random_uniform(15) + 5)]];

        
//        int value = [[self.BarValuesArray objectAtIndex:index] intValue];
//        [entries1 addObject:[[BarChartDataEntry alloc] initWithX:0.0 y:value]];
//
        // stacked
        
        //[entries2 addObject:[[BarChartDataEntry alloc] initWithX:0.0 yValues:@[@(arc4random_uniform(13) + 12), @(arc4random_uniform(13) + 12)]]];
    }
    
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithValues:entries1 label:@"Axis 1"];
    [set1 setColor:[UIColor colorWithRed:60/255.f green:220/255.f blue:78/255.f alpha:1.f]];
    set1.valueTextColor = [UIColor colorWithRed:60/255.f green:220/255.f blue:78/255.f alpha:1.f];
    set1.valueFont = [UIFont systemFontOfSize:10.f];
    set1.axisDependency = AxisDependencyRight;
    
    BarChartDataSet *set2 = [[BarChartDataSet alloc] initWithValues:entries2 label:@""];
    set2.stackLabels = @[@"Stack 1", @"Stack 2"];
    set2.colors = @[
                    [UIColor colorWithRed:61/255.f green:165/255.f blue:255/255.f alpha:1.f],
                    [UIColor colorWithRed:23/255.f green:197/255.f blue:255/255.f alpha:1.f]
                    ];
    set2.valueTextColor = [UIColor colorWithRed:61/255.f green:165/255.f blue:255/255.f alpha:1.f];
    set2.valueFont = [UIFont systemFontOfSize:10.f];
    set2.axisDependency = AxisDependencyRight;
    
    float groupSpace = 0.06f;
    float barSpace = 0.02f; // x2 dataset
    float barWidth = 0.45f; // x2 dataset
    // (0.45 + 0.02) * 2 + 0.06 = 1.00 -> interval per "group"
    
    BarChartData *d = [[BarChartData alloc] initWithDataSets:@[set1,set2]];
    d.barWidth = barWidth;
    
    // make this BarData object grouped
    [d groupBarsFromX:0.0 groupSpace:groupSpace barSpace:barSpace]; // start at x = 0
    
    return d;
}



#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    NSLog(@"chartValueSelected");
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}

#pragma mark - IAxisValueFormatter

- (NSString *)stringForValue:(double)value
                        axis:(ChartAxisBase *)axis
{
    return months[(int)value % months.count];
}








/*  ---------------------------------------------------------Chart PP2--------------------------------------- */

-(void) chartPP2
{
    
    
   
    self.barChartPP2.delegate = self;
    
    self.barChartPP2.chartDescription.enabled = NO;
    
    self.barChartPP2.drawGridBackgroundEnabled = NO;
    self.barChartPP2.drawBarShadowEnabled = NO;
    self.barChartPP2.highlightFullBarEnabled = NO;
    
    self.barChartPP2.drawOrder = @[
                                   @(CombinedChartDrawOrderBar),
                                   @(CombinedChartDrawOrderBubble),
                                   @(CombinedChartDrawOrderCandle),
                                   @(CombinedChartDrawOrderLine),
                                   @(CombinedChartDrawOrderScatter)
                                   ];
    
    ChartLegend *l = self.barChartPP2.legend;
    l.wordWrapEnabled = YES;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentCenter;
    l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    l.orientation = ChartLegendOrientationHorizontal;
    l.drawInside = NO;
    
    ChartYAxis *rightAxis = self.barChartPP2.rightAxis;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    ChartYAxis *leftAxis = self.barChartPP2.leftAxis;
    leftAxis.drawGridLinesEnabled = NO;
    leftAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    ChartXAxis *xAxis = self.barChartPP2.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBothSided;
    xAxis.axisMinimum = 0.0;
    xAxis.granularity = 1.0;
    xAxis.valueFormatter = self;
    
    
    [self setChartData2];
    
}



- (void)setChartData2
{
    CombinedChartData *data = [[CombinedChartData alloc] init];
    data.barData = [self generateBarData2];
    data.lineData = [self generateLineData2];
    //data.bubbleData = [self generateBubbleData];
    //data.scatterData = [self generateScatterData];
    //data.candleData = [self generateCandleData];
    
    self.barChartPP2.xAxis.axisMaximum = data.xMax + 0.25;
    
    self.barChartPP2.data = data;
}



- (LineChartData *)generateLineData2
{
    LineChartData *d = [[LineChartData alloc] init];
    
    NSMutableArray *entries = [[NSMutableArray alloc] init];
    
    
    for (int index = 0; index < 5; index++)
    {
        [entries addObject:[[ChartDataEntry alloc] initWithX:index + 0.5 y:(arc4random_uniform(35) + 5)]];
        
        //        int value = [[self.lineValuesArray objectAtIndex:index] intValue];
        //
        //        [entries addObject:[[ChartDataEntry alloc] initWithX:index + 0.5 y:value]];
    }
    
    LineChartDataSet *set = [[LineChartDataSet alloc] initWithValues:entries label:@"Axis 2"];
    [set setColor:[UIColor colorWithRed:0/255.f green:255/255.f blue:255/255.f alpha:1.f]];
    set.lineWidth = 2.5;
    [set setCircleColor:[UIColor colorWithRed:0/255.f green:255/255.f blue:255/255.f alpha:1.f]];
    set.circleRadius = 5.0;
    set.circleHoleRadius = 2.5;
    set.fillColor = [UIColor colorWithRed:0/255.f green:255/255.f blue:255/255.f alpha:1.f];
    set.mode = LineChartModeCubicBezier;
    set.drawValuesEnabled = YES;
    set.valueFont = [UIFont systemFontOfSize:10.f];
    set.valueTextColor = [UIColor colorWithRed:0/255.f green:255/255.f blue:255/255.f alpha:1.f];
    
    set.axisDependency = AxisDependencyLeft;
    
    [d addDataSet:set];
    
    return d;
}

- (BarChartData *)generateBarData2
{
    NSMutableArray<BarChartDataEntry *> *entries1 = [[NSMutableArray alloc] init];
    NSMutableArray<BarChartDataEntry *> *entries2 = [[NSMutableArray alloc] init];
    
    for (int index = 0; index < 5; index++)
    {
        [entries1 addObject:[[BarChartDataEntry alloc] initWithX:index + 0.5 y:(arc4random_uniform(45) + 5)]];
        
        
        //        int value = [[self.BarValuesArray objectAtIndex:index] intValue];
        //        [entries1 addObject:[[BarChartDataEntry alloc] initWithX:0.0 y:value]];
        //
        // stacked
        
        //[entries2 addObject:[[BarChartDataEntry alloc] initWithX:0.0 yValues:@[@(arc4random_uniform(13) + 12), @(arc4random_uniform(13) + 12)]]];
    }
    
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithValues:entries1 label:@"Axis 1"];
    [set1 setColor:[UIColor colorWithRed:255/255.f green:128/255.f blue:0/255.f alpha:1.f]];
    set1.valueTextColor = [UIColor colorWithRed:255/255.f green:128/255.f blue:0/255.f alpha:1.f];
    set1.valueFont = [UIFont systemFontOfSize:10.f];
    set1.axisDependency = AxisDependencyRight;
    
    BarChartDataSet *set2 = [[BarChartDataSet alloc] initWithValues:entries2 label:@""];
    set2.stackLabels = @[@"Stack 1", @"Stack 2"];
    set2.colors = @[
                    [UIColor colorWithRed:61/255.f green:165/255.f blue:255/255.f alpha:1.f],
                    [UIColor colorWithRed:23/255.f green:197/255.f blue:255/255.f alpha:1.f]
                    ];
    set2.valueTextColor = [UIColor colorWithRed:61/255.f green:165/255.f blue:255/255.f alpha:1.f];
    set2.valueFont = [UIFont systemFontOfSize:10.f];
    set2.axisDependency = AxisDependencyRight;
    
    float groupSpace = 0.06f;
    float barSpace = 0.02f; // x2 dataset
    float barWidth = 0.45f; // x2 dataset
    // (0.45 + 0.02) * 2 + 0.06 = 1.00 -> interval per "group"
    
    BarChartData *d = [[BarChartData alloc] initWithDataSets:@[set1,set2]];
    d.barWidth = barWidth;
    
    // make this BarData object grouped
    [d groupBarsFromX:0.0 groupSpace:groupSpace barSpace:barSpace]; // start at x = 0
    
    return d;
}




/*  ---------------------------------------------------------Chart PP3--------------------------------------- */

-(void) chartPP3
{
    
    
    
    self.barChartPP3.delegate = self;
    
    self.barChartPP3.chartDescription.enabled = NO;
    
    self.barChartPP3.drawGridBackgroundEnabled = NO;
    self.barChartPP3.drawBarShadowEnabled = NO;
    self.barChartPP3.highlightFullBarEnabled = NO;
    
    self.barChartPP3.drawOrder = @[
                                   @(CombinedChartDrawOrderBar),
                                   @(CombinedChartDrawOrderBubble),
                                   @(CombinedChartDrawOrderCandle),
                                   @(CombinedChartDrawOrderLine),
                                   @(CombinedChartDrawOrderScatter)
                                   ];
    
    ChartLegend *l = self.barChartPP3.legend;
    l.wordWrapEnabled = YES;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentCenter;
    l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    l.orientation = ChartLegendOrientationHorizontal;
    l.drawInside = NO;
    
    ChartYAxis *rightAxis = self.barChartPP3.rightAxis;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    ChartYAxis *leftAxis = self.barChartPP3.leftAxis;
    leftAxis.drawGridLinesEnabled = NO;
    leftAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    ChartXAxis *xAxis = self.barChartPP3.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBothSided;
    xAxis.axisMinimum = 0.0;
    xAxis.granularity = 1.0;
    xAxis.valueFormatter = self;
    
    
    [self setChartData3];
    
}



- (void)setChartData3
{
    CombinedChartData *data = [[CombinedChartData alloc] init];
    data.barData = [self generateBarData3];
    data.lineData = [self generateLineData3];

    //data.bubbleData = [self generateBubbleData];
    //data.scatterData = [self generateScatterData];
    //data.candleData = [self generateCandleData];
    
    self.barChartPP3.xAxis.axisMaximum = data.xMax + 0.25;
    
    self.barChartPP3.data = data;
}



- (LineChartData *)generateLineData3
{
    LineChartData *d = [[LineChartData alloc] init];
    
    NSMutableArray *entries = [[NSMutableArray alloc] init];
    
    
    for (int index = 0; index < 5; index++)
    {
        [entries addObject:[[ChartDataEntry alloc] initWithX:index + 0.5 y:(arc4random_uniform(135) + 5)]];
        
        //        int value = [[self.lineValuesArray objectAtIndex:index] intValue];
        //
        //        [entries addObject:[[ChartDataEntry alloc] initWithX:index + 0.5 y:value]];
    }
    
    LineChartDataSet *set = [[LineChartDataSet alloc] initWithValues:entries label:@"Axis 2"];
    [set setColor:[UIColor colorWithRed:51/255.f green:51/255.f blue:255/255.f alpha:1.f]];
    set.lineWidth = 2.5;
    [set setCircleColor:[UIColor colorWithRed:51/255.f green:51/255.f blue:255/255.f alpha:1.f]];
    set.circleRadius = 5.0;
    set.circleHoleRadius = 2.5;
    set.fillColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:255/255.f alpha:1.f];
    set.mode = LineChartModeCubicBezier;
    set.drawValuesEnabled = YES;
    set.valueFont = [UIFont systemFontOfSize:10.f];
    set.valueTextColor = [UIColor colorWithRed:51/255.f green:51/255.f blue:255/255.f alpha:1.f];
    
    set.axisDependency = AxisDependencyLeft;
    
    [d addDataSet:set];
    
    return d;
}

- (BarChartData *)generateBarData3
{
    NSMutableArray<BarChartDataEntry *> *entries1 = [[NSMutableArray alloc] init];
    NSMutableArray<BarChartDataEntry *> *entries2 = [[NSMutableArray alloc] init];
    
    for (int index = 0; index < 5; index++)
    {
        [entries1 addObject:[[BarChartDataEntry alloc] initWithX:index + 0.5 y:(arc4random_uniform(85) + 5)]];
        
        
        //        int value = [[self.BarValuesArray objectAtIndex:index] intValue];
        //        [entries1 addObject:[[BarChartDataEntry alloc] initWithX:0.0 y:value]];
        //
        // stacked
        
        //[entries2 addObject:[[BarChartDataEntry alloc] initWithX:0.0 yValues:@[@(arc4random_uniform(13) + 12), @(arc4random_uniform(13) + 12)]]];
    }
    
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithValues:entries1 label:@"Axis 1"];
    [set1 setColor:[UIColor colorWithRed:255/255.f green:51/255.f blue:153/255.f alpha:1.f]];
    set1.valueTextColor = [UIColor colorWithRed:255/255.f green:51/255.f blue:153/255.f alpha:1.f];
    set1.valueFont = [UIFont systemFontOfSize:10.f];
    set1.axisDependency = AxisDependencyRight;
    
    BarChartDataSet *set2 = [[BarChartDataSet alloc] initWithValues:entries2 label:@""];
    set2.stackLabels = @[@"Stack 1", @"Stack 2"];
    set2.colors = @[
                    [UIColor colorWithRed:61/255.f green:165/255.f blue:255/255.f alpha:1.f],
                    [UIColor colorWithRed:23/255.f green:197/255.f blue:255/255.f alpha:1.f]
                    ];
    set2.valueTextColor = [UIColor colorWithRed:61/255.f green:165/255.f blue:255/255.f alpha:1.f];
    set2.valueFont = [UIFont systemFontOfSize:10.f];
    set2.axisDependency = AxisDependencyRight;
    
    float groupSpace = 0.06f;
    float barSpace = 0.02f; // x2 dataset
    float barWidth = 0.45f; // x2 dataset
    // (0.45 + 0.02) * 2 + 0.06 = 1.00 -> interval per "group"
    
    BarChartData *d = [[BarChartData alloc] initWithDataSets:@[set1,set2]];
    d.barWidth = barWidth;
    
    // make this BarData object grouped
    [d groupBarsFromX:0.0 groupSpace:groupSpace barSpace:barSpace]; // start at x = 0
    
    return d;
}

@end
