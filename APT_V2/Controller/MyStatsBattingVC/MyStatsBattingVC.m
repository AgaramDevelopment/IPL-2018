//
//  MyStatsBattingVC.m
//  APT_V2
//
//  Created by MAC on 06/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "MyStatsBattingVC.h"
#import "MyStatsBattingCell.h"
#import "Config.h"
#import "AppCommon.h"
#import "WebService.h"
#import "CustomNavigation.h"
#import "SWRevealViewController.h"

@interface MyStatsBattingVC ()
{
    
    NSInteger selectedIndex;
    NSIndexPath *lastIndex;
    
    NSString *userCode;
    NSString *clientCode;
    NSString *userRefCode;
    
        //wagon
    BOOL isOnes;
    BOOL isTwos;
    BOOL isThrees;
    BOOL isFours;
    BOOL isSixes;
    BOOL isAll;
    
    UIColor *strokeColor;
     UIButton * Img_ball;
    
}
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *battingTableViewHeight;

@end

@implementation MyStatsBattingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customnavigationmethod];
    
    lastIndex = NULL;
    selectedIndex = -1;
    
    isOnes = YES;
    isTwos = YES;
    isThrees = YES;
    isFours = YES;
    isSixes = YES;
    
    [self myStatsBattingPostMethodWebService];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
        //    [self.view addSubview:objCustomNavigation.view];
        //    objCustomNavigation.tittle_lbl.text=@"";
    
        //UIView* view= self.navigation_view.subviews.firstObject;
    [self.navigationView addSubview:objCustomNavigation.view];
    
    objCustomNavigation.btn_back.hidden =YES;
    objCustomNavigation.menu_btn.hidden =NO;
        //        [objCustomNavigation.btn_back addTarget:self action:@selector(didClickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.menu_btn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
        //        [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - UITableViewDataSource
    // number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
    // number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return overAllArray.count;
    }
    if (section == 1) {
        return recentMatchesArray.count;
    }
    return 0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MyStatsBattingCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"MyStatsBattingCell" owner:self options:nil];
     if (section == 0) {
         return nil;
     }
    if (section == 1) {
            // 1. Dequeue the custom header cell
        headerCell = arr[1];
            // 2. Set the various properties
            //    headerCell.title.text = @"Custom header from cell";
            //    [headerCell.title sizeToFit];
            //
            //    headerCell.subtitle.text = @"The subtitle";
            //    [headerCell.subtitle sizeToFit];
            //
            //    headerCell.image.image = [UIImage imageNamed:@"smiley-face"];
        
            // 3. And return
        return headerCell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    if (section == 1) {
        return (IS_IPAD)?65:55;
    }
    return 0;
}


    // the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyStatsBattingCell *cell;
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"MyStatsBattingCell" owner:self options:nil];
   
    if (indexPath.section == 0) {
        NSString * cellIdentifier =  @"battingCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell = arr[0];
        cell.overallMatchesLbl.text = [[overAllArray objectAtIndex:indexPath.row] valueForKey:@"Matches"];
        cell.overallInningsLbl.text = [[overAllArray objectAtIndex:indexPath.row] valueForKey:@"Inns"];
        cell.overallNOLbl.text = [[overAllArray objectAtIndex:indexPath.row] valueForKey:@"NOs"];
        cell.overallRunsLbl.text = [[overAllArray objectAtIndex:indexPath.row] valueForKey:@"Runs"];
        cell.overallBallsLbl.text = [[overAllArray objectAtIndex:indexPath.row] valueForKey:@"Balls"];
        cell.overallAvgLbl.text = [[overAllArray objectAtIndex:indexPath.row] valueForKey:@"BatAve"];
        cell.overallSRLbl.text = [[overAllArray objectAtIndex:indexPath.row] valueForKey:@"BatSR"];
        NSLog(@"S:%@", [[overAllArray objectAtIndex:indexPath.row] valueForKey:@"hunderds"]);
        NSString *hundreds = [self checkNull:[[overAllArray objectAtIndex:indexPath.row] valueForKey:@"hunderds"]];
        if ([hundreds isEqualToString:@""]) {
            hundreds = @"0";
        }
        cell.overallHundredsLbl.text = hundreds;
        NSLog(@"%@", cell.overallHundredsLbl.text);
        cell.overallFiftiesLbl.text = [[overAllArray objectAtIndex:indexPath.row] valueForKey:@"fifties"];
        cell.overallThirtiesLbl.text = [[overAllArray objectAtIndex:indexPath.row] valueForKey:@"thirties"];
        cell.overallFoursLbl.text = [[overAllArray objectAtIndex:indexPath.row] valueForKey:@"Fours"];
        cell.overallSixsLbl.text = [[overAllArray objectAtIndex:indexPath.row] valueForKey:@"Sixs"];
        cell.overallBDYPercentLbl.text = [[overAllArray objectAtIndex:indexPath.row] valueForKey:@"boundariespercent"];
        cell.overallDotPercentLbl.text = [[overAllArray objectAtIndex:indexPath.row] valueForKey:@"dotspercent"];
        cell.overallHSLbl.text = [[overAllArray objectAtIndex:indexPath.row] valueForKey:@"HS"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
    
    if (indexPath.section == 1) {

        NSString * cellIdentifier = (IS_IPAD)? @"battingCellForiPad" : @"battingCellForiPhone";
        cell =(MyStatsBattingCell *) [self.batttingTableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            [[NSBundle mainBundle] loadNibNamed:@"MyStatsBattingCell" owner:self options:nil];
            cell = (IS_IPAD)?self.StatsBattingCell: self.StatsBattingCellIphone;
                // self.batsmanCell = nil;
        }
        cell.backgroundColor = [UIColor clearColor];

        NSLog(@"recentMatchesArray:%@", recentMatchesArray);
        if (IS_IPAD) {
            cell.teamNameiPadLbl.text =  [[recentMatchesArray objectAtIndex:indexPath.row] valueForKey:@"OppTeamName"];
                //            cell.teamiPadImage.image = nil;
            cell.teamRunsiPadLbl.text = [[recentMatchesArray objectAtIndex:indexPath.row] valueForKey:@"Runs"];
            NSString *runs = [NSString stringWithFormat:@"(%@)", [[recentMatchesArray objectAtIndex:indexPath.row] valueForKey:@"Balls"]];
            cell.teamBallsiPadLbl.text = runs;
            
                // Match Date
            NSString *myString = [[recentMatchesArray objectAtIndex:indexPath.row] valueForKey:@"MatchDate"];
            NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"MM/dd/yyyy HH:mm:ss a";
            NSDate *yourDate = [dateFormatter dateFromString:myString];
            dateFormatter.dateFormat = @"dd MMM, yyyy";
            NSLog(@"%@",[dateFormatter stringFromDate:yourDate]);
            
            
            cell.matchDateiPadLbl.text = [dateFormatter stringFromDate:yourDate];
            cell.groundNameiPadLbl.text = [[recentMatchesArray objectAtIndex:indexPath.row] valueForKey:@"GroundName"];
            
            if (matchDetailsArray.count != 0) {
                cell.matchSRiPadLbl.text = [[matchDetailsArray objectAtIndex:indexPath.row] valueForKey:@"BatSR"];
                cell.matchDotiPadLbl.text = [[matchDetailsArray objectAtIndex:indexPath.row] valueForKey:@"dotspercent"];
                cell.matchBDYiPadLbl.text = [[matchDetailsArray objectAtIndex:indexPath.row] valueForKey:@"boundariespercent"];
                cell.matchFoursiPadLbl.text = [[matchDetailsArray objectAtIndex:indexPath.row] valueForKey:@"Fours"];
                cell.matchSixsiPadLbl.text = [[matchDetailsArray objectAtIndex:indexPath.row] valueForKey:@"Sixs"];
                cell.matchBDYFqiPadLbl.text = [[matchDetailsArray objectAtIndex:indexPath.row] valueForKey:@"boundaryfrequency"];
                
                [cell.onesBtniPad addTarget:self action:@selector(didClickOnesBatting:) forControlEvents:UIControlEventTouchUpInside];
                [cell.twoBtniPad addTarget:self action:@selector(didClicktwosBatting:) forControlEvents:UIControlEventTouchUpInside];
                [cell.threeBtniPad addTarget:self action:@selector(didClickthreeBatting:) forControlEvents:UIControlEventTouchUpInside];
                [cell.fourBtniPad addTarget:self action:@selector(didClickfourssBatting:) forControlEvents:UIControlEventTouchUpInside];
                [cell.sixBtniPad addTarget:self action:@selector(didClicksixesBatting:) forControlEvents:UIControlEventTouchUpInside];
                [cell.alllbliPad addTarget:self action:@selector(didClickAllBatting:) forControlEvents:UIControlEventTouchUpInside];
                
                    //wagon wheel
                if(self.wagonWheelDrawData.count>0)
                    {
                        //for(int i=0;i<self.wagonWheelDrawData.count;i++)
                    
                    NSMutableArray *sepArray = [[NSMutableArray alloc]init];
//                    sepArray= [[self.wagonWheelDrawData valueForKey:@"BattingSpiderWagonWheelValues"]objectAtIndex:indexPath.row];
                        sepArray= [self.wagonWheelDrawData valueForKey:@"BattingSpiderWagonWheelValues"];
                    if(![sepArray isEqual:[NSNull null]])
                        {
                        
                        for(int i=0;sepArray.count>i;i++)
                            {
                            for (CALayer *layer in cell.WagonImgiPad.layer.sublayers) {
                                if ([layer.name isEqualToString:@"DrawLine"]) {
                                    [layer removeFromSuperlayer];
                                    break;
                                }
                            }
                            }
                        
                        
                            //[self HideLable];
                        int x1position;
                        int y1position;
                        int x2position;
                        int y2position;
                        
                        int BASE_X = 280;
                        
                        NSMutableArray *onescount = [[NSMutableArray alloc]init];
                        NSMutableArray *twoscount = [[NSMutableArray alloc]init];
                        NSMutableArray *threescount = [[NSMutableArray alloc]init];
                        NSMutableArray *fourscount = [[NSMutableArray alloc]init];
                        NSMutableArray *sixscount = [[NSMutableArray alloc]init];
                        
                        
                        
                        for(int i=0; i<sepArray.count;i++)
                            {
                                //SpiderWagonRecords * objRecord =(SpiderWagonRecords *)[_spiderWagonArray objectAtIndex:i];
                            
                            
                                //                if(IS_IPHONE_DEVICE)
                                //                {
                                //                    x1position = [[[sepArray valueForKey:@"WWX1"] objectAtIndex:i] intValue]-105;
                                //                    y1position = [[[sepArray valueForKey:@"WWY1"] objectAtIndex:i] intValue]-90;
                                //                    x2position  =[[[sepArray valueForKey:@"WWX2"] objectAtIndex:i] intValue]-105;
                                //                    y2position  =[[[sepArray valueForKey:@"WWY2"] objectAtIndex:i] intValue]-90;
                                //                }
                                //
                                //                else
                                //                {
                                //                    x1position = [[[sepArray valueForKey:@"WWX1"] objectAtIndex:i] intValue];
                                //                    y1position = [[[sepArray valueForKey:@"WWY1"] objectAtIndex:i] intValue];
                                //                    x2position  =[[[sepArray valueForKey:@"WWX2"] objectAtIndex:i] intValue]-70;
                                //                    y2position  =[[[sepArray valueForKey:@"WWY2"] objectAtIndex:i] intValue]-70;
                                //
                                //                }
                                //
                                //
                                //                self.selectRuns =[[sepArray valueForKey:@"Runs"] objectAtIndex:i];
                                //
                                //                int Xposition = x1position-60;
                                //                int Yposition = y1position-40;
                                //
                                //
                                //                CGMutablePathRef straightLinePath = CGPathCreateMutable();
                                //                CGPathMoveToPoint(straightLinePath, NULL, Xposition, Yposition);
                                //                CGPathAddLineToPoint(straightLinePath, NULL,(x2position/2)+60,(y2position/2)+60);
                            
                            if(IS_IPHONE_DEVICE)
                                {
                                x1position = [[[sepArray valueForKey:@"WWX1"] objectAtIndex:i] intValue]-105;
                                y1position = [[[sepArray valueForKey:@"WWY1"] objectAtIndex:i] intValue]-90;
                                x2position  =[[[sepArray valueForKey:@"WWX2"] objectAtIndex:i] intValue]-105;
                                y2position  =[[[sepArray valueForKey:@"WWY2"] objectAtIndex:i] intValue]-90;
                                }
                            
                            else
                                {
                                    //                    x1position = [[[sepArray valueForKey:@"WWX1"] objectAtIndex:i] intValue];
                                    //                    y1position = [[[sepArray valueForKey:@"WWY1"] objectAtIndex:i] intValue];
                                    //                    x2position  =[[[sepArray valueForKey:@"WWX2"] objectAtIndex:i] intValue];
                                    //                  y2position  =[[[sepArray valueForKey:@"WWY2"] objectAtIndex:i] intValue];
                                
                                x1position = 100;
                                y1position = 84.7;
                                    //                    x2position  =196;
                                    //                    y2position  =109;
                                
                                x2position = (([[[sepArray valueForKey:@"WWX2"] objectAtIndex:i] floatValue ]/322)*200);
                                y2position = ([[[sepArray valueForKey:@"WWY2"] objectAtIndex:i] floatValue]/284)*200;
                                
                                
                                }
                            
                            
                            self.selectRuns =[[sepArray valueForKey:@"Runs"] objectAtIndex:i];
                            
                            int Xposition = x1position;
                            int Yposition = y1position;
                            
                            
                            CGMutablePathRef straightLinePath = CGPathCreateMutable();
                            CGPathMoveToPoint(straightLinePath, NULL, Xposition, Yposition);
                            CGPathAddLineToPoint(straightLinePath, NULL,x2position,y2position);
                            
                            
                            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
                                //[shapeLayer setPosition:cell.WagonImg.center];
                            shapeLayer.path = straightLinePath;
                            UIColor *fillColor = [UIColor redColor];
                            shapeLayer.fillColor = fillColor.CGColor;
                            
                            
                            
                                //NSString *color = [[sepArray valueForKey:@"Colour"] objectAtIndex:i];
                            
                            
                            if ([self.selectRuns isEqualToString: @"1"]) {
                                
                                
                                    //strokeColor = [UIColor colorWithRed:(255/255.0f) green:(108/255.0f) blue:(0/255.0f) alpha:1.0f];
                                
                                [onescount addObject:[[sepArray valueForKey:@"Runs"] objectAtIndex:i]];
                                NSString *ss = [NSString stringWithFormat:@"%lu",(unsigned long)onescount.count];
                                [cell.onesBtniPad setTitle:ss forState:UIControlStateNormal];
                                
                                NSString *color = [[sepArray valueForKey:@"Colour"] objectAtIndex:i];
                                
                                if(isOnes == YES)
                                    {
                                    strokeColor = [self colorWithHexString:color];
                                    }
                                else
                                    {
                                    strokeColor = [UIColor clearColor];
                                    }
                                
                                
                            }else if ([self.selectRuns isEqualToString: @"2"]){
                                
                                
                                    //strokeColor = [UIColor colorWithRed:(35/255.0f) green:(116/255.0f) blue:(205/255.0f) alpha:1.0f];
                                [twoscount addObject:[[sepArray valueForKey:@"Runs"] objectAtIndex:i]];
                                NSString *ss = [NSString stringWithFormat:@"%lu",(unsigned long)twoscount.count];
                                [cell.twoBtniPad setTitle:ss forState:UIControlStateNormal];
                                
                                NSString *color = [[sepArray valueForKey:@"Colour"] objectAtIndex:i];
                                    //strokeColor = [self colorWithHexString:color];
                                
                                if(isTwos == YES)
                                    {
                                    strokeColor = [self colorWithHexString:color];
                                    }
                                else
                                    {
                                    strokeColor = [UIColor clearColor];
                                    }
                                
                                
                                
                            }else if ([self.selectRuns isEqualToString: @"3"]){
                                
                                
                                    //strokeColor = [UIColor colorWithRed:(221/255.0f) green:(245/255.0f) blue:(10/255.0f) alpha:1.0f];
                                
                                [threescount addObject:[[sepArray valueForKey:@"Runs"] objectAtIndex:i]];
                                NSString *ss = [NSString stringWithFormat:@"%lu",(unsigned long)threescount.count];
                                [cell.threeBtniPad setTitle:ss forState:UIControlStateNormal];
                                
                                NSString *color = [[sepArray valueForKey:@"Colour"] objectAtIndex:i];
                                
                                    // strokeColor = [self colorWithHexString:color];
                                if(isThrees == YES)
                                    {
                                    strokeColor = [self colorWithHexString:color];
                                    }
                                else
                                    {
                                    strokeColor = [UIColor clearColor];
                                    }
                                
                                
                                
                            }else if ([self.selectRuns isEqualToString: @"4"]){
                                
                                
                                    //strokeColor = [UIColor colorWithRed:(208/255.0f) green:(31/255.0f) blue:(27/255.0f) alpha:1.0f];
                                [fourscount addObject:[[sepArray valueForKey:@"Runs"] objectAtIndex:i]];
                                NSString *ss = [NSString stringWithFormat:@"%lu",(unsigned long)fourscount.count];
                                [cell.fourBtniPad setTitle:ss forState:UIControlStateNormal];
                                
                                NSString *color = [[sepArray valueForKey:@"Colour"] objectAtIndex:i];
                                
                                    //strokeColor = [self colorWithHexString:color];
                                
                                if(isFours == YES)
                                    {
                                    strokeColor = [self colorWithHexString:color];
                                    }
                                else
                                    {
                                    strokeColor = [UIColor clearColor];
                                    }
                                
                                
                                
                                    //                }else if ([self.selectRuns isEqualToString: @"5"]){
                                    //                   // strokeColor = [UIColor colorWithRed:(255/255.0f) green:(204/255.0f) blue:(153/255.0f) alpha:1.0f];
                                    //                    NSString *color = [[sepArray valueForKey:@"Colour"] objectAtIndex:i];
                                    //                    strokeColor = [self colorWithHexString:color];
                                
                            }else if ([self.selectRuns isEqualToString: @"6"]){
                                
                                
                                    // strokeColor = [UIColor colorWithRed:(255/255.0f) green:(0/255.0f) blue:(255/255.0f) alpha:1.0f];
                                [sixscount addObject:[[sepArray valueForKey:@"Runs"] objectAtIndex:i]];
                                NSString *ss = [NSString stringWithFormat:@"%lu",(unsigned long)sixscount.count];
                                [cell.sixBtniPad setTitle:ss forState:UIControlStateNormal];
                                
                                NSString *color = [[sepArray valueForKey:@"Colour"] objectAtIndex:i];
                                
                                    //strokeColor = [self colorWithHexString:color];
                                
                                if(isSixes == YES)
                                    {
                                    strokeColor = [self colorWithHexString:color];
                                    }
                                else
                                    {
                                    strokeColor = [UIColor clearColor];
                                    }
                                
                            }
                            
                                //                else if ([self.selectRuns isEqualToString: @"0"]){
                                //
                                //                    //strokeColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1.0f];
                                //                    strokeColor = [self colorWithHexString:color];
                                //
                                //                }
                            
                            
                                //        else if ([objRecord.WICKETTYPE isEqualToString:@"0"]){
                                //            strokeColor = [UIColor colorWithRed:(150/255.0f) green:(57/255.0f) blue:(57/255.0f) alpha:1.0f];
                                //        }
                                //
                            
                            shapeLayer.strokeColor = strokeColor.CGColor;
                            shapeLayer.lineWidth = 2.0f;
                            shapeLayer.fillRule = kCAFillRuleNonZero;
                            shapeLayer.name = @"DrawLine";
                            [cell.WagonImgiPad.layer addSublayer:shapeLayer];
                            
                                //}
                            }
                        }
                    }
                
                    //pitch map
                
                if(self.pitchData.count>0)
                    {
                    
                    NSMutableArray *sepArray = [[NSMutableArray alloc]init];
//                    sepArray= [[self.pitchData valueForKey:@"PitchMapValuesBatting"]objectAtIndex:indexPath.row];
                    sepArray= [self.pitchData valueForKey:@"PitchMapValuesBatting"];
                    for(UIImageView * obj in [cell.PitchImgiPad subviews])
                        {
                        NSLog(@"%@",obj);
                        [obj removeFromSuperview];
                        }
                    
                    
                    int xposition;
                    int yposition;
                    
                    if(![sepArray isEqual:[NSNull null]])
                        {
                        for(int i=0; i<sepArray.count;i++)
                            {
                                //PitchReportdetailRecord * objRecord =(PitchReportdetailRecord *)[objPitchdetail objectAtIndex:i];
                            
                            if(IS_IPHONE_DEVICE)
                                {
                                xposition = [[[sepArray valueForKey:@"PMX2"] objectAtIndex:i] intValue]-90;
                                yposition = [[[sepArray valueForKey:@"PMY2"] objectAtIndex:i] intValue]-60;
                                }
                            else
                                {
                                
                                
                                    //                        xposition = [[[sepArray valueForKey:@"PMX2"] objectAtIndex:i] intValue]-83;
                                    //                        yposition = [[[sepArray valueForKey:@"PMY2"] objectAtIndex:i] intValue]-30;
                                
                                
                                xposition = (([[[sepArray valueForKey:@"PMX2"] objectAtIndex:i] floatValue ]/380)*200)-4;
                                yposition = (([[[sepArray valueForKey:@"PMY2"] objectAtIndex:i] floatValue]/295)*200)-1;
                                
                                }
                            
                            if([[self.pitchData valueForKey:@"Battingstyle"] isEqualToString:@"RIGHT"])
                                {
                                
                                cell.PitchImgiPad.image = [UIImage imageNamed:@"Pitchmap"];
                                }
                            else
                                {
                                cell.PitchImgiPad.image = [UIImage imageNamed:@"PitchmapLefthand"];
                                }
                            
                            NSString * run;
                            run =([[[sepArray valueForKey:@"Runs"] objectAtIndex:i] isEqualToString:@"0"])?@"":[[sepArray valueForKey:@"Runs"] objectAtIndex:i];
                            
                            if(!(xposition == 1 && yposition == 1) && (xposition!=0 && yposition !=0)){
                                
                                Img_ball =[[UIButton alloc]initWithFrame:CGRectMake(xposition,yposition,6, 6)];
                                    //Img_ball.image =[UIImage imageNamed:@"RedBall"];
                                
                                Img_ball.layer.cornerRadius =3;
                                Img_ball.layer.masksToBounds=YES;
                                if ([run isEqualToString: @"1"]) {
                                    
                                        //Img_ball.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1.0f];
                                        // else{
                                        //Img_ball.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(108/255.0f) blue:(0/255.0f) alpha:1.0f];
                                    if(isOnes == YES)
                                        {
                                        Img_ball.backgroundColor = [self colorWithHexString:@"22beef"];
                                        }
                                    else
                                        {
                                        Img_ball.backgroundColor =[UIColor clearColor];
                                        }
                                        // }
                                }else if ([run isEqualToString: @"2"]){
                                        //Img_ball.backgroundColor = [UIColor colorWithRed:(35/255.0f) green:(116/255.0f) blue:(205/255.0f) alpha:1.0f];
                                    if(isTwos == YES)
                                        {
                                        Img_ball.backgroundColor = [self colorWithHexString:@"ff6c00"];
                                        }
                                    else
                                        {
                                        Img_ball.backgroundColor =[UIColor clearColor];
                                        }
                                    
                                }else if ([run isEqualToString: @"3"]){
                                        //Img_ball.backgroundColor = [UIColor colorWithRed:(221/255.0f) green:(245/255.0f) blue:(10/255.0f) alpha:1.0f];
                                    
                                    if(isThrees == YES)
                                        {
                                        Img_ball.backgroundColor = [self colorWithHexString:@"A305C0"];
                                        }
                                    
                                    else
                                        {
                                        Img_ball.backgroundColor =[UIColor clearColor];
                                        }
                                    
                                }else if ([run isEqualToString: @"4"]){
                                        //Img_ball.backgroundColor = [UIColor colorWithRed:(208/255.0f) green:(31/255.0f) blue:(27/255.0f) alpha:1.0f];
                                    if(isFours == YES)
                                        {
                                        Img_ball.backgroundColor = [self colorWithHexString:@"2454f1"];
                                        }
                                    else
                                        {
                                        Img_ball.backgroundColor =[UIColor clearColor];
                                        }
                                    
                                    
                                }else if ([run isEqualToString: @"5"]){
                                        // Img_ball.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(204/255.0f) blue:(153/255.0f) alpha:1.0f];
                                    if(isFours == YES)
                                        {
                                        Img_ball.backgroundColor = [self colorWithHexString:@"22beef"];
                                        }
                                    else
                                        {
                                        Img_ball.backgroundColor =[UIColor clearColor];
                                        }
                                    
                                    
                                }else if ([run isEqualToString: @"6"]){
                                        // Img_ball.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(0/255.0f) blue:(255/255.0f) alpha:1.0f];
                                    
                                    
                                    if(isSixes == YES)
                                        {
                                        Img_ball.backgroundColor = [self colorWithHexString:@"ff00ea"];
                                        }
                                    else
                                        {
                                        Img_ball.backgroundColor =[UIColor clearColor];
                                        }
                                    
                                    
                                }
                                
                                    //                        else if ([run isEqualToString: @"0"]){
                                    //
                                    //                            Img_ball.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1.0f];
                                    //                        }
                                
                                [cell.PitchImgiPad addSubview:Img_ball];
                                
                            }
                            }
                        }
                    }
            }
            
        } else {
            cell.teamNameiPhoneLbl.text = [[recentMatchesArray objectAtIndex:indexPath.row] valueForKey:@"OppTeamName"];
            NSLog(@"OppTeamName:%@", cell.teamNameiPhoneLbl.text);
//            cell.teamiPhoneImage.image = nil;
            cell.teamRunsiPhoneLbl.text = [[recentMatchesArray objectAtIndex:indexPath.row] valueForKey:@"Runs"];
            NSString *runs = [NSString stringWithFormat:@"(%@)", [[recentMatchesArray objectAtIndex:indexPath.row] valueForKey:@"Balls"]];
            cell.teamBallsiPhoneLbl.text = runs;
            
                // Match Date
            NSString *myString = [[recentMatchesArray objectAtIndex:indexPath.row] valueForKey:@"MatchDate"];
            NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.dateFormat = @"MM/dd/yyyy HH:mm:ss a";
            NSDate *yourDate = [dateFormatter dateFromString:myString];
            dateFormatter.dateFormat = @"dd MMM, yyyy";
            NSLog(@"%@",[dateFormatter stringFromDate:yourDate]);
            
            cell.matchDateiPhoneLbl.text = [dateFormatter stringFromDate:yourDate];
            cell.groundNameiPhoneLbl.text = [[recentMatchesArray objectAtIndex:indexPath.row] valueForKey:@"GroundName"];
            
            if (matchDetailsArray.count != 0) {
                cell.matchSRiPhoneLbl.text = [[matchDetailsArray objectAtIndex:indexPath.row] valueForKey:@"BatSR"];
                cell.matchDotiPhoneLbl.text = [[matchDetailsArray objectAtIndex:indexPath.row] valueForKey:@"dotspercent"];
                cell.matchBDYiPhoneLbl.text = [[matchDetailsArray objectAtIndex:indexPath.row] valueForKey:@"boundariespercent"];
                cell.matchFoursiPhoneLbl.text = [[matchDetailsArray objectAtIndex:indexPath.row] valueForKey:@"Fours"];
                cell.matchSixsiPhoneLbl.text = [[matchDetailsArray objectAtIndex:indexPath.row] valueForKey:@"Sixs"];
                cell.matchBDYFqiPhoneLbl.text = [[matchDetailsArray objectAtIndex:indexPath.row] valueForKey:@"boundaryfrequency"];
                
                [cell.onesBtniPhone addTarget:self action:@selector(didClickOnesBatting:) forControlEvents:UIControlEventTouchUpInside];
                [cell.twoBtniPhone addTarget:self action:@selector(didClicktwosBatting:) forControlEvents:UIControlEventTouchUpInside];
                [cell.threeBtniPhone addTarget:self action:@selector(didClickthreeBatting:) forControlEvents:UIControlEventTouchUpInside];
                [cell.fourBtniPhone addTarget:self action:@selector(didClickfourssBatting:) forControlEvents:UIControlEventTouchUpInside];
                [cell.sixBtniPhone addTarget:self action:@selector(didClicksixesBatting:) forControlEvents:UIControlEventTouchUpInside];
                [cell.alllbliPhone addTarget:self action:@selector(didClickAllBatting:) forControlEvents:UIControlEventTouchUpInside];
                
                    //wagon wheel
                if(self.wagonWheelDrawData.count>0)
                    {
                        //for(int i=0;i<self.wagonWheelDrawData.count;i++)
                    
                    NSMutableArray *sepArray = [[NSMutableArray alloc]init];
                        //                    sepArray= [[self.wagonWheelDrawData valueForKey:@"BattingSpiderWagonWheelValues"]objectAtIndex:indexPath.row];
                    sepArray= [self.wagonWheelDrawData valueForKey:@"BattingSpiderWagonWheelValues"];
                    if(![sepArray isEqual:[NSNull null]])
                        {
                        
                        for(int i=0;sepArray.count>i;i++)
                            {
                            for (CALayer *layer in cell.WagonImgiPhone.layer.sublayers) {
                                if ([layer.name isEqualToString:@"DrawLine"]) {
                                    [layer removeFromSuperlayer];
                                    break;
                                }
                            }
                            }
                        
                        
                            //[self HideLable];
                        int x1position;
                        int y1position;
                        int x2position;
                        int y2position;
                        
                        int BASE_X = 280;
                        
                        NSMutableArray *onescount = [[NSMutableArray alloc]init];
                        NSMutableArray *twoscount = [[NSMutableArray alloc]init];
                        NSMutableArray *threescount = [[NSMutableArray alloc]init];
                        NSMutableArray *fourscount = [[NSMutableArray alloc]init];
                        NSMutableArray *sixscount = [[NSMutableArray alloc]init];
                        
                        
                        
                        for(int i=0; i<sepArray.count;i++)
                            {
                                //SpiderWagonRecords * objRecord =(SpiderWagonRecords *)[_spiderWagonArray objectAtIndex:i];
                            
                            
                                //                if(IS_IPHONE_DEVICE)
                                //                {
                                //                    x1position = [[[sepArray valueForKey:@"WWX1"] objectAtIndex:i] intValue]-105;
                                //                    y1position = [[[sepArray valueForKey:@"WWY1"] objectAtIndex:i] intValue]-90;
                                //                    x2position  =[[[sepArray valueForKey:@"WWX2"] objectAtIndex:i] intValue]-105;
                                //                    y2position  =[[[sepArray valueForKey:@"WWY2"] objectAtIndex:i] intValue]-90;
                                //                }
                                //
                                //                else
                                //                {
                                //                    x1position = [[[sepArray valueForKey:@"WWX1"] objectAtIndex:i] intValue];
                                //                    y1position = [[[sepArray valueForKey:@"WWY1"] objectAtIndex:i] intValue];
                                //                    x2position  =[[[sepArray valueForKey:@"WWX2"] objectAtIndex:i] intValue]-70;
                                //                    y2position  =[[[sepArray valueForKey:@"WWY2"] objectAtIndex:i] intValue]-70;
                                //
                                //                }
                                //
                                //
                                //                self.selectRuns =[[sepArray valueForKey:@"Runs"] objectAtIndex:i];
                                //
                                //                int Xposition = x1position-60;
                                //                int Yposition = y1position-40;
                                //
                                //
                                //                CGMutablePathRef straightLinePath = CGPathCreateMutable();
                                //                CGPathMoveToPoint(straightLinePath, NULL, Xposition, Yposition);
                                //                CGPathAddLineToPoint(straightLinePath, NULL,(x2position/2)+60,(y2position/2)+60);
                            
                            if(IS_IPHONE_DEVICE)
                                {
//                                x1position = [[[sepArray valueForKey:@"WWX1"] objectAtIndex:i] intValue]-105;
//                                y1position = [[[sepArray valueForKey:@"WWY1"] objectAtIndex:i] intValue]-90;
                                x1position = 65;
                                y1position = 55;
//                                x2position  =[[[sepArray valueForKey:@"WWX2"] objectAtIndex:i] intValue]-105;
//                                y2position  =[[[sepArray valueForKey:@"WWY2"] objectAtIndex:i] intValue]-90;
                                x2position  = (([[[sepArray valueForKey:@"WWX2"] objectAtIndex:i] floatValue ]/322)*130);
                                y2position  = (([[[sepArray valueForKey:@"WWY2"] objectAtIndex:i] floatValue]/284)*130);
                                }
                            
                            else
                                {
                                    //                    x1position = [[[sepArray valueForKey:@"WWX1"] objectAtIndex:i] intValue];
                                    //                    y1position = [[[sepArray valueForKey:@"WWY1"] objectAtIndex:i] intValue];
                                    //                    x2position  =[[[sepArray valueForKey:@"WWX2"] objectAtIndex:i] intValue];
                                    //                  y2position  =[[[sepArray valueForKey:@"WWY2"] objectAtIndex:i] intValue];
                                
                                x1position = 100;
                                y1position = 84.7;
                                    //                    x2position  =196;
                                    //                    y2position  =109;
                                
                                x2position = (([[[sepArray valueForKey:@"WWX2"] objectAtIndex:i] floatValue ]/322)*200);
                                y2position = ([[[sepArray valueForKey:@"WWY2"] objectAtIndex:i] floatValue]/284)*200;
                                
                                
                                }
                            
                            
                            self.selectRuns =[[sepArray valueForKey:@"Runs"] objectAtIndex:i];
                            
                            int Xposition = x1position;
                            int Yposition = y1position;
                            
                            
                            CGMutablePathRef straightLinePath = CGPathCreateMutable();
                            CGPathMoveToPoint(straightLinePath, NULL, Xposition, Yposition);
                            CGPathAddLineToPoint(straightLinePath, NULL,x2position,y2position);
                            
                            
                            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
                                //[shapeLayer setPosition:cell.WagonImg.center];
                            shapeLayer.path = straightLinePath;
                            UIColor *fillColor = [UIColor redColor];
                            shapeLayer.fillColor = fillColor.CGColor;
                            
                            
                            
                                //NSString *color = [[sepArray valueForKey:@"Colour"] objectAtIndex:i];
                            
                            
                            if ([self.selectRuns isEqualToString: @"1"]) {
                                
                                
                                    //strokeColor = [UIColor colorWithRed:(255/255.0f) green:(108/255.0f) blue:(0/255.0f) alpha:1.0f];
                                
                                [onescount addObject:[[sepArray valueForKey:@"Runs"] objectAtIndex:i]];
                                NSString *ss = [NSString stringWithFormat:@"%lu",(unsigned long)onescount.count];
                                [cell.onesBtniPhone setTitle:ss forState:UIControlStateNormal];
                                
                                NSString *color = [[sepArray valueForKey:@"Colour"] objectAtIndex:i];
                                
                                if(isOnes == YES)
                                    {
                                    strokeColor = [self colorWithHexString:color];
                                    }
                                else
                                    {
                                    strokeColor = [UIColor clearColor];
                                    }
                                
                                
                            }else if ([self.selectRuns isEqualToString: @"2"]){
                                
                                
                                    //strokeColor = [UIColor colorWithRed:(35/255.0f) green:(116/255.0f) blue:(205/255.0f) alpha:1.0f];
                                [twoscount addObject:[[sepArray valueForKey:@"Runs"] objectAtIndex:i]];
                                NSString *ss = [NSString stringWithFormat:@"%lu",(unsigned long)twoscount.count];
                                [cell.twoBtniPhone setTitle:ss forState:UIControlStateNormal];
                                
                                NSString *color = [[sepArray valueForKey:@"Colour"] objectAtIndex:i];
                                    //strokeColor = [self colorWithHexString:color];
                                
                                if(isTwos == YES)
                                    {
                                    strokeColor = [self colorWithHexString:color];
                                    }
                                else
                                    {
                                    strokeColor = [UIColor clearColor];
                                    }
                                
                                
                                
                            }else if ([self.selectRuns isEqualToString: @"3"]){
                                
                                
                                    //strokeColor = [UIColor colorWithRed:(221/255.0f) green:(245/255.0f) blue:(10/255.0f) alpha:1.0f];
                                
                                [threescount addObject:[[sepArray valueForKey:@"Runs"] objectAtIndex:i]];
                                NSString *ss = [NSString stringWithFormat:@"%lu",(unsigned long)threescount.count];
                                [cell.threeBtniPhone setTitle:ss forState:UIControlStateNormal];
                                
                                NSString *color = [[sepArray valueForKey:@"Colour"] objectAtIndex:i];
                                
                                    // strokeColor = [self colorWithHexString:color];
                                if(isThrees == YES)
                                    {
                                    strokeColor = [self colorWithHexString:color];
                                    }
                                else
                                    {
                                    strokeColor = [UIColor clearColor];
                                    }
                                
                                
                                
                            }else if ([self.selectRuns isEqualToString: @"4"]){
                                
                                
                                    //strokeColor = [UIColor colorWithRed:(208/255.0f) green:(31/255.0f) blue:(27/255.0f) alpha:1.0f];
                                [fourscount addObject:[[sepArray valueForKey:@"Runs"] objectAtIndex:i]];
                                NSString *ss = [NSString stringWithFormat:@"%lu",(unsigned long)fourscount.count];
                                [cell.fourBtniPhone setTitle:ss forState:UIControlStateNormal];
                                
                                NSString *color = [[sepArray valueForKey:@"Colour"] objectAtIndex:i];
                                
                                    //strokeColor = [self colorWithHexString:color];
                                
                                if(isFours == YES)
                                    {
                                    strokeColor = [self colorWithHexString:color];
                                    }
                                else
                                    {
                                    strokeColor = [UIColor clearColor];
                                    }
                                
                                
                                
                                    //                }else if ([self.selectRuns isEqualToString: @"5"]){
                                    //                   // strokeColor = [UIColor colorWithRed:(255/255.0f) green:(204/255.0f) blue:(153/255.0f) alpha:1.0f];
                                    //                    NSString *color = [[sepArray valueForKey:@"Colour"] objectAtIndex:i];
                                    //                    strokeColor = [self colorWithHexString:color];
                                
                            }else if ([self.selectRuns isEqualToString: @"6"]){
                                
                                
                                    // strokeColor = [UIColor colorWithRed:(255/255.0f) green:(0/255.0f) blue:(255/255.0f) alpha:1.0f];
                                [sixscount addObject:[[sepArray valueForKey:@"Runs"] objectAtIndex:i]];
                                NSString *ss = [NSString stringWithFormat:@"%lu",(unsigned long)sixscount.count];
                                [cell.sixBtniPhone setTitle:ss forState:UIControlStateNormal];
                                
                                NSString *color = [[sepArray valueForKey:@"Colour"] objectAtIndex:i];
                                
                                    //strokeColor = [self colorWithHexString:color];
                                
                                if(isSixes == YES)
                                    {
                                    strokeColor = [self colorWithHexString:color];
                                    }
                                else
                                    {
                                    strokeColor = [UIColor clearColor];
                                    }
                                
                            }
                            
                                //                else if ([self.selectRuns isEqualToString: @"0"]){
                                //
                                //                    //strokeColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1.0f];
                                //                    strokeColor = [self colorWithHexString:color];
                                //
                                //                }
                            
                            
                                //        else if ([objRecord.WICKETTYPE isEqualToString:@"0"]){
                                //            strokeColor = [UIColor colorWithRed:(150/255.0f) green:(57/255.0f) blue:(57/255.0f) alpha:1.0f];
                                //        }
                                //
                            
                            shapeLayer.strokeColor = strokeColor.CGColor;
                            shapeLayer.lineWidth = 2.0f;
                            shapeLayer.fillRule = kCAFillRuleNonZero;
                            shapeLayer.name = @"DrawLine";
                            [cell.WagonImgiPhone.layer addSublayer:shapeLayer];
                            
                                //}
                            }
                        }
                    }
                
                    //pitch map
                
                if(self.pitchData.count>0)
                    {
                    
                    NSMutableArray *sepArray = [[NSMutableArray alloc]init];
                        //                    sepArray= [[self.pitchData valueForKey:@"PitchMapValuesBatting"]objectAtIndex:indexPath.row];
                    sepArray= [self.pitchData valueForKey:@"PitchMapValuesBatting"];
                    for(UIImageView * obj in [cell.PitchImgiPhone subviews])
                        {
                        NSLog(@"%@",obj);
                        [obj removeFromSuperview];
                        }
                    
                    
                    int xposition;
                    int yposition;
                    
                    if(![sepArray isEqual:[NSNull null]])
                        {
                        for(int i=0; i<sepArray.count;i++)
                            {
                                //PitchReportdetailRecord * objRecord =(PitchReportdetailRecord *)[objPitchdetail objectAtIndex:i];
                            
                            if(IS_IPHONE_DEVICE)
                                {
//                                xposition = [[[sepArray valueForKey:@"PMX2"] objectAtIndex:i] intValue]-90;
//                                yposition = [[[sepArray valueForKey:@"PMY2"] objectAtIndex:i] intValue]-60;
                                xposition = (([[[sepArray valueForKey:@"PMX2"] objectAtIndex:i] floatValue ]/380)*130)-4;
                                yposition = (([[[sepArray valueForKey:@"PMY2"] objectAtIndex:i] floatValue]/295)*130)-1;
                                }
                            else
                                {
                                
                                
                                    //                        xposition = [[[sepArray valueForKey:@"PMX2"] objectAtIndex:i] intValue]-83;
                                    //                        yposition = [[[sepArray valueForKey:@"PMY2"] objectAtIndex:i] intValue]-30;
                                
                                
                                xposition = (([[[sepArray valueForKey:@"PMX2"] objectAtIndex:i] floatValue ]/380)*200)-4;
                                yposition = (([[[sepArray valueForKey:@"PMY2"] objectAtIndex:i] floatValue]/295)*200)-1;
                                
                                }
                            
                            if([[self.pitchData valueForKey:@"Battingstyle"] isEqualToString:@"RIGHT"])
                                {
                                
                                cell.PitchImgiPhone.image = [UIImage imageNamed:@"Pitchmap"];
                                }
                            else
                                {
                                cell.PitchImgiPhone.image = [UIImage imageNamed:@"PitchmapLefthand"];
                                }
                            
                            NSString * run;
                            run =([[[sepArray valueForKey:@"Runs"] objectAtIndex:i] isEqualToString:@"0"])?@"":[[sepArray valueForKey:@"Runs"] objectAtIndex:i];
                            
                            if(!(xposition == 1 && yposition == 1) && (xposition!=0 && yposition !=0)){
                                
                                Img_ball =[[UIButton alloc]initWithFrame:CGRectMake(xposition,yposition,6, 6)];
                                    //Img_ball.image =[UIImage imageNamed:@"RedBall"];
                                
                                Img_ball.layer.cornerRadius =3;
                                Img_ball.layer.masksToBounds=YES;
                                if ([run isEqualToString: @"1"]) {
                                    
                                        //Img_ball.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1.0f];
                                        // else{
                                        //Img_ball.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(108/255.0f) blue:(0/255.0f) alpha:1.0f];
                                    if(isOnes == YES)
                                        {
                                        Img_ball.backgroundColor = [self colorWithHexString:@"22beef"];
                                        }
                                    else
                                        {
                                        Img_ball.backgroundColor =[UIColor clearColor];
                                        }
                                        // }
                                }else if ([run isEqualToString: @"2"]){
                                        //Img_ball.backgroundColor = [UIColor colorWithRed:(35/255.0f) green:(116/255.0f) blue:(205/255.0f) alpha:1.0f];
                                    if(isTwos == YES)
                                        {
                                        Img_ball.backgroundColor = [self colorWithHexString:@"ff6c00"];
                                        }
                                    else
                                        {
                                        Img_ball.backgroundColor =[UIColor clearColor];
                                        }
                                    
                                }else if ([run isEqualToString: @"3"]){
                                        //Img_ball.backgroundColor = [UIColor colorWithRed:(221/255.0f) green:(245/255.0f) blue:(10/255.0f) alpha:1.0f];
                                    
                                    if(isThrees == YES)
                                        {
                                        Img_ball.backgroundColor = [self colorWithHexString:@"A305C0"];
                                        }
                                    
                                    else
                                        {
                                        Img_ball.backgroundColor =[UIColor clearColor];
                                        }
                                    
                                }else if ([run isEqualToString: @"4"]){
                                        //Img_ball.backgroundColor = [UIColor colorWithRed:(208/255.0f) green:(31/255.0f) blue:(27/255.0f) alpha:1.0f];
                                    if(isFours == YES)
                                        {
                                        Img_ball.backgroundColor = [self colorWithHexString:@"2454f1"];
                                        }
                                    else
                                        {
                                        Img_ball.backgroundColor =[UIColor clearColor];
                                        }
                                    
                                    
                                }else if ([run isEqualToString: @"5"]){
                                        // Img_ball.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(204/255.0f) blue:(153/255.0f) alpha:1.0f];
                                    if(isFours == YES)
                                        {
                                        Img_ball.backgroundColor = [self colorWithHexString:@"22beef"];
                                        }
                                    else
                                        {
                                        Img_ball.backgroundColor =[UIColor clearColor];
                                        }
                                    
                                    
                                }else if ([run isEqualToString: @"6"]){
                                        // Img_ball.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(0/255.0f) blue:(255/255.0f) alpha:1.0f];
                                    
                                    
                                    if(isSixes == YES)
                                        {
                                        Img_ball.backgroundColor = [self colorWithHexString:@"ff00ea"];
                                        }
                                    else
                                        {
                                        Img_ball.backgroundColor =[UIColor clearColor];
                                        }
                                    
                                    
                                }
                                
                                    //                        else if ([run isEqualToString: @"0"]){
                                    //
                                    //                            Img_ball.backgroundColor = [UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:1.0f];
                                    //                        }
                                
                                [cell.PitchImgiPhone addSubview:Img_ball];
                                
                            }
                            }
                        }
                    }
            }
        }
    
        return cell;
    }
     return nil;
}

#pragma mark - UITableViewDelegate
    // when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        
        NSString *matchCode = [self checkNull:[[recentMatchesArray objectAtIndex:indexPath.row] valueForKey:@"MatchCode"]];
        NSString *innigs = [self checkNull:[[recentMatchesArray objectAtIndex:indexPath.row] valueForKey:@"InnsNo"]];
        NSString *playerCode = [self checkNull:[[recentMatchesArray objectAtIndex:indexPath.row] valueForKey:@"PlayerCode"]];
        
        [self getMatchBattingPerformanceGetMethodWebServiceMatchCode:matchCode inningsNo:innigs andPlayerCode:playerCode];
        
        //WagonWheel Web Service
        [self wagonWheelWebservicePlayerCode:playerCode andMatchCode:matchCode andInningsNo:innigs];
        //Pitch Map Web Service
        [self pitchMapWebservicePlayerCode:playerCode andMatchCode:matchCode andInningsNo:innigs];
        [self.batttingTableView beginUpdates];
        
        if(indexPath.row == selectedIndex) {
            selectedIndex = -1;
                //cell.scoreView.hidden = YES;
            lastIndex = NULL;
        } else {
                //cell.scoreView.hidden = NO;
            if(lastIndex != nil) {
            
                [self.batttingTableView reloadRowsAtIndexPaths:@[lastIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
                
                isOnes = YES;
                isTwos = YES;
                isThrees = YES;
                isFours = YES;
                isSixes = YES;
            }
            lastIndex = indexPath;
            selectedIndex = indexPath.row;
        }
            //[self.batttingTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem: indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
            //[self.batttingTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self.batttingTableView endUpdates];
        
        [self.batttingTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.batttingTableView reloadData];
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return (IS_IPAD)?380:285;
    }
    
    if (indexPath.section == 1) {
        if(indexPath.row ==  selectedIndex)
        {
            return 420;
        } else {
            return (IS_IPAD)?80: 60;
        }
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(MyStatsBattingCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1  )
    {
        if (selectedIndex == indexPath.row)
            {
                [cell setBackgroundColor:[UIColor lightGrayColor]];
                [cell setAccessibilityTraits:UIAccessibilityTraitSelected];
                CGFloat height = MIN(self.view.bounds.size.height, self.batttingTableView.contentSize.height);
                self.battingTableViewHeight.constant = height;
                    cell.scoreView.hidden = NO;
                [self.view layoutIfNeeded];
            } else {
                [cell setBackgroundColor:[UIColor clearColor]];
                [cell setAccessibilityTraits:0];
                    cell.scoreView.hidden = YES;

                CGFloat height = MIN(self.view.bounds.size.height, self.batttingTableView.contentSize.height);
                self.battingTableViewHeight.constant = height;
                [self.view layoutIfNeeded];
            }
        }
}

- (void)myStatsBattingPostMethodWebService {
    
    if(![COMMON isInternetReachable])
        return;
    
    [AppCommon showLoading];
        //        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",LoginKey]];
    NSString *URLString =  URL_FOR_RESOURCE(playerMyStatsBatting);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.requestSerializer = requestSerializer;
    
    clientCode = [AppCommon GetClientCode];
    userCode = [AppCommon GetUsercode];
    userRefCode = [AppCommon GetuserReference];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if(clientCode)   [dic    setObject:clientCode     forKey:@"ClientCode"];
    if(userCode)   [dic    setObject:userCode     forKey:@"UserCode"];
    if(userRefCode)   [dic    setObject:userRefCode     forKey:@"UserrefCode"];
    
    NSLog(@"parameters : %@",dic);
    [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response ; %@",responseObject);
        
        overAllArray = [NSMutableArray new];
        overAllArray = [responseObject valueForKey:@"PlayerDetailsList"];
        recentMatchesArray = [NSMutableArray new];
        recentMatchesArray = [responseObject valueForKey:@"PlayerRecentDetailsList"];
        
//        [self.battingBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.batttingTableView reloadData];
        });
        
        [AppCommon hideLoading];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed");
        [COMMON webServiceFailureError:error];
        [AppCommon hideLoading];
        
    }];
    
}

