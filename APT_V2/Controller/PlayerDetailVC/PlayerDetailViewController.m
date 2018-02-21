//
//  PlayerDetailViewController.m
//  APT_V2
//
//  Created by user on 21/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "PlayerDetailViewController.h"
#import "Header.h"

@interface PlayerDetailViewController () <ChartViewDelegate, IChartAxisValueFormatter>
{
    NSMutableArray* TableArray;
    NSArray<NSString *> *activities;
    UIColor *originalBarBgColor;
    UIColor *originalBarTintColor;
    UIBarStyle originalBarStyle;

}

@end

@implementation PlayerDetailViewController
@synthesize scrollView,contentView;

@synthesize spiderChartView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    scrollView.contentSize = contentView.frame.size;
    [scrollView addSubview:contentView];
    [contentView.topAnchor constraintEqualToAnchor:scrollView.topAnchor];
    [contentView.leadingAnchor constraintEqualToAnchor:scrollView.leadingAnchor];
    [contentView.trailingAnchor constraintEqualToAnchor:scrollView.trailingAnchor];
    [contentView.bottomAnchor constraintEqualToAnchor:scrollView.bottomAnchor];
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self customnavigationmethod];

    [self.txtTestDate setup];
    
    [self playerDetailWebservice];
    
    activities = @[ @"Burger", @"Steak", @"Salad", @"Pasta", @"Pizza" ];
    [self chatConfiguration];

}

-(void)viewWillAppear:(BOOL)animated
{
    self.lblAvailability.backgroundColor = self.availableColor;
    self.lblTeamName.text = [self TeamName];
    self.lblPlayerAge.text = [self PlayerAge];
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController.panGestureRecognizer setEnabled:NO];
    [revealController.tapGestureRecognizer setEnabled:NO];
}

-(void)chatConfiguration
{
    spiderChartView.delegate = self;
    
    spiderChartView.chartDescription.enabled = NO;
    spiderChartView.webLineWidth = 1.0;
    spiderChartView.innerWebLineWidth = 1.0;
    spiderChartView.webColor = UIColor.lightGrayColor;
    spiderChartView.innerWebColor = UIColor.lightGrayColor;
    spiderChartView.webAlpha = 1.0;
    
//    RadarMarkerView *marker = (RadarMarkerView *)[RadarMarkerView viewFromXib];
//    marker.chartView = _chartView;
//    spiderChartView.marker = marker;
    
    ChartXAxis *xAxis = spiderChartView.xAxis;
    xAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:9.f];
    xAxis.xOffset = 0.0;
    xAxis.yOffset = 0.0;
    xAxis.valueFormatter = self;
    xAxis.labelTextColor = UIColor.whiteColor;
    
    ChartYAxis *yAxis = spiderChartView.yAxis;
    yAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:9.f];
    yAxis.labelCount = 5;
    yAxis.axisMinimum = 0.0;
    yAxis.axisMaximum = 80.0;
    yAxis.drawLabelsEnabled = NO;
    
    ChartLegend *l = spiderChartView.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentCenter;
    l.verticalAlignment = ChartLegendVerticalAlignmentTop;
    l.orientation = ChartLegendOrientationHorizontal;
    l.drawInside = NO;
    l.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
    l.xEntrySpace = 7.0;
    l.yEntrySpace = 5.0;
    l.textColor = UIColor.whiteColor;
    
    [self updateChartData];
    
    [spiderChartView animateWithXAxisDuration:1.4 yAxisDuration:1.4 easingOption:ChartEasingOptionEaseOutBack];

}
#pragma mark - IAxisValueFormatter

