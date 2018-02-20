//
//  WellnessTrainingBowlingVC.m
//  APT_V2
//
//  Created by Apple on 07/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "WellnessTrainingBowlingVC.h"
#import "AddWellnessRatingVC.h"
#import "HorizontalXLblFormatter.h"
#import "TrainingLoadVC.h"
#import "AppCommon.h"
#import "WebService.h"
#import "Config.h"
#import "TrainingLoadUpdateVC.h"
#import "TrainingLoadGraphVC.h"
#import "SWRevealViewController.h"

@interface WellnessTrainingBowlingVC ()<ChartViewDelegate>
{
    AddWellnessRatingVC * objWell;
    TrainingLoadVC * objtraing;
    WebService *objWebservice;
    TrainingLoadUpdateVC *objUpdate;
    
    TrainingLoadGraphVC *objTrGraph;
    
    float num1;
    float num2;
    float num3;
    float num4;
    
    NSString *metaSubCode1;
    NSString *metaSubCode2;
    NSString *metaSubCode3;
    NSString *metaSubCode4;
}

@property (nonatomic, strong) IBOutlet LineChartView *chartView;
@property (nonatomic, strong) IBOutlet UISlider *sliderX;
@property (nonatomic, strong) IBOutlet UISlider *sliderY;
@property (nonatomic, strong) IBOutlet UITextField *sliderTextX;
@property (nonatomic, strong) IBOutlet UITextField *sliderTextY;




@property (nonatomic, strong)  NSMutableArray *fetchedArray;

@property (nonatomic, strong)  NSMutableArray *BowlingloadXArray;
@property (nonatomic, strong)  NSMutableArray *BowlingloadYArray;



@end

@implementation WellnessTrainingBowlingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    objWebservice = [[WebService alloc]init];
    objtraing = [[TrainingLoadVC alloc] initWithNibName:@"TrainingLoadVC" bundle:nil];
    objtraing.view.frame = CGRectMake(0,10, self.trainingview.bounds.size.width, self.trainingview.bounds.size.height);
    [self.trainingview addSubview:objtraing.view];
    
    [self.fetchButton setTag:0];
    [self FetchWebservice];
   // [self BowlingLoadWebservice];
    
    [self.BowlingDailyBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    
   
}

-(void)viewWillAppear:(BOOL)animated
{
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController.panGestureRecognizer setEnabled:YES];
    [revealController.tapGestureRecognizer setEnabled:YES];
    
}
- (IBAction)AddtrainingBtnAction:(id)sender {
    
    objUpdate = [[TrainingLoadUpdateVC alloc] initWithNibName:@"TrainingLoadUpdateVC" bundle:nil];
    objUpdate.view.frame = CGRectMake(0,0, self.RootTrainingView.bounds.size.width, self.RootTrainingView.bounds.size.height);
    [self.RootTrainingView addSubview:objUpdate.view];
    self.traingViewHeight.constant = 600;
}
- (IBAction)AddBtnAction:(id)sender {
    
    objWell = [[AddWellnessRatingVC alloc] initWithNibName:@"AddWellnessRatingVC" bundle:nil];
    objWell.view.frame = CGRectMake(0,0, self.topView.bounds.size.width, self.topView.bounds.size.height);
    [self.topView addSubview:objWell.view];
    self.topviewHeight.constant = 578;
    
}

- (IBAction)FetchBtnAction:(id)sender {
    
    
    if(self.fetchButton.tag == 1)
    {
    
    objWell = [[AddWellnessRatingVC alloc] initWithNibName:@"AddWellnessRatingVC" bundle:nil];
    objWell.isFetch= @"yes";
        objWell.fetchArray = self.fetchedArray;
    objWell.view.frame = CGRectMake(0,0, self.topView.bounds.size.width, self.topView.bounds.size.height);
    [self.topView addSubview:objWell.view];
    self.topviewHeight.constant = 578;
    }
    
}

