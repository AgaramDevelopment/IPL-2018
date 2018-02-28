//
//  BattingView.m
//  APT_V2
//
//  Created by apple on 19/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "BowlingView.h"
#import "PlayerListCollectionViewCell.h"
#import "Config.h"


@implementation BowlingView

NSArray* headingBowlKeyArray;
NSArray* headingBowlButtonNames;
BOOL isBowlOverview;
BOOL isBowlRun;

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
    
    if(isBowlOverview==YES)
    {
        return 7;
    }
    if(isBowlRun==YES)
    {
        return 4;

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
    
    if(isBowlOverview==YES)
    {
        cell.textLabel.text = indexPath.row == 0 ? @"Overall" : indexPath.row == 1 ? @"Batting 1st" : indexPath.row == 2 ? @"Batting 2nd" :  indexPath.row == 3 ? @"Batting 1st Won" :  indexPath.row == 4 ? @"Batting 2nd Won" :  indexPath.row == 5 ? @"Batting 1st Lost" :  @"Batting 2nd Lost";

    }else if(isBowlRun==YES)
    {
        cell.textLabel.text = indexPath.row == 0 ? @"Wickets" : indexPath.row == 1 ? @"Strike Rate" : indexPath.row == 2 ? @"Average" : @"Dot Balls";

    }else{
        cell.textLabel.text = @"";
    }

    
    cell.selectionStyle = UIAccessibilityTraitNone;
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(isBowlOverview==YES)
    {
        self.overViewlbl.text = indexPath.row == 0 ? @"Overall" : indexPath.row == 1 ? @"Batting 1st" : indexPath.row == 2 ? @"Batting 2nd" :  indexPath.row == 3 ? @"Batting 1st Won" :  indexPath.row == 4 ? @"Batting 2nd Won" :  indexPath.row == 5 ? @"Batting 1st Lost" :  @"Batting 2nd Lost";
        
    }else if(isBowlRun==YES)
    {
        self.runslbl.text = indexPath.row == 0 ? @"Wickets" : indexPath.row == 1 ? @"Strike Rate" : indexPath.row == 2 ? @"Average" : @"Dot Balls";
        
    }
    
    isBowlOverview = NO;
    isBowlRun = NO;
    self.PoplistTable.hidden = YES;

}

- (IBAction)onClickOverViewDD:(id)sender
{
    
    if(isBowlOverview){
        
        isBowlOverview = NO;
        isBowlRun = NO;
        self.PoplistTable.hidden = YES;

        
    }else{

    isBowlOverview = YES;
    isBowlRun = NO;
    
    self.PoplistTable.hidden = NO;
    
    self.tableWidth.constant = 142;
    self.tableXposition.constant = self.filterView.frame.origin.x+8;
        [self.PoplistTable reloadData];
    }
}

- (IBAction)onClickRunsDD:(id)sender
{
    if(isBowlRun){
        
        isBowlOverview = NO;
        isBowlRun = NO;
        self.PoplistTable.hidden = YES;

        
    }else{
    isBowlOverview = NO;
    isBowlRun = YES;
    self.PoplistTable.hidden = NO;
    self.tableWidth.constant = 142;
    self.tableXposition.constant = self.filterView.frame.origin.x+8+142+16;
        [self.PoplistTable reloadData];
    }
}