- (NSString *)stringForValue:(double)value
                        axis:(ChartAxisBase *)axis
{
    return activities[(int) value % activities.count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateChartData
{
//    if (self.shouldHideData)
//    {
//        spiderChartView.data = nil;
//        return;
//    }
    
    [self setChartData];
}

- (void)setChartData
{
    double mult = 80;
    double min = 20;
    int cnt = 5;
    
    NSMutableArray *entries1 = [[NSMutableArray alloc] init];
    NSMutableArray *entries2 = [[NSMutableArray alloc] init];
    
    // NOTE: The order of the entries when being added to the entries array determines their position around the center of the chart.
    for (int i = 0; i < cnt; i++)
    {
        [entries1 addObject:[[RadarChartDataEntry alloc] initWithValue:(arc4random_uniform(mult) + min)]];
        [entries2 addObject:[[RadarChartDataEntry alloc] initWithValue:(arc4random_uniform(mult) + min)]];
    }
    
    RadarChartDataSet *set1 = [[RadarChartDataSet alloc] initWithValues:entries1 label:@"Last Week"];
    [set1 setColor:[UIColor colorWithRed:103/255.0 green:110/255.0 blue:129/255.0 alpha:1.0]];
    set1.fillColor = [UIColor colorWithRed:103/255.0 green:110/255.0 blue:129/255.0 alpha:1.0];
    set1.drawFilledEnabled = YES;
    set1.fillAlpha = 0.7;
    set1.lineWidth = 2.0;
    set1.drawHighlightCircleEnabled = YES;
    [set1 setDrawHighlightIndicators:NO];
    
    RadarChartDataSet *set2 = [[RadarChartDataSet alloc] initWithValues:entries2 label:@"This Week"];
    [set2 setColor:[UIColor colorWithRed:121/255.0 green:162/255.0 blue:175/255.0 alpha:1.0]];
    set2.fillColor = [UIColor colorWithRed:121/255.0 green:162/255.0 blue:175/255.0 alpha:1.0];
    set2.drawFilledEnabled = YES;
    set2.fillAlpha = 0.7;
    set2.lineWidth = 2.0;
    set2.drawHighlightCircleEnabled = YES;
    [set2 setDrawHighlightIndicators:NO];
    
    RadarChartData *data = [[RadarChartData alloc] initWithDataSets:@[set1, set2]];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:8.f]];
    [data setDrawValues:NO];
    data.valueTextColor = UIColor.whiteColor;
    
    spiderChartView.data = data;
}

-(void)customnavigationmethod
{
    CustomNavigation *objCustomNavigation=[CustomNavigation new];
    [self.navBarView addSubview:objCustomNavigation.view];
//    objCustomNavigation.tittle_lbl.text=@"";
    objCustomNavigation.btn_back.hidden =NO;
    objCustomNavigation.menu_btn.hidden =YES;
    [objCustomNavigation.btn_back addTarget:self action:@selector(actionBack) forControlEvents:UIControlEventTouchUpInside];
}

