//
//  TrainingLoadVC.m
//  APT_V2
//
//  Created by MAC on 05/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "TrainingLoadVC.h"
#import "Config.h"
#import "XYPieChart.h"
#import "PieChartView.h"
#import "TrainingLoadUpdateVC.h"


@interface TrainingLoadVC ()<PieChartViewDelegate,PieChartViewDataSource>
{
    TrainingLoadUpdateVC *objUpdate;
    float num1;
    float num2;
    float num3;
    float num4;
    
     PieChartView *pieChartView1, *pieChartView2;
}

@end

@implementation TrainingLoadVC

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    
    self.markers = [[NSMutableArray alloc] initWithObjects:@"50.343", @"84.43", @"63.22", @"31.43", nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (IS_IPAD) {
        self.yesterdayViewWidth.constant = 100;
        self.yesterdayViewHeight.constant = 100;
        
        self.todayViewWidth.constant = 100;
        self.todayViewHeight.constant = 100;
    } else {
        self.yesterdayViewWidth.constant = 70;
        self.yesterdayViewHeight.constant = 70;
        
        self.todayViewWidth.constant = 70;
        self.todayViewHeight.constant = 70;
    }
    self.yesterdayView.layer.cornerRadius = self.yesterdayViewWidth.constant/2;
    self.yesterdayView.layer.borderWidth = 1;
    self.yesterdayView.layer.borderColor =[UIColor whiteColor].CGColor;
    self.yesterdayView.clipsToBounds = true;
    
    self.todayView.layer.cornerRadius = self.todayViewWidth.constant/2;
    self.todayView.layer.borderWidth = 1;
    self.todayView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.todayView.clipsToBounds = true;
    
    [self samplePieChart];
}

-(void)samplePieChart
{
    if(IS_IPHONE_DEVICE) {
        pieChartView1 = [[PieChartView alloc] initWithFrame:CGRectMake(self.yesterdayView.frame.origin.x,self.yesterdayView.frame.origin.y,self.yesterdayView.frame.size.width,self.yesterdayView.frame.size.width)];
        pieChartView1.delegate = self;
        pieChartView1.datasource = self;
        [self.yesterdayMainView addSubview:pieChartView1];
        
        pieChartView2 = [[PieChartView alloc] initWithFrame:CGRectMake(self.todayView.frame.origin.x,self.todayView.frame.origin.y,self.todayView.frame.size.width,self.todayView.frame.size.width)];
        pieChartView2.delegate = self;
        pieChartView2.datasource = self;
        [self.todayMainView addSubview:pieChartView2];
        
    } else {
        pieChartView1 = [[PieChartView alloc] initWithFrame:CGRectMake(self.yesterdayView.frame.origin.x,self.yesterdayView.frame.origin.y,self.yesterdayView.frame.size.width,self.yesterdayView.frame.size.width)];
        pieChartView1.delegate = self;
        pieChartView1.datasource = self;
        [self.yesterdayMainView addSubview:pieChartView1];
        
        pieChartView2 = [[PieChartView alloc] initWithFrame:CGRectMake(self.todayView.frame.origin.x,self.todayView.frame.origin.y,self.todayView.frame.size.width,self.todayView.frame.size.width)];
        pieChartView2.delegate = self;
        pieChartView2.datasource = self;
        [self.todayMainView addSubview:pieChartView2];
    }
}
- (IBAction)AddtrainingBtnAction:(id)sender {
    
    objUpdate = [[TrainingLoadUpdateVC alloc] initWithNibName:@"TrainingLoadUpdateVC" bundle:nil];
    objUpdate.view.frame = CGRectMake(0,0, self.traingView.bounds.size.width, self.traingView.bounds.size.height);
     [self.traingView addSubview:objUpdate.view];
    
//        WellnessTrainingBowlingVC *objWell = [[WellnessTrainingBowlingVC alloc]init];
//        objWell.traingViewHeight.constant = objWell.traingViewHeight.constant+300;
}

#pragma mark -    PieChartViewDelegate
-(CGFloat)centerCircleRadius
{
    if(IS_IPHONE_DEVICE)
        {
        return 30;
        }
    else
        {
        return 30;
        }
    
    
}

#pragma mark - PieChartViewDataSource
-(int)numberOfSlicesInPieChartView:(PieChartView *)pieChartView
{
    NSUInteger  obj =  self.markers.count;
    return (int)obj;
}
-(UIColor *)pieChartView:(PieChartView *)pieChartView colorForSliceAtIndex:(NSUInteger)index
{
    UIColor * color;
    if(index==0)
        {
        color = [UIColor colorWithRed:(210/255.0f) green:(105/255.0f) blue:(30/255.0f) alpha:1.0f];
        }
    if(index==1)
        {
        color = [UIColor colorWithRed:(0/255.0f) green:(100/255.0f) blue:(0/255.0f) alpha:1.0f];
        }
    if(index==2)
        {
        color = [UIColor colorWithRed:(0/255.0f) green:(139/255.0f) blue:(139/255.0f) alpha:1.0f];
        }
    if(index==3)
        {
        color = [UIColor colorWithRed:(165/255.0f) green:(42/255.0f) blue:(42/255.0f) alpha:1.0f];
        }
    return color;
        //return GetRandomUIColor();
}

-(double)pieChartView:(PieChartView *)pieChartView valueForSliceAtIndex:(NSUInteger)index
{
        //        NSUInteger  obj = [self.markers objectAtIndex:index];
        //        NSString *s= [self.markers objectAtIndex:index];
    float  obj = [[NSDecimalNumber decimalNumberWithString:[self.markers objectAtIndex:index]]floatValue] ;
    
    
    if(obj==0)
        {
        return 0;
        }
    else
        {
        
        if(index ==0)
            {
            return 100/obj;
            }
        if(index ==1)
            {
            return 100/obj;
            }
        if(index ==2)
            {
            return 100/obj;
            }
        if(index ==3)
            {
            return 100/obj;
            }
        }
    
    return 0;
}

-(NSString *)percentagevalue
{
    float a = num1;
    float b = num2;
    float c = num3;
    float d = num4;
    
    float Total = a+b+c+d;
    
    float per = (Total *100/28);
    
    NSString * obj;
    if(per == 0)
        {
        obj = @"";
        }
    else
        {
        
        obj =[NSString stringWithFormat:@"%f",per];
        
        }
    
    return obj;
}



@end