- (IBAction)MonthlyAction:(id)sender
{
    [self setInningsBySelection:@"3"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *CurrentDate = [NSDate date];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    NSString *newDateString = [dateFormatter stringFromDate:CurrentDate];
    NSArray *components = [newDateString componentsSeparatedByString:@"-"];
    NSString *month = components[0];
    NSString *year = components[2];
    NSString *day = @"01";
    
    NSString *firstDayDate = [NSString stringWithFormat:@"%@-%@-%@",month,day,year];
    [self BowlingLoadWebservice:firstDayDate:@"MONTHLY"];
}

- (IBAction)WeeklyAction:(id)sender
{
    [self setInningsBySelection:@"2"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *CurrentDate = [NSDate date];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    NSString *newDateString = [dateFormatter stringFromDate:CurrentDate];
    [self BowlingLoadWebservice:newDateString:@"WEEKLY"];
}
- (IBAction)DailyAction:(id)sender
{
    [self setInningsBySelection:@"1"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDate *CurrentDate = [NSDate date];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    NSString *newDateString = [dateFormatter stringFromDate:CurrentDate];
    [self BowlingLoadWebservice:newDateString:@"DAILY"];
}


-(BOOL)setHeight
{
    self.topviewHeight.constant = 280;
    return NO;
}

- (IBAction)TraingLoadGraohBtnAction:(id)sender {
    
    objTrGraph = [[TrainingLoadGraphVC alloc] initWithNibName:@"TrainingLoadGraphVC" bundle:nil];
    objTrGraph.view.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:objTrGraph.view];
}



-(void)FetchWebservice
{
    [AppCommon showLoading ];
    
    NSString *playerCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *matchdate = [NSDate date];
    [dateFormat setDateFormat:@"MM-dd-yyyy"];
    NSString * actualDate = [dateFormat stringFromDate:matchdate];
   // NSString *urinecolor= @"0";
    
    [objWebservice fetchWellness :FetchrecordWellness : playerCode :actualDate success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        arr = responseObject;
        if(arr.count >0)
        {
            if( ![[[responseObject valueForKey:@"BodyWeight"] objectAtIndex:0] isEqual:[NSNull null]])
            {
                self.bodyWeightlbl.text = [[responseObject valueForKey:@"BodyWeight"] objectAtIndex:0];
                
                [self.fetchButton setTag:1];
                self.fetchedArray = [[NSMutableArray alloc]init];
                self.fetchedArray = [responseObject objectAtIndex:0];
            }
            if(! [[[responseObject valueForKey:@"SleepHours"] objectAtIndex:0] isEqual:[NSNull null]])
            {
                self.sleepHrlbl.text = [[responseObject valueForKey:@"SleepHours"] objectAtIndex:0];
            }
            if( ![[[responseObject valueForKey:@"SleepRatingDescription"] objectAtIndex:0] isEqual:[NSNull null]])
            {
                NSString *sleepValue = [[responseObject valueForKey:@"SleepRatingDescription"] objectAtIndex:0];
                NSArray *component = [sleepValue componentsSeparatedByString:@" "];
                self.sleeplbl.text = [NSString stringWithFormat:@"%@/7",component[0]];
            
            
                if([component[0] isEqualToString:@"1"])
                {
                    self.SleepColorView.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(0/255.0f) blue:(24/255.0f) alpha:1.0f];
                }
                if([component[0] isEqualToString:@"2"])
                {
                    self.SleepColorView.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(102/255.0f) blue:(39/255.0f) alpha:1.0f];
                }
                if([component[0] isEqualToString:@"3"])
                {
                    self.SleepColorView.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(187/255.0f) blue:(64/255.0f) alpha:1.0f];
                }
                if([component[0] isEqualToString:@"4"])
                {
                    self.SleepColorView.backgroundColor = [UIColor colorWithRed:(242/255.0f) green:(249/255.0f) blue:(82/255.0f) alpha:1.0f];
                }
                if([component[0] isEqualToString:@"5"])
                {
                    self.SleepColorView.backgroundColor = [UIColor colorWithRed:(167/255.0f) green:(229/255.0f) blue:(79/255.0f) alpha:1.0f];
                }
                if([component[0] isEqualToString:@"6"])
                {
                    self.SleepColorView.backgroundColor = [UIColor colorWithRed:(96/255.0f) green:(208/255.0f) blue:(80/255.0f) alpha:1.0f];
                }
                if([component[0] isEqualToString:@"7"])
                {
                    self.SleepColorView.backgroundColor = [UIColor colorWithRed:(0/255.0f) green:(179/255.0f) blue:(88/255.0f) alpha:1.0f];
                }
            }

        if( ![[[responseObject valueForKey:@"FatigueRatingDescription"] objectAtIndex:0] isEqual:[NSNull null]])
        {
                NSString *fatiqueValue = [[responseObject valueForKey:@"FatigueRatingDescription"] objectAtIndex:0];
                NSArray *component1 = [fatiqueValue componentsSeparatedByString:@" "];
                self.fatiquelbl.text = [NSString stringWithFormat:@"%@/7",component1[0]];
            
            if([component1[0] isEqualToString:@"1"])
            {
                self.FatiqueColorView.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(0/255.0f) blue:(24/255.0f) alpha:1.0f];
            }
            if([component1[0] isEqualToString:@"2"])
            {
                self.FatiqueColorView.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(102/255.0f) blue:(39/255.0f) alpha:1.0f];
            }
            if([component1[0] isEqualToString:@"3"])
            {
                self.FatiqueColorView.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(187/255.0f) blue:(64/255.0f) alpha:1.0f];
            }
            if([component1[0] isEqualToString:@"4"])
            {
                self.FatiqueColorView.backgroundColor = [UIColor colorWithRed:(242/255.0f) green:(249/255.0f) blue:(82/255.0f) alpha:1.0f];
            }
            if([component1[0] isEqualToString:@"5"])
            {
                self.FatiqueColorView.backgroundColor = [UIColor colorWithRed:(167/255.0f) green:(229/255.0f) blue:(79/255.0f) alpha:1.0f];
            }
            if([component1[0] isEqualToString:@"6"])
            {
                self.FatiqueColorView.backgroundColor = [UIColor colorWithRed:(96/255.0f) green:(208/255.0f) blue:(80/255.0f) alpha:1.0f];
            }
            if([component1[0] isEqualToString:@"7"])
            {
                self.FatiqueColorView.backgroundColor = [UIColor colorWithRed:(0/255.0f) green:(179/255.0f) blue:(88/255.0f) alpha:1.0f];
            }
        }
            
        if( ![[[responseObject valueForKey:@"SoreNessRatingDescription"] objectAtIndex:0] isEqual:[NSNull null]])
        {
                
                NSString *muscleValue = [[responseObject valueForKey:@"SoreNessRatingDescription"] objectAtIndex:0];
                NSArray *component2 = [muscleValue componentsSeparatedByString:@" "];
                self.musclelbl.text = [NSString stringWithFormat:@"%@/7",component2[0]];
            
            if([component2[0] isEqualToString:@"1"])
            {
                self.MuscleColorView.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(0/255.0f) blue:(24/255.0f) alpha:1.0f];
            }
            if([component2[0] isEqualToString:@"2"])
            {
                self.MuscleColorView.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(102/255.0f) blue:(39/255.0f) alpha:1.0f];
            }
            if([component2[0] isEqualToString:@"3"])
            {
                self.MuscleColorView.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(187/255.0f) blue:(64/255.0f) alpha:1.0f];
            }
            if([component2[0] isEqualToString:@"4"])
            {
                self.MuscleColorView.backgroundColor = [UIColor colorWithRed:(242/255.0f) green:(249/255.0f) blue:(82/255.0f) alpha:1.0f];
            }
            if([component2[0] isEqualToString:@"5"])
            {
                self.MuscleColorView.backgroundColor = [UIColor colorWithRed:(167/255.0f) green:(229/255.0f) blue:(79/255.0f) alpha:1.0f];
            }
            if([component2[0] isEqualToString:@"6"])
            {
                self.MuscleColorView.backgroundColor = [UIColor colorWithRed:(96/255.0f) green:(208/255.0f) blue:(80/255.0f) alpha:1.0f];
            }
            if([component2[0] isEqualToString:@"7"])
            {
                self.MuscleColorView.backgroundColor = [UIColor colorWithRed:(0/255.0f) green:(179/255.0f) blue:(88/255.0f) alpha:1.0f];
            }
        }

        if( ![[[responseObject valueForKey:@"StressRatingDescription"] objectAtIndex:0] isEqual:[NSNull null]])
        {
                NSString *stressValue = [[responseObject valueForKey:@"StressRatingDescription"] objectAtIndex:0];
                NSArray *component3 = [stressValue componentsSeparatedByString:@" "];
                self.stresslbl.text = [NSString stringWithFormat:@"%@/7",component3[0]];
            
            if([component3[0] isEqualToString:@"1"])
            {
                self.StressColorView.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(0/255.0f) blue:(24/255.0f) alpha:1.0f];
            }
            if([component3[0] isEqualToString:@"2"])
            {
                self.StressColorView.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(102/255.0f) blue:(39/255.0f) alpha:1.0f];
            }
            if([component3[0] isEqualToString:@"3"])
            {
                self.StressColorView.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(187/255.0f) blue:(64/255.0f) alpha:1.0f];
            }
            if([component3[0] isEqualToString:@"4"])
            {
                self.StressColorView.backgroundColor = [UIColor colorWithRed:(242/255.0f) green:(249/255.0f) blue:(82/255.0f) alpha:1.0f];
            }
            if([component3[0] isEqualToString:@"5"])
            {
                self.StressColorView.backgroundColor = [UIColor colorWithRed:(167/255.0f) green:(229/255.0f) blue:(79/255.0f) alpha:1.0f];
            }
            if([component3[0] isEqualToString:@"6"])
            {
                self.StressColorView.backgroundColor = [UIColor colorWithRed:(96/255.0f) green:(208/255.0f) blue:(80/255.0f) alpha:1.0f];
            }
            if([component3[0] isEqualToString:@"7"])
            {
                self.StressColorView.backgroundColor = [UIColor colorWithRed:(0/255.0f) green:(179/255.0f) blue:(88/255.0f) alpha:1.0f];
            }
        }
           
            
        }
        [AppCommon hideLoading];
        
    }
    failure:^(AFHTTPRequestOperation *operation, id error) {
    NSLog(@"failed");
    [COMMON webServiceFailureError:error];
    }];
    
}