-(IBAction)actionBack
{
    [appDel.frontNavigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableView Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return (IS_IPAD ? 45 : 40);
    
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    PlayerDetailTableViewCell* cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"PlayerDetailTableViewCell" owner:self options:nil];
    if (!tableView.tag) {
        cell = array[0];
    }
    else
    {
        cell = array[2];
    }
    
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger* cellCount = 0;
    if (!tableView.tag) {
        cellCount = [[TableArray valueForKey:@"homeRecentForm"] count];
    }
    else
    {
        cellCount = [[TableArray valueForKey:@"homeHistory"] count];
    }
    
    return  cellCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (IS_IPAD ? 35 : 30);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayerDetailTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Content"];
    NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"PlayerDetailTableViewCell" owner:self options:nil];
    if (!tableView.tag) {
        cell = array[1];
        cell.lblTournamentName.text = [[[TableArray valueForKey:@"homeRecentForm"] objectAtIndex:indexPath.row] valueForKey:@"competitionName"];
        cell.lblFormat.text = [[[TableArray valueForKey:@"homeRecentForm"] objectAtIndex:indexPath.row] valueForKey:@"format"];
        cell.lblMat.text = [[[TableArray valueForKey:@"homeRecentForm"] objectAtIndex:indexPath.row] valueForKey:@"matches"];
        cell.lblBat.text = [[[TableArray valueForKey:@"homeRecentForm"] objectAtIndex:indexPath.row] valueForKey:@"bats"];
        cell.lblBowl.text = [[[TableArray valueForKey:@"homeRecentForm"] objectAtIndex:indexPath.row] valueForKey:@"bowls"];
        cell.lblCat.text = [[[TableArray valueForKey:@"homeRecentForm"] objectAtIndex:indexPath.row] valueForKey:@"catches"];
        cell.lblStump.text = [[[TableArray valueForKey:@"homeRecentForm"] objectAtIndex:indexPath.row] valueForKey:@"stumpings"];

        
    }
    else
    {
        cell = array[3];
        cell.lblModuleName.text = [[[TableArray valueForKey:@"homeHistory"] objectAtIndex:indexPath.row] valueForKey:@"ModuleName"];
        cell.lblAssessmentName.text = [[[TableArray valueForKey:@"homeHistory"] objectAtIndex:indexPath.row] valueForKey:@"AssessmentName"];
        cell.lblDate.text = [[[TableArray valueForKey:@"homeHistory"] objectAtIndex:indexPath.row] valueForKey:@"AssessmentDate"];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)playerDetailWebservice
{
    
    /*
     API URL        :
     API NAME       : MOBILE_RECENTDETAILS
     METHOD         : POST
     INPUT FORMAT   : JSON
     INPUT PARAMS   :
                     {
                     "ClientCode":"CLI0000001",
                     "UserrefCode":"AMR0000016",
                     "PlayerCode": "PYC0000002"
                     }
     */
    
    
    if(![COMMON isInternetReachable])
        return;
        
        [AppCommon showLoading];
    
        NSString *URLString =  URL_FOR_RESOURCE(playerDetailsKey);
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
        manager.requestSerializer = requestSerializer;
    
        NSString *ClientCode = [AppCommon GetClientCode];
        NSString *UserrefCode = [AppCommon GetuserReference];
        NSString *PlayerCode = [self PlayerCode];
    
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(ClientCode)   [dic    setObject:ClientCode     forKey:@"ClientCode"];
        if(UserrefCode)   [dic    setObject:UserrefCode     forKey:@"UserrefCode"];
        if(PlayerCode)   [dic    setObject:PlayerCode     forKey:@"PlayerCode"];
    
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                TableArray = [NSMutableArray new];
                TableArray = responseObject;
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
//                NSInteger* tbl1MaxCount = [[TableArray valueForKeyPath:@"homeRecentForm"] count];
//                CGFloat height1;
//                if (tbl1MaxCount > 3) {
//                    height1 = (IS_IPAD ? 45 : 40) + ((IS_IPAD ? 35 : 30) * 3);
//                }
//                else {
//                    height1 = (IS_IPAD ? 45 : 40) + ((IS_IPAD ? 35 : 30) * 1);
//                }
//
//                NSInteger* tbl2MaxCount = [[TableArray valueForKeyPath:@"homeHistory"] count];
//                CGFloat height2;
//                if (tbl2MaxCount > 3) {
//                    height2 = (IS_IPAD ? 45 : 40) + ((IS_IPAD ? 35 : 30) * 3);
//                }
//                else{
//                    height2 = (IS_IPAD ? 45 : 40) + ((IS_IPAD ? 35 : 30) * 1);
//                }
//                self.tbl1Height.constant = height1;
//                self.tbl2Height.constant = height2;
//                [self.tblRecentPerformance updateFocusIfNeeded];
//                [self.tblHistory updateFocusIfNeeded];
                
                [_tblHistory reloadData];
                [_tblRecentPerformance reloadData];
            });
            
            [AppCommon hideLoading];

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed");
            [AppCommon hideLoading];
            [COMMON webServiceFailureError:error];
            
        }];
}


@end
