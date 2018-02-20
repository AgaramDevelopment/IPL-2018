//
//  TrainingLoadGraphVC.m
//  APT_V2
//
//  Created by Apple on 19/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "TrainingLoadGraphVC.h"
#import "AppCommon.h"
#import "WebService.h"
#import "Config.h"

#define ITEM_COUNT 12
@interface TrainingLoadGraphVC ()<ChartViewDelegate, IChartAxisValueFormatter>
{
    NSMutableArray *months;
    
    WebService *objWebservice;
    
    BOOL isBar;
    BOOL isLine;
    
    NSString *barValue;
    NSString *lineValue;
}

@property (nonatomic, strong) IBOutlet CombinedChartView *chartView;

@property (nonatomic, strong)  NSMutableArray *chartYvalues;
@property (nonatomic, strong)  NSMutableArray *filterListNameArray;
@property (nonatomic, strong)IBOutlet  NSLayoutConstraint *tableWidth;
@property (nonatomic, strong)IBOutlet  NSLayoutConstraint *tableXposition;



@end

@implementation TrainingLoadGraphVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.PoplistTable.hidden = YES;
    self.title = @"Combined Chart";
    

//   // months = @[
//               @"Jan", @"Feb", @"Mar",
//               @"Apr", @"May", @"Jun",
//               @"Jul", @"Aug", @"Sep",
//               @"Oct", @"Nov", @"Dec"
//               ];
    
   
    
    
    
    _chartView.delegate = self;
    
    _chartView.chartDescription.enabled = NO;
    
    _chartView.drawGridBackgroundEnabled = NO;
    _chartView.drawBarShadowEnabled = NO;
    _chartView.highlightFullBarEnabled = NO;
    
    _chartView.drawOrder = @[
                             @(CombinedChartDrawOrderBar),
                             @(CombinedChartDrawOrderBubble),
                             @(CombinedChartDrawOrderCandle),
                             @(CombinedChartDrawOrderLine),
                             @(CombinedChartDrawOrderScatter)
                             ];
    
    ChartLegend *l = _chartView.legend;
    l.wordWrapEnabled = YES;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentCenter;
    l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    l.orientation = ChartLegendOrientationHorizontal;
    l.drawInside = NO;
    
    ChartYAxis *rightAxis = _chartView.rightAxis;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    ChartYAxis *leftAxis = _chartView.leftAxis;
    leftAxis.drawGridLinesEnabled = NO;
    leftAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBothSided;
    xAxis.axisMinimum = 0.0;
    xAxis.granularity = 1.0;
    xAxis.valueFormatter = self;
    
    [self updateChartData];
    
    [self BarAndLineFilterWebservice];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)BackBtnAction:(id)sender
{
    
    [self.view removeFromSuperview];
}


- (IBAction)barValueBtnAction:(id)sender
{
    isBar = YES;
    isLine = NO;
    
     self.PoplistTable.hidden = NO;
    
    self.tableWidth.constant = self.barfilterView.frame.size.width-7;
    self.tableXposition.constant = self.barfilterView.frame.origin.x+8;
    
}

- (IBAction)LineValueBtnAction:(id)sender
{
    isBar = NO;
    isLine = YES;
    self.PoplistTable.hidden = NO;
    self.tableWidth.constant = self.linefilterView.frame.size.width-7;
    self.tableXposition.constant = self.linefilterView.frame.origin.x+8;
}

- (void)updateChartData
{
//    if (self.shouldHideData)
//    {
//        _chartView.data = nil;
//        return;
//    }
    
    [self setChartData];
}

- (void)setChartData
{
    CombinedChartData *data = [[CombinedChartData alloc] init];
    data.lineData = [self generateLineData];
    data.barData = [self generateBarData];
    //data.bubbleData = [self generateBubbleData];
    //data.scatterData = [self generateScatterData];
    //data.candleData = [self generateCandleData];
    
    _chartView.xAxis.axisMaximum = data.xMax + 0.25;
    
    _chartView.data = data;
}


- (LineChartData *)generateLineData
{
    LineChartData *d = [[LineChartData alloc] init];
    
    NSMutableArray *entries = [[NSMutableArray alloc] init];
    
    for (int index = 0; index < ITEM_COUNT; index++)
    {
        [entries addObject:[[ChartDataEntry alloc] initWithX:index + 0.5 y:(arc4random_uniform(15) + 5)]];
    }
    
    LineChartDataSet *set = [[LineChartDataSet alloc] initWithValues:entries label:@"Line DataSet"];
    [set setColor:[UIColor colorWithRed:240/255.f green:238/255.f blue:70/255.f alpha:1.f]];
    set.lineWidth = 2.5;
    [set setCircleColor:[UIColor colorWithRed:240/255.f green:238/255.f blue:70/255.f alpha:1.f]];
    set.circleRadius = 5.0;
    set.circleHoleRadius = 2.5;
    set.fillColor = [UIColor colorWithRed:240/255.f green:238/255.f blue:70/255.f alpha:1.f];
    set.mode = LineChartModeCubicBezier;
    set.drawValuesEnabled = YES;
    set.valueFont = [UIFont systemFontOfSize:10.f];
    set.valueTextColor = [UIColor colorWithRed:240/255.f green:238/255.f blue:70/255.f alpha:1.f];
    
    set.axisDependency = AxisDependencyLeft;
    
    [d addDataSet:set];
    
    return d;
}

