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

@interface WellnessTrainingBowlingVC ()<ChartViewDelegate>
{
    AddWellnessRatingVC * objWell;
    TrainingLoadVC * objtraing;
    WebService *objWebservice;
    
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

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topviewHeight;


@property (strong, nonatomic) IBOutlet UISlider *sleepSlider;
@property (strong, nonatomic) IBOutlet UISlider *fatiqueSlider;
@property (strong, nonatomic) IBOutlet UISlider *muscleSlider;
@property (strong, nonatomic) IBOutlet UISlider *stressSlider;

@property (strong, nonatomic)  NSMutableArray *sleeplist;
@property (strong, nonatomic)  NSMutableArray *fatiqlist;
@property (strong, nonatomic)  NSMutableArray *sorelist;
@property (strong, nonatomic)  NSMutableArray *stresslist;

@property (strong, nonatomic)  NSMutableArray *sleeplist1;
@property (strong, nonatomic)  NSMutableArray *fatiqlist1;
@property (strong, nonatomic)  NSMutableArray *sorelist1;
@property (strong, nonatomic)  NSMutableArray *stresslist1;


@end

@implementation WellnessTrainingBowlingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    objtraing = [[TrainingLoadVC alloc] initWithNibName:@"TrainingLoadVC" bundle:nil];
    objtraing.view.frame = CGRectMake(0,10, self.trainingview.bounds.size.width, self.trainingview.bounds.size.height);
    [self.trainingview addSubview:objtraing.view];
    
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
    
     //[self updateChartData];
    
    [self metacodeWebservice];
}
- (IBAction)AddBtnAction:(id)sender {
    
    objWell = [[AddWellnessRatingVC alloc] initWithNibName:@"AddWellnessRatingVC" bundle:nil];
    objWell.view.frame = CGRectMake(0,0, self.topView.bounds.size.width, self.topView.bounds.size.height);
    [self.topView addSubview:objWell.view];
    
    self.topviewHeight.constant = 578;
    
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

-(void)SaveWebservice
{
    [AppCommon showLoading ];
    
    NSString *ClientCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    NSString *UserrefCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
    NSString *playerCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
    NSString *usercode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
    
    NSString *sleepValue =[NSString stringWithFormat:@"%f" , self.sleepSlider.value];
     NSString *fatiqueValue =[NSString stringWithFormat:@"%f" , self.fatiqueSlider.value];
    NSString *sorenessValue =[NSString stringWithFormat:@"%f" , self.muscleSlider.value];
    NSString *stressValue =[NSString stringWithFormat:@"%f" , self.fatiqueSlider.value];
    
    
    [objWebservice submit  :recordInsert :ClientCode :usercode:@"":playerCode:sleepValue:fatiqueValue:sorenessValue:stressValue success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        if(responseObject >0)
        {
            BOOL Status = [responseObject valueForKey:@"Status"];
            if(Status == YES)
            {
                NSLog(@"success");
                //[self ShowAlterMsg:@"Wellness Rating Inserted Successfully"];
                
                // [self.pieChartRight reloadData];
            }
            
        }
        
        [AppCommon hideLoading];

        
        
    }
                   failure:^(AFHTTPRequestOperation *operation, id error) {
                       NSLog(@"failed");
                       [COMMON webServiceFailureError:error];
                       
                   }];
    
}


-(void)metacodeWebservice
{
    
    [AppCommon showLoading];
    NSString *cliendcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    
    NSString *Rc=@"RC14";
    
    
    
    [objWebservice getmetacodelist :metasubKey :cliendcode :Rc success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        if(responseObject >0)
        {
            self.sleeplist = [[NSMutableArray alloc]init];
            self.fatiqlist = [[NSMutableArray alloc]init];
            self.sorelist = [[NSMutableArray alloc]init];
            self.stresslist = [[NSMutableArray alloc]init];
            
            
            self.sleeplist = [responseObject valueForKey:@"Sleeps"];
            self.fatiqlist = [responseObject valueForKey:@"Fatigues"];
            self.sorelist = [responseObject valueForKey:@"MuscleSoreNesses"];
            self.stresslist = [responseObject valueForKey:@"Stresses"];
            
            self.sleeplist1 = ([[self.sleeplist valueForKey:@"MetaSubCode"] isEqual:[NSNull null]])?@"":[self.sleeplist valueForKey:@"MetaSubCode"];
            
            self.fatiqlist1 = ([[self.fatiqlist valueForKey:@"MetaSubCode"] isEqual:[NSNull null]])?@"":[self.fatiqlist valueForKey:@"MetaSubCode"];
            
            self.sorelist1 = ([[self.sorelist valueForKey:@"MetaSubCode"] isEqual:[NSNull null]])?@"":[self.sorelist valueForKey:@"MetaSubCode"];
            
            self.stresslist1 = ([[self.stresslist valueForKey:@"MetaSubCode"] isEqual:[NSNull null]])?@"":[self.stresslist valueForKey:@"MetaSubCode"];
            
            
        }
        [AppCommon hideLoading];
        
        
     
    } failure:^(AFHTTPRequestOperation *operation, id error) {
        NSLog(@"failed");
        [COMMON webServiceFailureError:error];
    }];
    
}

