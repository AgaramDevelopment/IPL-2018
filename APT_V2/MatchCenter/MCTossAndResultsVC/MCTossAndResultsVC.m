//
//  MCTossAndResultsVC.m
//  APT_V2
//
//  Created by apple on 07/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "MCTossAndResultsVC.h"
#import "CustomNavigation.h"
#import "PlayerListCollectionViewCell.h"
#import "Config.h"
#import "SWRevealViewController.h"
@import Charts;

@interface MCTossAndResultsVC () <PieChartViewDelegate,PieChartViewDataSource>
{
    NSArray* headingKeyArray;
    NSArray* headingButtonNames;

    //Donar Charts
     NSMutableArray *markers;
    float num1;
    float num2;
    float num3;
    float num4;
    NSInteger currntlySelectedToss;

}
@property (strong, nonatomic) IBOutlet PieChartView *battingFstPie;
@property (strong, nonatomic) IBOutlet PieChartView *battingSecPie;
@property (strong, nonatomic) NSMutableArray* mainArray;

@end

@implementation MCTossAndResultsVC
@synthesize btnToss;

@synthesize lblMatchWon1,lblMatchLost1;

@synthesize lblMatchWon2,lblMatchLost2;

@synthesize tossResultsSegment;

@synthesize lbl1stCenter,lbl2ndCenter;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSUserDefaults standardUserDefaults] setInteger: 13 forKey:@"requiredColumn"];
    [self customnavigationmethod];
//    markers = [[NSMutableArray alloc] initWithObjects:@"50.343", @"84.43", nil];
    _mainArray = [NSMutableArray new];
    
    
    /*
     "TeamCode": "TEA0000004",
     "Opponent": "RCB",
     "TossWon": "RCB",
     "ElectedTo": "Field",
     "Condition": "HOME",
     "Venue": "Kolkatta",
     "BatperScore": "154.151515",
     "BatFirstScore": 178,
     "BatFirstwicket": 6,
     "BatFirstTeam": "KKR",
     "BatsecondTeam": "RCB",
     "BatsecondScore": 179,
     "Batsecondwicket": 7,
     "WonTeam": "RCB",
     "Margin": "WON BY 3 WICKETS",
     "Points": 2,
     "Ground": null
     */
    
    headingKeyArray =  @[@"Opponent",@"TossWon",@"ElectedTo",@"Condition",@"Venue",@"BatperScore",@"BatFirstTeam",@"BatFirstScore",@"BatsecondTeam",@"BatsecondScore",@"WonTeam",@"Margin",@"Points"];
    
    headingButtonNames = @[@"Opponent",@"Toss Won",@"Elected To",@"Condition",@"Venue",@"Bat 1st Par\nScore",@"Bat 1st - Team",@"Bat 1st \nScore",@"Bat 2nd \nTeam",@"Bat 2nd \nScore",@"Won Team",@"Margin",@"Points"];
    
    

     [self.resultCollectionView registerNib:[UINib nibWithNibName:@"PlayerListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ContentCellIdentifier"];
    
    
  //  [self setupPieChartView:_battingFstPie];
    
    self.battingFstPie.delegate = self;
    self.battingFstPie.datasource = self;

    
    self.battingSecPie.delegate = self;
    self.battingSecPie.datasource = self;

    
    [btnToss.firstObject sendActionsForControlEvents:UIControlEventTouchUpInside];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear called");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.headderView addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"Toss & Results";
    objCustomNavigation.btn_back.hidden = YES;
    objCustomNavigation.home_btn.hidden = YES;
    objCustomNavigation.menu_btn.hidden =NO;
    
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];

    
    [objCustomNavigation.menu_btn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];

}



