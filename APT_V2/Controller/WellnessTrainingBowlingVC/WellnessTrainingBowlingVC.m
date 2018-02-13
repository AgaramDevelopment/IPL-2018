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

@interface WellnessTrainingBowlingVC ()<ChartViewDelegate>
{
    AddWellnessRatingVC * objWell;
    TrainingLoadVC * objtraing;
    WebService *objWebservice;
    TrainingLoadUpdateVC *objUpdate;
    
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








@end

@implementation WellnessTrainingBowlingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    objWebservice = [[WebService alloc]init];
    objtraing = [[TrainingLoadVC alloc] initWithNibName:@"TrainingLoadVC" bundle:nil];
    objtraing.view.frame = CGRectMake(0,10, self.trainingview.bounds.size.width, self.trainingview.bounds.size.height);
    [self.trainingview addSubview:objtraing.view];
    [objtraing.AddBtn addTarget:self action:@selector(AddtrainingBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    //self.topviewHeight.constant = 578;
    
    
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
    
    NSArray *array = @[@"mon",@"tue",@"wed",@"thurs",@"friday",@"sat",@"sun",@"mon",@"tue",@"wed",@"thurs",@"friday",@"sat",@"sun",@"mon",@"tue",@"wed",@"thurs",@"friday",@"sat",@"sun"];
    xAxis.valueFormatter = [[HorizontalXLblFormatter alloc] initForChart: array];
    
    
    
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
    
     [self FetchWebservice];
    
   
}
- (IBAction)AddtrainingBtnAction:(id)sender {
    
    objUpdate = [[TrainingLoadUpdateVC alloc] initWithNibName:@"TrainingLoadUpdateVC" bundle:nil];
    objUpdate.view.frame = CGRectMake(0,10, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.trainingview addSubview:objUpdate.view];
}
- (IBAction)AddBtnAction:(id)sender {
    
    objWell = [[AddWellnessRatingVC alloc] initWithNibName:@"AddWellnessRatingVC" bundle:nil];
    objWell.view.frame = CGRectMake(0,0, self.topView.bounds.size.width, self.topView.bounds.size.height);
    [self.topView addSubview:objWell.view];
    self.topviewHeight.constant = 578;
    
}

-(BOOL)setHeight
{
    self.topviewHeight.constant = 280;
    return NO;
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
    
    NSArray *array = @[@"10",@"20",@"30",@"20",@"40",@"60",@"20",@"70",@"20",@"30",@"20",@"40",@"60",@"20",@"70",@"20",@"30",@"20",@"40",@"60",@"20"];
    //NSArray *array1 = @[@"mon",@"tue",@"wed",@"thurs",@"friday",@"sat",@"sun",@"mon",@"tue",@"wed",@"thurs",@"friday",@"sat",@"sun"];
    //NSArray *array1 = @[@"mon",@"tue",@"wed",@"thursday",@"friday"];
    for (int i = 0; i < array.count; i++)
    {
//        double mult = range / 2.0;
//        double val = (double) (arc4random_uniform(mult)) + 50;
        
        double val = [array[i] doubleValue];
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



-(void)FetchWebservice
{
    [AppCommon showLoading ];
    
    NSString *playerCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *matchdate = [NSDate date];
    [dateFormat setDateFormat:@"MM-dd-yyyy"];
    NSString * actualDate = [dateFormat stringFromDate:matchdate];
    
    
    [objWebservice fetchWellness :FetchrecordWellness : playerCode :actualDate success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        if(responseObject >0)
        {
        
                self.bodyWeightlbl.text = [responseObject valueForKey:@"BodyWeight"];
                self.sleepHrlbl.text = [responseObject valueForKey:@"SleepHours"];
                
                NSString *sleepValue = [responseObject valueForKey:@"SleepRatingDescription"];
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

                
                NSString *fatiqueValue = [responseObject valueForKey:@"FatigueRatingDescription"];
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

                
                NSString *muscleValue = [responseObject valueForKey:@"SoreNessRatingDescription"];
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

                
                NSString *stressValue = [responseObject valueForKey:@"StressRatingDescription"];
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
        [AppCommon hideLoading];
        
    }
    failure:^(AFHTTPRequestOperation *operation, id error) {
    NSLog(@"failed");
    [COMMON webServiceFailureError:error];
    }];
    
}








@end