- (void)getMatchBattingPerformanceGetMethodWebServiceMatchCode:(NSString*)matchCode inningsNo:(NSString*)innings andPlayerCode:(NSString*)playerCode {
    /*
     
     API URL    :   http://192.168.0.151:8044/AGAPTService.svc/GETMATCHBATTINGPERFORMANCE/
     METHOD     :   GET
     PARAMETER  :   {CLIENTCODE}/{USERREFCODE}/{PLAYERCODE}/{MATCHCODE}/{INNGS}
     */
    
    if(![COMMON isInternetReachable])
        return;
    
    [AppCommon showLoading];
    
    NSString *API_URL = [NSString stringWithFormat:@"%@GETMATCHBATTINGPERFORMANCE/%@/%@/%@/%@/%@",URL_FOR_RESOURCE(@""),clientCode,userRefCode,playerCode, matchCode, innings];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = requestSerializer;
    
    [manager GET:API_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"SUCCESS RESPONSE:%@",responseObject);
        matchDetailsArray = [NSMutableArray new];
        matchDetailsArray = [responseObject valueForKey:@"PlayerMatchDetailsList"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.batttingTableView reloadData];
        });
        
        [AppCommon hideLoading];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"FAILURE RESPONSE %@",error.description);
        [COMMON webServiceFailureError:error];
        [AppCommon hideLoading];
    }];
}