- (BarChartData *)generateBarData
{
    NSMutableArray<BarChartDataEntry *> *entries1 = [[NSMutableArray alloc] init];
    NSMutableArray<BarChartDataEntry *> *entries2 = [[NSMutableArray alloc] init];
    
    for (int index = 0; index < ITEM_COUNT; index++)
    {
        [entries1 addObject:[[BarChartDataEntry alloc] initWithX:0.0 y:(arc4random_uniform(25) + 25)]];
        
        // stacked
        
        //[entries2 addObject:[[BarChartDataEntry alloc] initWithX:0.0 yValues:@[@(arc4random_uniform(13) + 12), @(arc4random_uniform(13) + 12)]]];
    }
    
    BarChartDataSet *set1 = [[BarChartDataSet alloc] initWithValues:entries1 label:@"Bar 1"];
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



-(void)BarAndLineFilterWebservice
{
    [AppCommon showLoading ];
    
    NSString *playerCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
    NSString *clientCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    
    objWebservice = [[WebService alloc]init];
    
    //NSString *dateString = self.datelbl.text;
    
    
    
    [objWebservice trainingGraphFilter :dropdownActivityKey : clientCode :playerCode:@"''":@"''":@"''":@"''" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        
        if(responseObject >0)
        {
            self.filterListNameArray = [[NSMutableArray alloc]init];
            self.filterListNameArray = [responseObject valueForKey:@"ActivityTypes"];
           
            [self.PoplistTable reloadData];
        }
        [AppCommon hideLoading];
        
    }
    failure:^(AFHTTPRequestOperation *operation, id error) {
    NSLog(@"failed");
    [COMMON webServiceFailureError:error];
    }];
    
}


#pragma mark - UITableViewDataSource
// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.filterListNameArray.count;
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

        cell.textLabel.text = [[self.filterListNameArray valueForKey:@"MetaSubcodeDescription"] objectAtIndex:indexPath.row];
        cell.selectionStyle = UIAccessibilityTraitNone;
    
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(isBar==YES)
    {
        if(![lineValue isEqualToString:[[self.filterListNameArray valueForKey:@"MetaSubCode"] objectAtIndex:indexPath.row]])
        {
        self.barfilterlbl.text = [[self.filterListNameArray valueForKey:@"MetaSubcodeDescription"] objectAtIndex:indexPath.row];
        barValue = [[self.filterListNameArray valueForKey:@"MetaSubCode"] objectAtIndex:indexPath.row];
        self.PoplistTable.hidden = YES;
            if([self.barfilterlbl.text isEqualToString:@""] || [self.barfilterlbl.text isEqualToString:@""] )
            {
                [self chartWebservice];
            }
        }
    }
    if(isLine==YES)
    {
        if(![barValue isEqualToString:[[self.filterListNameArray valueForKey:@"MetaSubCode"] objectAtIndex:indexPath.row]])
        {
        self.linefilterlbl.text = [[self.filterListNameArray valueForKey:@"MetaSubcodeDescription"] objectAtIndex:indexPath.row];
        lineValue = [[self.filterListNameArray valueForKey:@"MetaSubCode"] objectAtIndex:indexPath.row];
        
        self.PoplistTable.hidden = YES;
            
            if(![self.barfilterlbl.text isEqualToString:@""] || ![self.barfilterlbl.text isEqualToString:@""] )
            {
                [self chartWebservice];
            }
        }
    }
    
}


-(void)chartWebservice
{
    [AppCommon showLoading ];
    
    NSString *playerCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
    NSString *clientCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    
    objWebservice = [[WebService alloc]init];
    
    //NSString *dateString = self.datelbl.text;
    
    
    
    [objWebservice trainingGraphFilter :dropdownActivityKey : clientCode :playerCode:barValue:lineValue:@"02-19-2018":@"WEEKLY" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        
        if(responseObject >0)
        {
            if(![[responseObject valueForKey:@"WorkloadTrainingDetails1"] isEqual:[NSNull null]])
                {
            NSMutableArray *reqArrayBar  = [responseObject valueForKey:@"WorkloadTrainingDetails1"];
                    [self setChartValuesFromService:reqArrayBar];
                }
                
                if(![[responseObject valueForKey:@"WorkloadTrainingDetails2"] isEqual:[NSNull null]])
                    {
            NSMutableArray *reqArrayLine  = [responseObject valueForKey:@"WorkloadTrainingDetails2"];
                        [self setChartValuesFromService:reqArrayLine];
                    }
        }
        [AppCommon hideLoading];
        
    }
    failure:^(AFHTTPRequestOperation *operation, id error) {
    NSLog(@"failed");
    [COMMON webServiceFailureError:error];
    }];
    
}

-(void)setChartValuesFromService :(NSMutableArray *)reqArray1
{
    months = [[NSMutableArray alloc]init];
    
    for(int i =0;i<reqArray1.count;i++)
    {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setValue:[reqArray1 valueForKey:@"WORKLOADDATE"] forKey:@"Value"];
    [months addObject:dic];
    }
    [self setChartData];
}



@end