#pragma mark UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if ([[_mainArray valueForKey:@"MatchTossList"] count]) {
        return [[_mainArray valueForKey:@"MatchTossList"] count]+1;
    }
    
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return headingButtonNames.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(IS_IPHONE_DEVICE)
    {
        if(!IS_IPHONE5)
        {
            return CGSizeMake(130, 35);
        }
        else
        {
            
            return CGSizeMake(150, 40);
        }
    }
    else
    {
        
        return CGSizeMake(200, 50);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PlayerListCollectionViewCell* cell = [self.resultCollectionView dequeueReusableCellWithReuseIdentifier:@"ContentCellIdentifier" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
      
        cell.backgroundColor = [UIColor colorWithRed:44.0/255.0 green:167.0/255.0 blue:219.0/255.0 alpha:1.0];
        
        [cell.lblRightShadow setHidden:YES];
        cell.btnName.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        cell.btnName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        
        for (id value in headingButtonNames) {
            
            if ([headingButtonNames indexOfObject:value] == indexPath.row) {
                [cell.btnName setTitle:value forState:UIControlStateNormal];
                cell.btnName.secondTag = indexPath.row;
                cell.btnName.titleLabel.numberOfLines = 2;
                break;
            }
        }
        
        cell.btnName.userInteractionEnabled = YES;
        
    }
    else
    {
        [cell.lblRightShadow setHidden:(indexPath.row == 0 ? NO : YES)];
        if (!cell.lblRightShadow.isHidden) {
            cell.lblRightShadow.clipsToBounds = NO;
            [self setShadow:cell.lblRightShadow.layer];
        }
        
        if (indexPath.section % 2 != 0) {
            cell.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0];
            
        }else {
            cell.backgroundColor = [UIColor whiteColor];
        }
        
        [cell.btnName setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        
        cell.btnName.userInteractionEnabled = NO;
        
        
        for (id temp in headingKeyArray) {
    
            if ([headingKeyArray indexOfObject:temp] == indexPath.row) {
               // NSString* str = [AppCommon checkNull:[[PlayerListArray objectAtIndex:indexPath.section-1]valueForKey:temp]];
                if([temp isEqualToString:@"Opponent"])
                {
                    cell.btnName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                    cell.btnName.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                    //NSLog(@"Player Name %@ ",str);
                }
                else
                {
                    cell.btnName.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
                    cell.btnName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                }
                
                NSString* str = @"";
                
                if([[[[_mainArray valueForKey:@"MatchTossList"]objectAtIndex:indexPath.section-1] valueForKey:temp] isKindOfClass:[NSNumber class]])
                {
                    NSLog(@"INT");
                    NSNumber * val = [[[_mainArray valueForKey:@"MatchTossList"]objectAtIndex:indexPath.section-1] valueForKey:temp];
                    str = [val stringValue];
                    
                }
                else
                {
                    NSLog(@"STRING");
                    str = [[[_mainArray valueForKey:@"MatchTossList"]objectAtIndex:indexPath.section-1] valueForKey:temp];

                }
                
                
                NSLog(@"TEMP KEY %@ index %ld",temp,(long)indexPath.section-1);
                [cell.btnName setTitle:str forState:UIControlStateNormal];
                
                break;
            }
        }
        
    }
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return;
    }
//    PlayerStatsVC * nextVC = [[PlayerStatsVC alloc]init];
//    nextVC = (PlayerStatsVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"PlayerStats"];
//    nextVC.SelectedPlayerCode = [[PlayerListArray objectAtIndex:indexPath.section-1] valueForKey:@"PlayerCode"];
//    [self.navigationController pushViewController:nextVC animated:YES];
    
}
-(void)setShadow:(CALayer *)layer
{
    layer.shadowColor = [[UIColor blackColor] CGColor];
    layer.shadowOffset = CGSizeMake(10,3);
    layer.shadowOpacity = 1.0;
    
}
// 10 - 12
//
//


#pragma mark -    PieChartViewDelegate

-(CGFloat)centerCircleRadius
{
    return (IS_IPHONE_DEVICE ? 30 : 40);
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
}