-(void)BowlingLoadWebservice : (NSString *)date : (NSString *)type
{
    [AppCommon showLoading ];
    
    NSString *playerCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
    
    objWebservice = [[WebService alloc]init];
    
    //NSString *dateString = self.datelbl.text;
    
    
    
    [objWebservice BowlingLoad :BowlingLoadKey : playerCode :date :type success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        
        if(responseObject >0)
        {
            
            NSMutableArray *reqArray = [[NSMutableArray alloc]init];
            reqArray = responseObject;
            
            self.BowlingloadXArray= [[NSMutableArray alloc]init];
            self.BowlingloadYArray = [[NSMutableArray alloc]init];
            
            for(int i=0;i<reqArray.count;i++)
            {
                int timecount = [[[reqArray valueForKey:@"DURATION"] objectAtIndex:i] intValue];
                int rpecount = [[[reqArray valueForKey:@"RPE"] objectAtIndex:i] intValue];
                int total = timecount * rpecount;
                [self.BowlingloadYArray addObject:[NSString stringWithFormat:@"%d",total]];
                [self.BowlingloadXArray addObject:[[reqArray valueForKey:@"WORKLOADDATE"] objectAtIndex:i]];
            }
            
            [self BowlingLoadChart];
        }
        [AppCommon hideLoading];
        
    }
    failure:^(AFHTTPRequestOperation *operation, id error) {
    NSLog(@"failed");
    [COMMON webServiceFailureError:error];
    }];
    
}

