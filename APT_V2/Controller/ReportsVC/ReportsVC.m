//
//  ReportsVC.m
//  APT_V2
//
//  Created by Apple on 21/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "ReportsVC.h"
#import "CustomNavigation.h"
#import "SWRevealViewController.h"
#import "AppCommon.h"
#import "WebService.h"
#import "Config.h"

@interface ReportsVC () <ChartViewDelegate>
{
    WebService *objWebservice;
}

@property (nonatomic, strong) IBOutlet BarChartView *chartView;
@property (nonatomic, strong) IBOutlet UISlider *sliderX;
@property (nonatomic, strong) IBOutlet UISlider *sliderY;
@property (nonatomic, strong) IBOutlet UITextField *sliderTextX;
@property (nonatomic, strong) IBOutlet UITextField *sliderTextY;

@property (nonatomic, strong)  NSMutableArray *chartValuesArray;

@end

@implementation ReportsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    [self customnavigationmethod];
    [self chartWebservice];
}

-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    
    UIView* view= self.view.subviews.firstObject;
    [view addSubview:objCustomNavigation.view];
    
    BOOL isBackEnable = [[NSUserDefaults standardUserDefaults] boolForKey:@"BACK"];
    
    if (isBackEnable) {
        objCustomNavigation.menu_btn.hidden =YES;
        objCustomNavigation.btn_back.hidden =NO;
        [objCustomNavigation.btn_back addTarget:self action:@selector(actionBack) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        objCustomNavigation.menu_btn.hidden =NO;
        objCustomNavigation.btn_back.hidden =YES;
        [objCustomNavigation.menu_btn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.navi_View addSubview:objCustomNavigation.view];
    //    objCustomNavigation.tittle_lbl.text=@"";
}

-(void)actionBack
{
    [appDel.frontNavigationController popViewControllerAnimated:YES];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"BACK"];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setChartData
{
    self.title = @"Stacked Bar Chart";
    
    //    self.options = @[
    //                     @{@"key": @"toggleValues", @"label": @"Toggle Values"},
    //                     @{@"key": @"toggleIcons", @"label": @"Toggle Icons"},
    //                     @{@"key": @"toggleHighlight", @"label": @"Toggle Highlight"},
    //                     @{@"key": @"animateX", @"label": @"Animate X"},
    //                     @{@"key": @"animateY", @"label": @"Animate Y"},
    //                     @{@"key": @"animateXY", @"label": @"Animate XY"},
    //                     @{@"key": @"saveToGallery", @"label": @"Save to Camera Roll"},
    //                     @{@"key": @"togglePinchZoom", @"label": @"Toggle PinchZoom"},
    //                     @{@"key": @"toggleAutoScaleMinMax", @"label": @"Toggle auto scale min/max"},
    //                     @{@"key": @"toggleData", @"label": @"Toggle Data"},
    //                     @{@"key": @"toggleBarBorders", @"label": @"Show Bar Borders"},
    //                     ];
    
    _chartView.delegate = self;
    
    _chartView.chartDescription.enabled = NO;
    
    _chartView.maxVisibleCount = 40;
    _chartView.pinchZoomEnabled = NO;
    _chartView.drawGridBackgroundEnabled = NO;
    _chartView.drawBarShadowEnabled = NO;
    _chartView.drawValueAboveBarEnabled = NO;
    _chartView.highlightFullBarEnabled = NO;
    
    NSNumberFormatter *leftAxisFormatter = [[NSNumberFormatter alloc] init];
    leftAxisFormatter.maximumFractionDigits = 1;
    leftAxisFormatter.negativeSuffix = @" $";
    leftAxisFormatter.positiveSuffix = @" $";
    
    ChartYAxis *leftAxis = _chartView.leftAxis;
    leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:leftAxisFormatter];
    leftAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    _chartView.rightAxis.enabled = NO;
    
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionTop;
    
    ChartLegend *l = _chartView.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
    l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    l.orientation = ChartLegendOrientationHorizontal;
    l.drawInside = NO;
    l.form = ChartLegendFormSquare;
    l.formSize = 8.0;
    l.formToTextSpace = 4.0;
    l.xEntrySpace = 6.0;
    
    _sliderX.value = 20.0;
    _sliderY.value = 100.0;
    [self slidersValueChanged:nil];
}

