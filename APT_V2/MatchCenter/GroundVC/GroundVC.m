//
//  GroundVC.m
//  APT_V2
//
//  Created by Apple on 27/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "GroundVC.h"

#import "MCOverViewResultCVC.h"
#import "CustomNavigation.h"
#import "SWRevealViewController.h"
#import "BowlTypeCell.h"
//#import "IntAxisValueFormatter.h"
#import "HorizontalXLblFormatter.h"
@import drCharts;


#define ITEM_COUNT 12
#define header_height 65

@interface GroundVC ()<PieChartViewDataSource,PieChartViewDelegate,ChartViewDelegate,BarChartDelegate,BarChartDataSource>
{
    NSArray* headingKeyArray;
    NSArray* headingButtonNames;
    
    //Donar Charts
    NSMutableArray *markers;
    float num1;
    float num2;
    float num3;
    float num4;
    
     NSArray<NSString *> *months;
    
}
@property (strong, nonatomic) IBOutlet PieChartView *battingFstPie;
@property (strong, nonatomic) IBOutlet PieChartView *battingSecPie;



@property (nonatomic, strong) IBOutlet BarChartView *chartView;
@property (nonatomic, strong) IBOutlet UISlider *sliderX;
@property (nonatomic, strong) IBOutlet UISlider *sliderY;
@property (nonatomic, strong) IBOutlet UITextField *sliderTextX;
@property (nonatomic, strong) IBOutlet UITextField *sliderTextY;

@property (strong, nonatomic) IBOutlet BarChart *barChartMultipleView;

@end

@implementation GroundVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    
    
    
    
    
    markers = [[NSMutableArray alloc] initWithObjects:@"50.343", @"84.43", nil];
    
    self.battingFstPie.delegate = self;
    self.battingFstPie.datasource = self;
    
    
    self.battingSecPie.delegate = self;
    self.battingSecPie.datasource = self;
    
    [self.resultCollectionView registerNib:[UINib nibWithNibName:@"MCOverViewResultCVC" bundle:nil] forCellWithReuseIdentifier:@"mcResultCVC"];
    
    // [_scrollView contentSize ]
    // _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, 3000);
    
    _scrollView.contentSize = _contentView.frame.size;
    
   // [self barchartMultiple];
    [self createBarChart];
}
-(void)viewWillAppear:(BOOL)animated
{
    UIBezierPath *path = [UIBezierPath new];
    
    [path moveToPoint:(CGPoint){self.ColorView.frame.size.width-25,0 }];//w0
    [path addLineToPoint:(CGPoint){0, 0}];//00
    [path addLineToPoint:(CGPoint){0,self.ColorView.frame.size.height }];//0h
    [path addLineToPoint:(CGPoint){self.ColorView.frame.size.width, self.ColorView.frame.size.height}];//wh20
    
    CAShapeLayer *mask = [CAShapeLayer new];
    mask.frame = self.ColorView.bounds;
    mask.path = path.CGPath;
    self.ColorView.layer.mask = mask;
}

-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.headerView addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"Ground";
    objCustomNavigation.btn_back.hidden = YES;
    objCustomNavigation.home_btn.hidden = YES;
    objCustomNavigation.menu_btn.hidden =NO;
    
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    
    [objCustomNavigation.menu_btn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if(collectionView == _resultCollectionView){
        return 3;
    }else{
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if(collectionView == self.resultCollectionView){
        
        
        
        MCOverViewResultCVC* cell = [self.resultCollectionView dequeueReusableCellWithReuseIdentifier:@"mcResultCVC" forIndexPath:indexPath];
        
        
        
        return cell;
        
    }
    return nil;
    
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
    NSUInteger  obj =  markers.count;
    return (int)obj;
}
-(UIColor *)pieChartView:(PieChartView *)pieChartView colorForSliceAtIndex:(NSUInteger)index
{
    UIColor * color;
    if(index==0)
    {
        color = [UIColor colorWithRed:(0/255.0f) green:(178/255.0f) blue:(235/255.0f) alpha:1.0f];
    }
    if(index==1)
    {
        color = [UIColor colorWithRed:(204/255.0f) green:(204/255.0f) blue:(204/255.0f) alpha:1.0f];
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
    float  obj = [[NSDecimalNumber decimalNumberWithString:[markers objectAtIndex:index]]floatValue] ;
    
    
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



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *MyIdentifier = @"MyIdentifier";
    BowlTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"BowlTypeCell" owner:self options:nil];
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefaultreuseIdentifier:MyIdentifier];
         cell = self.objCell;
    }
    //cell.textLabel.text = @"Text";
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(void)barchartMultiple
{
    self.title = @"Multiple Bar Chart";
    
//    self.options = @[
//                     @{@"key": @"toggleValues", @"label": @"Toggle Values"},
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
    
    _chartView.pinchZoomEnabled = NO;
    _chartView.drawBarShadowEnabled = NO;
    _chartView.drawGridBackgroundEnabled = NO;
    
    //    BalloonMarker *marker = [[BalloonMarker alloc]
    //                             initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
    //                             font: [UIFont systemFontOfSize:12.0]
    //                             textColor: UIColor.whiteColor
    //                             insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
    //    marker.chartView = _chartView;
    //    marker.minimumSize = CGSizeMake(80.f, 40.f);
    //    _chartView.marker = marker;
    
    ChartLegend *legend = _chartView.legend;
    legend.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
    legend.verticalAlignment = ChartLegendVerticalAlignmentTop;
    legend.orientation = ChartLegendOrientationVertical;
    legend.drawInside = YES;
    legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:8.f];
    legend.yOffset = 10.0;
    legend.xOffset = 10.0;
    legend.yEntrySpace = 0.0;
    
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
    xAxis.granularity = 1.f;
    xAxis.centerAxisLabelsEnabled = YES;
    //xAxis.valueFormatter = [[IntAxisValueFormatter alloc] init];
    
    NSNumberFormatter *leftAxisFormatter = [[NSNumberFormatter alloc] init];
    leftAxisFormatter.maximumFractionDigits = 1;
    
    ChartYAxis *leftAxis = _chartView.leftAxis;
    leftAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
    //leftAxis.valueFormatter = [[HorizontalXLblFormatter alloc] init];
    leftAxis.drawGridLinesEnabled = NO;
    leftAxis.spaceTop = 0.35;
    leftAxis.axisMinimum = 0;
    
    _chartView.rightAxis.enabled = NO;
    
    _sliderX.value = 10.0;
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
    
    [self setDataCount:_sliderX.value range:_sliderY.value];
}