-(void)BowlingLoadChart
{
    
    
    self.title = @"Line Chart 2";
    
    _chartView.delegate = self;
    
    
    _chartView.chartDescription.enabled = NO;
    
    _chartView.dragEnabled = YES;
    [_chartView setScaleEnabled:YES];
    _chartView.drawGridBackgroundEnabled = NO;
    _chartView.pinchZoomEnabled = YES;
    
    //  _chartView.backgroundColor = [UIColor colorWithWhite:204/255.f alpha:1.f];
    _chartView.backgroundColor = [UIColor whiteColor];
    
    ChartLegend *l = _chartView.legend;
    l.form = ChartLegendFormLine;
    l.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
    l.textColor = UIColor.whiteColor;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
    l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    l.orientation = ChartLegendOrientationHorizontal;
    l.drawInside = NO;
    
    
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelFont = [UIFont systemFontOfSize:11.f];
    xAxis.labelTextColor = UIColor.blackColor;
    xAxis.drawGridLinesEnabled = NO;
    xAxis.drawAxisLineEnabled = NO;
    xAxis.labelPosition = UIBarPositionBottom;
    
    //NSArray *array = @[@"mon",@"tue",@"wed",@"thurs",@"friday",@"sat",@"sun",@"mon",@"tue",@"wed",@"thurs",@"friday",@"sat",@"sun",@"mon",@"tue",@"wed",@"thurs",@"friday",@"sat",@"sun"];
    xAxis.valueFormatter = [[HorizontalXLblFormatter alloc] initForChart: self.BowlingloadXArray];
    
    
    
    ChartYAxis *leftAxis = _chartView.leftAxis;
    leftAxis.labelTextColor = [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f];
    leftAxis.axisMaximum = 100.0;
    leftAxis.axisMinimum = 0.0;
    leftAxis.drawGridLinesEnabled = YES;
    leftAxis.drawZeroLineEnabled = NO;
    leftAxis.granularityEnabled = YES;
    
    ChartYAxis *rightAxis = _chartView.rightAxis;
    rightAxis.labelTextColor = UIColor.redColor;
    rightAxis.axisMaximum = 0;
    rightAxis.axisMinimum = 0;
    rightAxis.drawGridLinesEnabled = NO;
    rightAxis.granularityEnabled = NO;
    
    
    _sliderX.value = 14;
    _sliderY.value = 14;
    [self slidersValueChanged:nil];
    
    [_chartView animateWithXAxisDuration:2.5];
}