-(void)wagonWheelWebservicePlayerCode:(NSString*)playerCode andMatchCode:(NSString*)matchCode andInningsNo:(NSString*)innings
{
    /*
     API URL    :   http://192.168.0.151:8044/AGAPTService.svc/GETSCORECARDBATTINGSPIDERWAGONWHEEL/
     METHOD     :   GET
     PARAMETER  :   {PLAYERCODE}/{MATCHCODE}/{INNGS}
     */

    if(![COMMON isInternetReachable])
        return;
    
    [AppCommon showLoading];
    
    NSString *API_URL = [NSString stringWithFormat:@"%@GETSCORECARDBATTINGSPIDERWAGONWHEEL/%@/%@/%@",URL_FOR_RESOURCE(@""),playerCode, matchCode, innings];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = requestSerializer;
    
    [manager GET:API_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"SUCCESS RESPONSE:%@",responseObject);
        self.wagonWheelDrawData = [NSMutableArray new];
        self.wagonWheelDrawData = responseObject;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.batttingTableView reloadData];
        });
        
        [AppCommon hideLoading];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"FAILURE RESPONSE %@",error.description);
        [COMMON webServiceFailureError:error];
        [AppCommon hideLoading];
    }];
}

- (void)pitchMapWebservicePlayerCode:(NSString*)playerCode andMatchCode:(NSString*)matchCode andInningsNo:(NSString*)innings
{
    /*
     API URL    :   http://192.168.0.151:8044/AGAPTService.svc/FETCH_SCORECARD_PITCHMAP/
     METHOD     :   GET
     PARAMETER  :   {PLAYERCODE}/{MATCHCODE}/{INNGS}
     */
    
    if(![COMMON isInternetReachable])
        return;
    
    [AppCommon showLoading];
    
    NSString *API_URL = [NSString stringWithFormat:@"%@FETCH_SCORECARD_PITCHMAP/%@/%@/%@",URL_FOR_RESOURCE(@""),playerCode, matchCode, innings];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = requestSerializer;
    
    [manager GET:API_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"SUCCESS RESPONSE:%@",responseObject);
        self.pitchData = [NSMutableArray new];
        self.pitchData = responseObject;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.batttingTableView reloadData];
        });
        
        [AppCommon hideLoading];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"FAILURE RESPONSE %@",error.description);
        [COMMON webServiceFailureError:error];
        [AppCommon hideLoading];
    }];
}
/*
{
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]init];
    
    [objWebservice Battingpitchmap :ScorecardPitchmapKey  :playercode :self.matchCode :innno success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        if(responseObject >0)
            {
            
            
            [dic1 setValue:[responseObject valueForKey:@"PitchMapValuesBatting"] forKey:@"Value"];
            [dic1 setValue:playercode forKey:@"playercode"];
            [dic1 setValue:[responseObject valueForKey:@"BattingStyle"] forKey:@"Battingstyle"];
            
            
            
            }
        
        
    } failure:^(AFHTTPRequestOperation *operation, id error) {
        NSLog(@"failed");
        [COMMON webServiceFailureError];
        
    }];
    return dic1;
}
*/
- (IBAction)battingAction:(id)sender {
    
    
}