- (void)setDataCount:(int)count range:(double)range
{
    float groupSpace = 0.08f;
    float barSpace = 0.03f;
    float barWidth = 0.2f;
    // (0.2 + 0.03) * 4 + 0.08 = 1.00 -> interval per "group"
    
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals3 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals4 = [[NSMutableArray alloc] init];
    
    double randomMultiplier = range * 100000.f;
    
    int groupCount = count + 1;
    int startYear = 1980;
    int endYear = startYear + groupCount;
    
    for (int i = startYear; i < endYear; i++)
    {
        [yVals1 addObject:[[BarChartDataEntry alloc]
                           initWithX:i
                           y:(double) (arc4random_uniform(randomMultiplier))]];
        
        [yVals2 addObject:[[BarChartDataEntry alloc]
                           initWithX:i
                           y:(double) (arc4random_uniform(randomMultiplier))]];
        
        [yVals3 addObject:[[BarChartDataEntry alloc]
                           initWithX:i
                           y:(double) (arc4random_uniform(randomMultiplier))]];
        
        [yVals4 addObject:[[BarChartDataEntry alloc]
                           initWithX:i
                           y:(double) (arc4random_uniform(randomMultiplier))]];
    }
    
    BarChartDataSet *set1 = nil, *set2 = nil, *set3 = nil, *set4 = nil;
    if (_chartView.data.dataSetCount > 0)
    {
        set1 = (BarChartDataSet *)_chartView.data.dataSets[0];
        set2 = (BarChartDataSet *)_chartView.data.dataSets[1];
        set3 = (BarChartDataSet *)_chartView.data.dataSets[2];
        set4 = (BarChartDataSet *)_chartView.data.dataSets[3];
        set1.values = yVals1;
        set2.values = yVals2;
        set3.values = yVals3;
        set4.values = yVals4;
        
        BarChartData *data = _chartView.barData;
        
        _chartView.xAxis.axisMinimum = startYear;
        _chartView.xAxis.axisMaximum = [data groupWidthWithGroupSpace:groupSpace barSpace: barSpace] * _sliderX.value + startYear;
        [data groupBarsFromX: startYear groupSpace: groupSpace barSpace: barSpace];
        
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[BarChartDataSet alloc] initWithValues:yVals1 label:@"Company A"];
        [set1 setColor:[UIColor colorWithRed:104/255.f green:241/255.f blue:175/255.f alpha:1.f]];
        
        set2 = [[BarChartDataSet alloc] initWithValues:yVals2 label:@"Company B"];
        [set2 setColor:[UIColor colorWithRed:164/255.f green:228/255.f blue:251/255.f alpha:1.f]];
        
        set3 = [[BarChartDataSet alloc] initWithValues:yVals3 label:@"Company C"];
        [set3 setColor:[UIColor colorWithRed:242/255.f green:247/255.f blue:158/255.f alpha:1.f]];
        
        set4 = [[BarChartDataSet alloc] initWithValues:yVals4 label:@"Company D"];
        [set4 setColor:[UIColor colorWithRed:255/255.f green:102/255.f blue:0/255.f alpha:1.f]];
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        [dataSets addObject:set2];
        [dataSets addObject:set3];
        [dataSets addObject:set4];
        
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
       // [data setValueFormatter:[[HorizontalXLblFormatter alloc] init]];
        
        // specify the width each bar should have
        data.barWidth = barWidth;
        
        // restrict the x-axis range
        _chartView.xAxis.axisMinimum = startYear;
        
        // groupWidthWithGroupSpace(...) is a helper that calculates the width each group needs based on the provided parameters
        _chartView.xAxis.axisMaximum = startYear + [data groupWidthWithGroupSpace:groupSpace barSpace: barSpace] * groupCount;
        
        [data groupBarsFromX: startYear groupSpace: groupSpace barSpace: barSpace];
        
        _chartView.data = data;
    }
}