-(double)pieChartView:(PieChartView *)pieChartView valueForSliceAtIndex:(NSUInteger)index
{
    double obj;
    
    if (pieChartView == self.battingFstPie) {

        obj = [[[[markers objectAtIndex:0]valueForKey:@"set1"] objectAtIndex:index] doubleValue];
    }
    else
    {
        obj = [[[[markers objectAtIndex:1]valueForKey:@"set2"] objectAtIndex:index] doubleValue];

    }
    
    return (obj == 0 ? 0 : 100/obj);
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

-(void)tossResultWebServiceFor:(NSString *)tossType
{
    
    /*
     
     API URL    : http://192.168.0.151:8044/AGAPTService.svc/APT_TOSSRESULTS/COMPRTETION_CODE/TEAM_CODE/TOSS_TYPE
     METHOD     : GET
     INPUT FORMAT : STRING QUERY FORMAT

     */
    
        if(![COMMON isInternetReachable])
            return;
        
        [AppCommon showLoading];
    
    NSString * tempStr = [NSString stringWithFormat:@"APT_TOSSRESULTS/%@/%@/%@",@"UCC0000008",@"TEA0000008",tossType];
        NSString *URLString =  URL_FOR_RESOURCE(tempStr);
    
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        manager.requestSerializer = requestSerializer;
        NSLog(@"parameters : %@",URLString);
    
        [manager GET:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if (responseObject) {
                _mainArray = responseObject;
                
                NSNumber* total = [_mainArray valueForKey:@"TotalMatches"];
                NSNumber* home = [_mainArray valueForKey:@"HomeMatches"];
                NSNumber* away = [_mainArray valueForKey:@"AwayMatches"];
                
                NSNumber *home_Per = @(100 / ([total floatValue] / [home floatValue]));
                NSNumber *away_Per = @(100 / ([total floatValue] / [away floatValue]));
                self.lblHomeMatch.text = [NSString stringWithFormat:@"%ld %@",[home_Per integerValue],@"%"];
                self.lblAwayMatch.text = [NSString stringWithFormat:@"%ld %@",[away_Per integerValue],@"%"];
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.resultCollectionView reloadData];
                [tossResultsSegment sendActionsForControlEvents:UIControlEventValueChanged];
            });
            
            [AppCommon hideLoading];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed");
            [COMMON webServiceFailureError:error];
            [AppCommon hideLoading];
            
        }];
    
    
}

- (IBAction)actionTossResults:(id)sender {
    
    UIImage* check = [UIImage imageNamed:@"radio_on"];
    UIImage* uncheck = [UIImage imageNamed:@"radio_off"];
    
    for (UIButton* tempBtn in btnToss) {
        if (tempBtn == sender) {
            [tempBtn setImage:check forState:UIControlStateNormal];
        }else {
            [tempBtn setImage:uncheck forState:UIControlStateNormal];
        }
    }
    
    [self tossResultWebServiceFor:[sender currentTitle]];
    
}


-(void)shakeAnimationInView:(UIView *)view
{
    
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
//    [animation setDuration:0.05];
//    [animation setRepeatCount:2];
//    [animation setAutoreverses:YES];
//    [animation setFromValue:[NSValue valueWithCGPoint:
//                             CGPointMake([view center].x - 20.0f, [view center].y)]];
//    [animation setToValue:[NSValue valueWithCGPoint:
//                           CGPointMake([view center].x + 20.0f, [view center].y)]];
//    [[view layer] addAnimation:animation forKey:@"position"];
    
    
//    view.transform = CGAffineTransformMakeTranslation(20, 0);
//    [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.2 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        view.transform = CGAffineTransformIdentity;
//    } completion:nil];


}
- (IBAction)actionUpdateToss:(id)sender {
}