-(IBAction)didClickOnesBatting:(id)sender
{
    isOnes = YES;
    isTwos = NO;
    isThrees = NO;
    isFours = NO;
    isSixes = NO;
    
    [self.batttingTableView reloadData];
}

-(IBAction)didClicktwosBatting:(id)sender
{
    isOnes = NO;
    isTwos = YES;
    isThrees = NO;
    isFours = NO;
    isSixes = NO;
    
    [self.batttingTableView reloadData];
}

-(IBAction)didClickthreeBatting:(id)sender
{
    isOnes = NO;
    isTwos = NO;
    isThrees = YES;
    isFours = NO;
    isSixes = NO;
    
    [self.batttingTableView reloadData];
}

-(IBAction)didClickfourssBatting:(id)sender
{
    isOnes = NO;
    isTwos = NO;
    isThrees = NO;
    isFours = YES;
    isSixes = NO;
    
    [self.batttingTableView reloadData];
}

-(IBAction)didClicksixesBatting:(id)sender
{
    isOnes = NO;
    isTwos = NO;
    isThrees = NO;
    isFours = NO;
    isSixes = YES;
    
    [self.batttingTableView reloadData];
}

-(IBAction)didClickAllBatting:(id)sender
{
  
    isOnes = YES;
    isTwos = YES;
    isThrees = YES;
    isFours = YES;
    isSixes = YES;
    
    [self.batttingTableView reloadData];
}

-(NSString *)checkNull:(NSString *)_value
{
    if ([_value isEqual:[NSNull null]] || _value == nil || [_value isEqual:@"<null>"]) {
        _value=@"";
    }
    return _value;
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
    /*
     CGFloat red   = ((baseColor1 & 0xFF0000) >> 16) / 255.0f;
     CGFloat green = ((baseColor1 & 0x00FF00) >>  8) / 255.0f;
     CGFloat blue  =  (baseColor1 & 0x0000FF) / 255.0f;
     */[scanner scanHexInt:&hexint];
    
    
    
        //-----------------------------------------
        // Create color object, specifying alpha
        //-----------------------------------------
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255.0f
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255.0f
                     blue:((CGFloat) (hexint & 0xFF))/255.0f
                    alpha:1.0f];
    
    return color;
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