- (IBAction)SleepSliderAction:(id)sender {
    
    NSLog(@"%.f",self.sleepSlider.value);
    // value1 = [NSString stringWithFormat:@"%.f",self.sleepSlider.value];
    
    num1 = [self.sleepSlider value];
    
    NSLog(@"%f",num1);
    
    if(num1 ==0)
    {
        
    }
    
    if(num1 >0.1 && num1 <=1 )
    {
  
        metaSubCode1 = [self.sleeplist1 objectAtIndex:0];
  
        
    }
    if(num1 >1.1 && num1 <= 2)
    {
        
        metaSubCode1 = [self.sleeplist1 objectAtIndex:1];
        
    }
    
    if(num1 >2.1 && num1 <= 3)
    {
       
        
        metaSubCode1 = [self.sleeplist1 objectAtIndex:2];
        
    }
    
    if(num1 > 3.1 && num1 <= 4 )
    {
        
        
        metaSubCode1 = [self.sleeplist1 objectAtIndex:3];
        
    }
    
    if(num1 >4.1 && num1 <= 5 )
    {

        metaSubCode1 = [self.sleeplist1 objectAtIndex:4];
    
    }
    if(num1 >5.1 && num1 <= 6)
    {
       
        metaSubCode1 = [self.sleeplist1 objectAtIndex:5];
       
    }
    if(num1 >6.1 && num1 <= 7)
    {
       
        metaSubCode1 = [self.sleeplist1 objectAtIndex:6];
        
    }
    
   
    
    
}

- (IBAction)FatiqueSliderAction:(id)sender {
    
    
    num2 = [self.fatiqueSlider value];
    
    
    NSLog(@"%f",num2);
    
    if(num2 ==0)
    {
        
    }
    
    if(num2 >0.1 && num2 <=1 )
    {
       
        metaSubCode2 = [self.fatiqlist1 objectAtIndex:0];
        
        
    }
    if(num2 >1.1 && num2 <= 2)
    {
        
        metaSubCode2 = [self.fatiqlist1 objectAtIndex:1];
      
    }
    
    if(num2 >2.1 && num2 <= 3)
    {
        metaSubCode2 = [self.fatiqlist1 objectAtIndex:2];
      
    }
    
    if(num2 > 3.1 && num2 <= 4 )
    {
        
        
        metaSubCode2 = [self.fatiqlist1 objectAtIndex:3];
        
    }
    
    if(num2 >4.1 && num2 <= 5 )
    {
        
        metaSubCode2 = [self.fatiqlist1 objectAtIndex:4];
        
    }
    if(num2 >5.1 && num2 <= 6)
    {
        
        metaSubCode2 = [self.fatiqlist1 objectAtIndex:5];
        
    }
    if(num2 >6.1 && num2 <= 7)
    {
        
        metaSubCode2 = [self.fatiqlist1 objectAtIndex:6];
        
    }
    
    
    
    
    
}

- (IBAction)MuscleSliderAction:(id)sender {
    
    
    num3 = [self.muscleSlider value];
    NSLog(@"%f",num2);
    
    if(num3 ==0)
    {
        
    }
    
    if(num3 >0.1 && num3 <=1 )
    {
      
        metaSubCode3 = [self.sorelist1 objectAtIndex:0];
        
    }
    if(num3 >1.1 && num3 <= 2)
    {
        
        metaSubCode3 = [self.sorelist1 objectAtIndex:1];
        
    }
    
    if(num3 >2.1 && num3 <= 3)
    {
       
        metaSubCode3 = [self.sorelist1 objectAtIndex:2];
        
    }
    
    if(num3 > 3.1 && num3 <= 4 )
    {
        
        
        metaSubCode3 = [self.sorelist1 objectAtIndex:3];
     
    }
    
    if(num3 >4.1 && num3 <= 5 )
    {
        
        metaSubCode3 = [self.sorelist1 objectAtIndex:4];
      
    }
    if(num3 >5.1 && num3 <= 6)
    {
        
        metaSubCode3 = [self.sorelist1 objectAtIndex:5];
      
    }
    if(num3 >6.1 && num3 <= 7)
    {
        
        metaSubCode3 = [self.sorelist1 objectAtIndex:6];
        
    }
    
    
    
    
    
}

- (IBAction)StressSliderAction:(id)sender {
    
     num4 = [self.stressSlider value];
    NSLog(@"%f",num4);
    
    if(num4 ==0)
    {
    
    }
    
    if(num4 >0.1 && num4 <=1 )
    {
       
        
        metaSubCode4 = [self.stresslist1 objectAtIndex:0];
        
        
        
        
    }
    if(num4 >1.1 && num4 <= 2)
    {

        
        metaSubCode4 = [self.stresslist1 objectAtIndex:1];
       
    }
    
    if(num4 >2.1 && num4 <= 3)
    {
        
        
        metaSubCode4 = [self.stresslist1 objectAtIndex:2];
        
    }
    
    if(num4 > 3.1 && num4 <= 4 )
    {
 
        metaSubCode4 = [self.stresslist1 objectAtIndex:3];

    }
    
    if(num4 >4.1 && num4 <= 5 )
    {
       
        metaSubCode4 = [self.stresslist1 objectAtIndex:4];
        
    }
    if(num4 >5.1 && num4 <= 6)
    {
       
        metaSubCode4 = [self.stresslist1 objectAtIndex:5];
        
    }
    if(num4 >6.1 && num4 <= 7)
    {
        
        metaSubCode4 = [self.stresslist1 objectAtIndex:6];
        
    }
    
}


@end
