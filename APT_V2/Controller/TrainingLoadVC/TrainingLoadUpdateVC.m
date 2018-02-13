//
//  TrainingLoadUpdateVC.m
//  APT_V2
//
//  Created by MAC on 05/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "TrainingLoadUpdateVC.h"
#import "TrainingLoadUpdateCell.h"
#import "Config.h"
#import "XYPieChart.h"
#import "PieChartView.h"

@interface TrainingLoadUpdateVC ()<PieChartViewDelegate,PieChartViewDataSource>
{
    float num1;
    float num2;
    float num3;
    float num4;
    
    PieChartView *pieChartView;
}

@end

@implementation TrainingLoadUpdateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.markers = [[NSMutableArray alloc] initWithObjects:@"50.343", @"84.43", @"63.22", @"31.43", nil];
    
    sessionArray = [[NSMutableArray alloc] initWithObjects:@"Session 1", @"Session 2", @"Session 3", nil];
    activityArray = [[NSMutableArray alloc] initWithObjects:@"Cardio", @"Strengthening", @"Bowling", nil];
    valueArray = [[NSMutableArray alloc] initWithObjects:@"245", @"124", @"342", nil];
     self.popViewtable.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (IS_IPAD) {
        self.countViewWidth.constant = 100;
        self.countViewHeight.constant = 100;
    } else {
        self.countViewWidth.constant = 70;
        self.countViewHeight.constant = 70;
    }
    self.countview.layer.cornerRadius = self.countViewWidth.constant/2;
    self.countview.layer.borderWidth = 1;
    self.countview.layer.borderColor =[UIColor whiteColor].CGColor;
    self.countview.clipsToBounds = true;

    [self samplePieChart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ActivityAction:(id)sender {
    
    self.popViewtable.hidden = NO;
}

-(void)samplePieChart
{
    if(IS_IPHONE_DEVICE) {
        
        pieChartView = [[PieChartView alloc] initWithFrame:CGRectMake(self.countview.frame.origin.x,self.countview.frame.origin.y,self.countview.frame.size.width,self.countview.frame.size.width)];
        pieChartView.delegate = self;
        pieChartView.datasource = self;
        [self.todayMainView addSubview:pieChartView];
        
    } else {
        
        pieChartView = [[PieChartView alloc] initWithFrame:CGRectMake(self.countview.frame.origin.x,self.countview.frame.origin.y,self.countview.frame.size.width,self.countview.frame.size.width)];
        pieChartView.delegate = self;
        pieChartView.datasource = self;
        [self.todayMainView addSubview:pieChartView];
    }
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
    
    return sessionArray.count;
}
    // the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"updateCell";
    
    TrainingLoadUpdateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"TrainingLoadUpdateCell" owner:self options:nil];
    cell = arr[0];
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.sessionLbl.text = sessionArray[indexPath.row];
    cell.activityTypeLbl.text = activityArray[indexPath.row];
    cell.sessionValueLbl.text = valueArray[indexPath.row];
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
    // when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