- (IBAction)actionTossWonAndLost:(id)sender {
    
    /*
     "BattingFirstTw": 1,
     "BattingSecondTw": 7,

     
     "BattingFirstTl": 3,
     "BattingSecondTl": 3,

     "TeamCountTw": 0,
     "TeamCountTl": 0,
     "TotalMatches": 14,
     "TosswonMatches": 8,
     "MatchWonBFTw": 1,
     "MatchLostBFTw": 0,
     "MatchWonBSTw": 4,
     "MatchLostBSTw": 3,
     "TosslostMatches": 6,
     "MatchWonBFTl": 1,
     "MatchLostBFTl": 2,
     "MatchWonBSTl": 1,
     "MatchLostBSTl": 2
     */
    
    if(![sender selectedSegmentIndex]) // Won batting 1st and 2nd
    {
        NSNumber *TosswonMatches = [[[_mainArray valueForKey:@"TossList"]firstObject] valueForKey:@"TosswonMatches"];
        NSNumber *MatchWon1 = [[[_mainArray valueForKey:@"TossList"]firstObject] valueForKey:@"BattingFirstTw"];
        NSNumber *MatchLost1 = [[[_mainArray valueForKey:@"TossList"]firstObject] valueForKey:@"BattingFirstTl"];
        
        NSNumber *MatchWon2 = [[[_mainArray valueForKey:@"TossList"]firstObject] valueForKey:@"BattingSecondTw"];
        NSNumber *MatchLost2 = [[[_mainArray valueForKey:@"TossList"]firstObject] valueForKey:@"BattingSecondTl"];

        NSDictionary* set1 = @{@"set1":@[MatchWon1,MatchLost1]};
        NSDictionary* set2 = @{@"set2":@[MatchWon2,MatchLost2]};

        markers = [NSMutableArray new];
        [markers addObject:set1];
        [markers addObject:set2];
        
        lblMatchWon1.text = [MatchWon1 stringValue];
        lblMatchLost1.text = [MatchLost1 stringValue];
        NSNumber* tot1 = @([MatchWon1 integerValue] + [MatchLost1 integerValue]);
        lbl1stCenter.text = [tot1 stringValue];
        
        lblMatchWon2.text = [MatchWon2 stringValue];
        lblMatchLost2.text = [MatchLost2 stringValue];
        
        NSNumber* tot2 = @([MatchWon2 integerValue] + [MatchLost2 integerValue]);
        lbl2ndCenter.text = [tot2 stringValue];
        self.battingSecPie.obj.text = [tot1 stringValue];
        self.battingFstPie.obj.text = [tot2 stringValue];
        
    }
    else // Loss batting 1st and 2nd
    {
        NSNumber *TosslostMatches = [[[_mainArray valueForKey:@"TossList"] firstObject] valueForKey:@"TosslostMatches"];
        
        NSNumber *MatchWon1 = [[[_mainArray valueForKey:@"TossList"] firstObject] valueForKey:@"BattingFirstTw"];
        NSNumber *MatchLost1 = [[[_mainArray valueForKey:@"TossList"]firstObject] valueForKey:@"BattingFirstTl"];

        NSNumber *MatchWon2 = [[[_mainArray valueForKey:@"TossList"] firstObject] valueForKey:@"BattingSecondTw"];
        NSNumber *MatchLost2 = [[[_mainArray valueForKey:@"TossList"]firstObject] valueForKey:@"BattingSecondTl"];
        NSDictionary* set1 = @{@"set1":@[TosslostMatches,MatchWon2]};
        NSDictionary* set2 = @{@"set2":@[TosslostMatches,MatchLost2]};
        
        markers = [NSMutableArray new];
        [markers addObject:set1];
        [markers addObject:set2];
        
        lblMatchWon2.text = [MatchLost2 stringValue];
        lblMatchLost2.text = [MatchLost2 stringValue];
        
        NSNumber* tot1 = @([MatchWon2 integerValue] + [MatchLost2 integerValue]);
        self.battingSecPie.obj.text = [tot1 stringValue];

    }
    
    [self.battingFstPie reloadData];
    [self.battingSecPie reloadData];

}
@end