- (void)updateChartData
{
    //    if (self.shouldHideData)
    //    {
    //        _chartView.data = nil;
    //        return;
    //    }
    
    [self setDataCount:_sliderX.value+1 range:_sliderY.value];
}

- (void)setDataCount:(int)count range:(double)range
{
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    double spaceforbar = 10.0;
    
    //NSArray *array = @[@"10",@"20",@"30",@"20",@"40",@"60",@"20",@"70",@"20",@"30",@"20",@"40",@"60",@"20",@"70",@"20",@"30",@"20",@"40",@"60",@"20"];
    //NSArray *array1 = @[@"mon",@"tue",@"wed",@"thurs",@"friday",@"sat",@"sun",@"mon",@"tue",@"wed",@"thurs",@"friday",@"sat",@"sun"];
    //NSArray *array1 = @[@"mon",@"tue",@"wed",@"thursday",@"friday"];
    for (int i = 0; i < self.BowlingloadYArray.count; i++)
    {
        //        double mult = range / 2.0;
        //        double val = (double) (arc4random_uniform(mult)) + 50;
        
        double val = [self.BowlingloadYArray[i] doubleValue];
        //double val1 = [array1[i] doubleValue];
        [yVals1 addObject:[[ChartDataEntry alloc] initWithX:i*spaceforbar y:val]];
    }
    
    
    
    LineChartDataSet *set1 = nil;
    
    if (_chartView.data.dataSetCount > 0)
    {
        set1 = (LineChartDataSet *)_chartView.data.dataSets[0];
        set1.values = yVals1;
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[LineChartDataSet alloc] initWithValues:yVals1 label:@"DataSet 1"];
        set1.axisDependency = AxisDependencyLeft;
        [set1 setColor:[UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]];
        [set1 setCircleColor:UIColor.blackColor];
        set1.lineWidth = 2.0;
        set1.circleRadius = 3.0;
        set1.fillAlpha = 65/255.0;
        set1.fillColor = [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f];
        set1.highlightColor = [UIColor colorWithRed:244/255.f green:117/255.f blue:117/255.f alpha:1.f];
        set1.drawCircleHoleEnabled = NO;
        
        
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
        [data setValueTextColor:UIColor.blackColor];
        [data setValueFont:[UIFont systemFontOfSize:9.f]];
        
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
    NSLog(@"chartValueSelected");
    
    [_chartView centerViewToAnimatedWithXValue:entry.x yValue:entry.y axis:[_chartView.data getDataSetByIndex:highlight.dataSetIndex].axisDependency duration:1.0];
    
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}



-(void) setInningsBySelection: (NSString*) innsNo{
    
    [self setInningsButtonUnselect:self.BowlingDailyBtn];
    [self setInningsButtonUnselect:self.BowlingWeeklyBtn];
    [self setInningsButtonUnselect:self.BowlingMonthlyBtn];
    
    if([innsNo isEqualToString:@"1"]){
        
        [self setInningsButtonSelect:self.BowlingDailyBtn];
        
    }else if([innsNo isEqualToString:@"2"]){
        
        [self setInningsButtonSelect:self.BowlingWeeklyBtn];
    }
    else if([innsNo isEqualToString:@"3"]){
        
        [self setInningsButtonSelect:self.BowlingMonthlyBtn];
    }
    
}

-(UIColor*)colorWithHexString:(NSString*)hex
{
    //-----------------------------------------
    // Convert hex string to an integer
    //-----------------------------------------
    unsigned int hexint = 0;
    
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hex];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet
                                       characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&hexint];
    
    //-----------------------------------------
    // Create color object, specifying alpha
    //-----------------------------------------
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:1.0f];
    
    return color;
}

-(void) setInningsButtonSelect : (UIButton*) innsBtn{
    // innsBtn.layer.cornerRadius = 25;
    UIColor *extrasBrushBG = [self colorWithHexString : @"#1C1A44"];
    
    innsBtn.layer.backgroundColor = extrasBrushBG.CGColor;
    [innsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}

-(void) setInningsButtonUnselect : (UIButton*) innsBtn{
    //  innsBtn.layer.cornerRadius = 25;
    UIColor *extrasBrushBG = [self colorWithHexString : @"#C8C8C8"];
    
    innsBtn.layer.backgroundColor = extrasBrushBG.CGColor;
    [innsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
}





@end