- (void)updateChartData
{
//    if (self.shouldHideData)
//    {
//        _chartView.data = nil;
//        return;
//    }
    
    [self setDataCount:_sliderX.value + 1 range:_sliderY.value];
}

- (void)setDataCount:(int)count range:(double)range
{
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < self.chartValuesArray.count; i++)
    {
//        double mult = (range + 1);
//        double val1 = (double) (arc4random_uniform(mult) + mult / 3);
//        double val2 = (double) (arc4random_uniform(mult) + mult / 3);
//        double val3 = (double) (arc4random_uniform(mult) + mult / 3);
        
        double val1 = [[[self.chartValuesArray valueForKey:@"SleepRating"]objectAtIndex:i] doubleValue];
        double val2 = [[[self.chartValuesArray valueForKey:@"FatigueRating"]objectAtIndex:i] doubleValue];
        double val3 = [[[self.chartValuesArray valueForKey:@"SoreNessRating"]objectAtIndex:i] doubleValue];
        
        double val4 = [[[self.chartValuesArray valueForKey:@"StreeRating"]objectAtIndex:i] doubleValue];
        
        double val5 = [[[self.chartValuesArray valueForKey:@"URINECOLOUR"]objectAtIndex:i] doubleValue];
        
        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i yValues:@[@(val1), @(val2), @(val3),@(val4),@(val5)] icon: [UIImage imageNamed:@"icon"]]];
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
        set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@"Statistics Vienna 2014"];
        
        set1.drawIconsEnabled = NO;
        
        set1.colors = @[ChartColorTemplates.material[0], ChartColorTemplates.material[1], ChartColorTemplates.material[2]];
        set1.stackLabels = @[@"Births", @"Divorces", @"Marriages"];
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.maximumFractionDigits = 1;
        formatter.negativeSuffix = @"";
        formatter.positiveSuffix = @"";
        
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:7.f]];
        [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:formatter]];
        [data setValueTextColor:UIColor.whiteColor];
        
        _chartView.fitBars = YES;
        _chartView.data = data;
    }
}


#pragma mark - Actions

- (IBAction)slidersValueChanged:(id)sender
{
    _sliderTextX.text = [@((int)_sliderX.value) stringValue];
    _sliderTextY.text = [@((int)_sliderY.value) stringValue];
    
    [self updateChartData];
}

#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    NSLog(@"chartValueSelected, stack-index %ld", (long)highlight.stackIndex);
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}


-(void)chartWebservice
{
    [AppCommon showLoading ];
    
    NSString *playerCode = @"AMR0000010";
    NSString *clientCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    NSString *date = @"02-21-2018";
    objWebservice = [[WebService alloc]init];
    
    //NSString *dateString = self.datelbl.text;
    
    
    
    [objWebservice CoachWellnessGraph:coachWellnessKey :playerCode : date :@"MONTHLY" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        
        if(responseObject >0)
        {
            NSMutableArray *reArray = [[NSMutableArray alloc]init];
            self.chartValuesArray = [[NSMutableArray alloc]init];
            if(![[responseObject valueForKey:@"WellnessChart"] isEqual:[NSNull null]])
            {
                self.chartValuesArray = [responseObject valueForKey:@"WellnessChart"];
                
                [self setChartData];
            }
            
        }
        [AppCommon hideLoading];
        
    }
                                failure:^(AFHTTPRequestOperation *operation, id error) {
                                    NSLog(@"failed");
                                    [COMMON webServiceFailureError:error];
                                }];
    
}


@end