/* Table Freez */
-(void) loadTableFreez{
    

    self.PoplistTable.delegate = self;
    self.PoplistTable.dataSource = self;

    
    headingBowlKeyArray =  @[@"Player",@"Style",@"Mat",@"Inns",@"Over",@"Mdns",@"Runs",@"Wkts",@"BBI",@"Ave",@"Eco",@"SR",@"3 W",@"5 W",@"Ct",@"St"];
    
    
    headingBowlButtonNames = @[@"Player",@"Style",@"Mat",@"Inns",@"Over",@"Mdns",@"Runs",@"Wkts",@"BBI",@"Ave",@"Eco",@"SR",@"3 W",@"5 W",@"Ct",@"St"];
    
    [self.resultCollectionView registerNib:[UINib nibWithNibName:@"PlayerListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ContentCellIdentifier"];
    
    
    self.resultCollectionView.delegate = self;
    self.resultCollectionView.dataSource = self;
    
}


#pragma mark UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return headingBowlButtonNames.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return headingBowlButtonNames.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(IS_IPHONE_DEVICE)
    {
        if(!IS_IPHONE5)
        {
            return CGSizeMake(130, 35);
        }
        else
        {
            
            return CGSizeMake(150, 40);
        }
    }
    else
    {
        
        return CGSizeMake(200, 50);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PlayerListCollectionViewCell* cell = [self.resultCollectionView dequeueReusableCellWithReuseIdentifier:@"ContentCellIdentifier" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        
        cell.backgroundColor = [UIColor colorWithRed:44.0/255.0 green:167.0/255.0 blue:219.0/255.0 alpha:1.0];
        
        
        
        [cell.lblRightShadow setHidden:YES];
        cell.btnName.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        cell.btnName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        
        for (id value in headingBowlButtonNames) {
            
            if ([headingBowlButtonNames indexOfObject:value] == indexPath.row) {
                [cell.btnName setTitle:value forState:UIControlStateNormal];
                cell.btnName.secondTag = indexPath.row;
                cell.btnName.titleLabel.numberOfLines = 2;
                
                break;
            }
        }
        cell.btnName.userInteractionEnabled = YES;
        
    }
    else
    {
        [cell.lblRightShadow setHidden:(indexPath.row == 0 ? NO : YES)];
        if (!cell.lblRightShadow.isHidden) {
            cell.lblRightShadow.clipsToBounds = NO;
            [self setShadow:cell.lblRightShadow.layer];
        }
        
        if (indexPath.section % 2 != 0) {
            cell.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0];
            
        }else
        {
            cell.backgroundColor = [UIColor whiteColor];
        }
        [cell.btnName setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        
        cell.btnName.userInteractionEnabled = NO;
        
        
        for (id temp in headingBowlKeyArray) {
            if ([headingBowlKeyArray indexOfObject:temp] == indexPath.row) {
                // NSString* str = [AppCommon checkNull:[[PlayerListArray objectAtIndex:indexPath.section-1]valueForKey:temp]];
                if([temp isEqualToString:@"Player"])
                {
                    cell.btnName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                    cell.btnName.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                    //NSLog(@"Player Name %@ ",str);
                }
                else
                {
                    cell.btnName.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
                    cell.btnName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                }
                [cell.btnName setTitle:[NSString stringWithFormat:@"T %ld",indexPath.section-1] forState:UIControlStateNormal];
                break;
            }
        }
        
    }
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return;
    }
    //    PlayerStatsVC * nextVC = [[PlayerStatsVC alloc]init];
    //    nextVC = (PlayerStatsVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"PlayerStats"];
    //    nextVC.SelectedPlayerCode = [[PlayerListArray objectAtIndex:indexPath.section-1] valueForKey:@"PlayerCode"];
    //    [self.navigationController pushViewController:nextVC animated:YES];
    
}
-(void)setShadow:(CALayer *)layer
{
    layer.shadowColor = [[UIColor blackColor] CGColor];
    layer.shadowOffset = CGSizeMake(10,3);
    layer.shadowOpacity = 1.0;
    
}



/*  Chart  */
-(void) loadChart

{
    
    
//    [self setupBarLineChartView:_chartView];
    
    _chartView.delegate = self;

    _chartView.drawBarShadowEnabled = NO;
    _chartView.drawValueAboveBarEnabled = YES;
    
    _chartView.maxVisibleCount = 60;

    _chartView.chartDescription.enabled = NO;
    
    ChartXAxis *xAxis = _chartView.xAxis;
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
    
    ChartYAxis *leftAxis = _chartView.leftAxis;
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
    leftAxis.labelCount = 8;
    leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:leftAxisFormatter];
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    leftAxis.spaceTop = 0.15;
    leftAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    ChartYAxis *rightAxis = _chartView.rightAxis;
    rightAxis.enabled = YES;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.labelFont = [UIFont systemFontOfSize:10.f];
    rightAxis.labelCount = 8;
    rightAxis.valueFormatter = leftAxis.valueFormatter;
    rightAxis.spaceTop = 0.15;
    rightAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    ChartLegend *l = _chartView.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
    l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    l.orientation = ChartLegendOrientationHorizontal;
    l.drawInside = NO;
    l.form = ChartLegendFormSquare;
    l.formSize = 9.0;
    l.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
    l.xEntrySpace = 4.0;
    l.enabled = NO;
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
    if (_chartView.data.dataSetCount > 0)
    {
        set1 = (BarChartDataSet *)_chartView.data.dataSets[0];
        set1.values = yVals;
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
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
        
        _chartView.data = data;
    }
}

//- (void)optionTapped:(NSString *)key
//{
//    [super handleOption:key forChartView:_chartView];
//}

#pragma mark - Actions

//- (IBAction)slidersValueChanged:(id)sender
//{
//    _sliderTextX.text = [@((int)_sliderX.value + 2) stringValue];
//    _sliderTextY.text = [@((int)_sliderY.value) stringValue];
//
//    [self updateChartData];
//}

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
