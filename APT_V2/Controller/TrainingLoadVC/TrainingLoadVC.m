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
#import "AppCommon.h"
#import "WebService.h"


@interface TrainingLoadVC ()<PieChartViewDelegate,PieChartViewDataSource>
{
    WebService *objWebservice;
    TrainingLoadUpdateVC *objUpdate;
    float num1;
    float num2;
    float num3;
    float num4;
    
     PieChartView *pieChartView1, *pieChartView2;
}

@property (strong, nonatomic) IBOutlet NSMutableArray *metaSubcodeArray;
@property (strong, nonatomic) IBOutlet NSMutableArray *todaysLoadArray;
@property (strong, nonatomic) IBOutlet NSMutableArray *yesterdayLoadArray;

@end

@implementation TrainingLoadVC

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    
   // self.markers = [[NSMutableArray alloc] initWithObjects:@"50.343", @"84.43", @"63.22", @"31.43", nil];
    objWebservice=[[WebService alloc]init];

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
    
    [self FetchWebservice];
    
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


-(void)FetchWebservice
{
    [AppCommon showLoading ];
    
    NSString *playerCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *matchdate = [NSDate date];
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString * actualDate = [dateFormat stringFromDate:matchdate];
    
    NSDateComponents *components = [[NSDateComponents alloc] init] ;
    [components setDay:-1];
    NSDate *yesterday = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:[NSDate date] options:0];
    
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
    [dateFormat1 setDateFormat:@"dd/MM/yyyy"];
    NSString * yesterdayDate = [dateFormat1 stringFromDate:yesterday];
   
    
    [objWebservice fetchTrainingLoad :fetchTrainingLoadKey : playerCode  success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        if(responseObject >0)
        {
            NSMutableArray *reqArray = [[NSMutableArray alloc]init];
            reqArray = responseObject;
            
            for(int i=0;i<reqArray.count;i++)
            {
                if([[[responseObject valueForKey:@"WORKLOADDATE"] objectAtIndex:i] isEqualToString:actualDate] )
                {
                
                    self.todaysLoadArray = [[NSMutableArray alloc]init];
                    [self.todaysLoadArray addObject:[responseObject  objectAtIndex:i]];
                }
                
                if([[[responseObject valueForKey:@"WORKLOADDATE"] objectAtIndex:i] isEqualToString:yesterdayDate] )
                {
                    
                    self.yesterdayLoadArray = [[NSMutableArray alloc]init];
                    [self.yesterdayLoadArray addObject:[responseObject objectAtIndex:i]];
                }
                
            }
            
            self.markers = [[NSMutableArray alloc]init];
            
             for(int i=0;i<self.todaysLoadArray.count;i++)
             {
                 //today view
                 NSString *ActivityName;
                 NSString *ActivityNameCode = [[self.todaysLoadArray valueForKey:@"ACTIVITYTYPECODE"] objectAtIndex:i];
                 if([ActivityNameCode isEqualToString:@"MSC053"])
                 {
                     ActivityName = @"Match";
                 }
                 else if([ActivityNameCode isEqualToString:@"MSC054"])
                 {
                     ActivityName = @"Strengthening";
                 }
                 else if([ActivityNameCode isEqualToString:@"MSC055"])
                 {
                     ActivityName = @"Conditioning";
                 }
                 else if([ActivityNameCode isEqualToString:@"MSC056"])
                 {
                     ActivityName = @"Cardio";
                 }
                 else if([ActivityNameCode isEqualToString:@"MSC057"])
                 {
                     ActivityName = @"Net Session";
                 }
                 else if([ActivityNameCode isEqualToString:@"MSC058"])
                 {
                     ActivityName = @"Recovery";
                 }
                 else if([ActivityNameCode isEqualToString:@"MSC059"])
                 {
                     ActivityName = @"Bowling";
                 }
                 
                 if(i==0)
                 {
                     self.todayActivitynamelbl1.text = ActivityName;
                 }
                 if(i==1)
                 {
                     self.todayActivitynamelbl2.text = ActivityName;
                 }
                 if(i==2)
                 {
                     self.todayActivitynamelbl3.text = ActivityName;
                 }
                 if(i==3)
                 {
                    self.todayActivitynamelbl4.text = ActivityName;
                 }
                 if(i==4)
                 {
                     self.todayActivitynamelbl5.text = ActivityName;
                 }
                 if(i==5)
                 {
                     self.todayActivitynamelbl6.text = ActivityName;
                 }
                 if(i==6)
                 {
                     self.todayActivitynamelbl7.text = ActivityName;
                 }
                 
                 
                 int RpeCount = 0;
                 NSString *RpeCode = [[self.todaysLoadArray valueForKey:@"RATEPERCEIVEDEXERTION"] objectAtIndex:i];
                 if([RpeCode isEqualToString:@"MSC060"])
                 {
                     RpeCount = 0;
                 }
                 else if([RpeCode isEqualToString:@"MSC061"])
                 {
                     RpeCount = 0.5;
                 }
                 else if([RpeCode isEqualToString:@"MSC062"])
                 {
                     RpeCount = 1;
                 }
                 else if([RpeCode isEqualToString:@"MSC063"])
                 {
                     RpeCount = 2;
                 }
                 else if([RpeCode isEqualToString:@"MSC064"])
                 {
                     RpeCount = 3;
                 }
                 else if([RpeCode isEqualToString:@"MSC065"])
                 {
                     RpeCount = 4;
                 }
                 else if([RpeCode isEqualToString:@"MSC066"])
                 {
                     RpeCount = 5;
                 }
                 else if([RpeCode isEqualToString:@"MSC067"])
                 {
                     RpeCount = 6;
                 }
                 else if([RpeCode isEqualToString:@"MSC068"])
                 {
                     RpeCount = 7;
                 }
                 else if([RpeCode isEqualToString:@"MSC069"])
                 {
                     RpeCount = 8;
                 }
                 else if([RpeCode isEqualToString:@"MSC070"])
                 {
                     RpeCount = 9;
                 }
                 else if([RpeCode isEqualToString:@"MSC071"])
                 {
                     RpeCount = 10;
                 }
                 
                 NSString *timeDuration = [[self.todaysLoadArray valueForKey:@"DURATION"] objectAtIndex:i];
                 int timecount = [timeDuration intValue];
                 
                 int totalCout = RpeCount * timecount;
                 [self.markers addObject:[NSString stringWithFormat:@"%d",totalCout]];
                 
             }
            [self samplePieChart];
            [pieChartView2 reloadData];
            
            self.markers = [[NSMutableArray alloc]init];
            
            for(int i=0;i<self.yesterdayLoadArray.count;i++)
            {
                //today view
                NSString *ActivityName;
                NSString *ActivityNameCode = [[self.yesterdayLoadArray valueForKey:@"ACTIVITYTYPECODE"] objectAtIndex:i];
                if([ActivityNameCode isEqualToString:@"MSC053"])
                {
                    ActivityName = @"Match";
                }
                else if([ActivityNameCode isEqualToString:@"MSC054"])
                {
                    ActivityName = @"Strengthening";
                }
                else if([ActivityNameCode isEqualToString:@"MSC055"])
                {
                    ActivityName = @"Conditioning";
                }
                else if([ActivityNameCode isEqualToString:@"MSC056"])
                {
                    ActivityName = @"Cardio";
                }
                else if([ActivityNameCode isEqualToString:@"MSC057"])
                {
                    ActivityName = @"Net Session";
                }
                else if([ActivityNameCode isEqualToString:@"MSC058"])
                {
                    ActivityName = @"Recovery";
                }
                else if([ActivityNameCode isEqualToString:@"MSC059"])
                {
                    ActivityName = @"Bowling";
                }
                
                if(i==0)
                {
                    self.yesterdayActivitynamelbl1.text = ActivityName;
                }
                if(i==1)
                {
                    self.yesterdayActivitynamelbl2.text = ActivityName;
                }
                if(i==2)
                {
                    self.yesterdayActivitynamelbl3.text = ActivityName;
                }
                if(i==3)
                {
                    self.yesterdayActivitynamelbl4.text = ActivityName;
                }
                if(i==4)
                {
                    self.yesterdayActivitynamelbl5.text = ActivityName;
                }
                if(i==5)
                {
                    self.yesterdayActivitynamelbl6.text = ActivityName;
                }
                if(i==6)
                {
                    self.yesterdayActivitynamelbl7.text = ActivityName;
                }
                
                
                int RpeCount = 0;
                NSString *RpeCode = [[self.yesterdayLoadArray valueForKey:@"RATEPERCEIVEDEXERTION"] objectAtIndex:i];
                if([RpeCode isEqualToString:@"MSC060"])
                {
                    RpeCount = 0;
                }
                else if([RpeCode isEqualToString:@"MSC061"])
                {
                    RpeCount = 0.5;
                }
                else if([RpeCode isEqualToString:@"MSC062"])
                {
                    RpeCount = 1;
                }
                else if([RpeCode isEqualToString:@"MSC063"])
                {
                    RpeCount = 2;
                }
                else if([RpeCode isEqualToString:@"MSC064"])
                {
                    RpeCount = 3;
                }
                else if([RpeCode isEqualToString:@"MSC065"])
                {
                    RpeCount = 4;
                }
                else if([RpeCode isEqualToString:@"MSC066"])
                {
                    RpeCount = 5;
                }
                else if([RpeCode isEqualToString:@"MSC067"])
                {
                    RpeCount = 6;
                }
                else if([RpeCode isEqualToString:@"MSC068"])
                {
                    RpeCount = 7;
                }
                else if([RpeCode isEqualToString:@"MSC069"])
                {
                    RpeCount = 8;
                }
                else if([RpeCode isEqualToString:@"MSC070"])
                {
                    RpeCount = 9;
                }
                else if([RpeCode isEqualToString:@"MSC071"])
                {
                    RpeCount = 10;
                }
                
                NSString *timeDuration = [[self.yesterdayLoadArray valueForKey:@"DURATION"] objectAtIndex:i];
                int timecount = [timeDuration intValue];
                
                int totalCout = RpeCount * timecount;
                [self.markers addObject:[NSString stringWithFormat:@"%d",totalCout]];
                
            }
            
            [pieChartView1 reloadData];
            
            
            
            
        }
        [AppCommon hideLoading];
        
    }
    failure:^(AFHTTPRequestOperation *operation, id error) {
    NSLog(@"failed");
    [COMMON webServiceFailureError:error];
    }];
    
}






@end