#pragma mark - Actions

- (IBAction)slidersValueChanged:(id)sender
{
    int startYear = 1980;
    int endYear = startYear + _sliderX.value;
    
    _sliderTextX.text = [NSString stringWithFormat:@"%d-%d", startYear, endYear];
    _sliderTextY.text = [@((int)_sliderY.value) stringValue];
    
    [self updateChartData];
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


- (void)createBarChart{
    _barChartMultipleView = [[BarChart alloc] initWithFrame:CGRectMake(0, 0, self.barchart.frame.size.width+self.barchart.frame.size.width, self.barchart.frame.size.height)];
    //_barChartMultipleView = [[BarChart alloc]init];
    [_barChartMultipleView setDataSource:self];
    [_barChartMultipleView setDelegate:self];
    [_barChartMultipleView setLegendViewType:LegendTypeHorizontal];
    [_barChartMultipleView setShowCustomMarkerView:TRUE];
    [_barChartMultipleView drawBarGraph];
    [_barChartMultipleView setLegendViewType:@"fff"];
    [self.barchart addSubview:_barChartMultipleView];
}
#pragma mark BarChartDataSource
- (NSMutableArray *)xDataForBarChart{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < 8; i++) {
        [array addObject:[NSString stringWithFormat:@"%d", 2000 + i]];
    }
    return  array;
}

- (NSInteger)numberOfBarsToBePlotted{
    return 2;
}

- (UIColor *)colorForTheBarWithBarNumber:(NSInteger)barNumber{
    NSInteger aRedValue = arc4random()%255;
    NSInteger aGreenValue = arc4random()%255;
    NSInteger aBlueValue = arc4random()%255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue/255.0f green:aGreenValue/255.0f blue:aBlueValue/255.0f alpha:1.0f];
    return randColor;
}

- (CGFloat)widthForTheBarWithBarNumber:(NSInteger)barNumber{
    return 40;
}

- (NSString *)nameForTheBarWithBarNumber:(NSInteger)barNumber{
    
    if(barNumber == 0)
    {
        return [NSString stringWithFormat:@"value1 %d",(int)barNumber];
    }
    else if(barNumber == 1)
    {
    return [NSString stringWithFormat:@"Value2 %d",(int)barNumber];
    }
    return nil;
}

- (NSMutableArray *)yDataForBarWithBarNumber:(NSInteger)barNumber{
    NSMutableArray *array;
    NSArray *arr = @[ @"20",@"30",@"40",@"20",@"20",@"30",@"40",@"20"];
    NSArray *arr1 = @[ @"10",@"20",@"30",@"40",@"10",@"20",@"30",@"40"];
    
    if(barNumber==0)
    {
        array = [[NSMutableArray alloc] init];
        for (int i = 0; i < arr.count; i++) {
            // [array addObject:[NSNumber numberWithLong:random() % 100]];
            [array addObject:[arr objectAtIndex:i]];
        }
    }
    if(barNumber==1)
    {
        array = [[NSMutableArray alloc] init];
        for (int i = 0; i < arr1.count; i++) {
            // [array addObject:[NSNumber numberWithLong:random() % 100]];
            [array addObject:[arr1 objectAtIndex:i]];
        }
    }
    return array;
}

- (UIView *)customViewForBarChartTouchWithValue:(NSNumber *)value{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor whiteColor]];
    [view.layer setCornerRadius:4.0F];
    [view.layer setBorderWidth:1.0F];
    [view.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [view.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [view.layer setShadowRadius:2.0F];
    [view.layer setShadowOpacity:0.3F];
    
    UILabel *label = [[UILabel alloc] init];
    [label setFont:[UIFont systemFontOfSize:12]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:[NSString stringWithFormat:@"%@", value]];
    [label setFrame:CGRectMake(0, 0, 100, 30)];
    [view addSubview:label];
    
    [view setFrame:label.frame];
    return view;
}

#pragma mark BarChartDelegate
- (void)didTapOnBarChartWithValue:(NSString *)value{
    NSLog(@"Bar Chart: %@",value);
}



@end
