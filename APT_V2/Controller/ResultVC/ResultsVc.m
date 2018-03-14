//
//  ResultsVc.m
//  NewSportsProject
//
//  Created by Mac on 18/11/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "ResultsVc.h"
#import "CustomNavigation.h"
#import "Config.h"
//#import "AdvanceFilter.h"
#import "AppCommon.h"
#import "WebService.h"
#import "ScoreCardVC.h"
#import "TabbarVC.h"
#import "Header.h"

@interface ResultsVc () <selectedDropDown>
{
    BOOL isPop;
    BOOL isList;
    
    TabbarVC *objtab;
    NSString *displayMatchCode;
    NSString* Teamcode;
}
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * popXposition;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * popWidth;
@end

@implementation ResultsVc

@synthesize competitionLbl,v1;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self customnavigationmethod];
    
    self.ShawdowView.clipsToBounds = NO;
    self.ShawdowView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.ShawdowView.layer.shadowOffset = CGSizeMake(0,5);
    self.ShawdowView.layer.shadowOpacity = 0.5;
    isList = YES;
//    self.competitionLbl.text = [[self.listCompArray valueForKey:@"COMPETITIONNAME"] objectAtIndex:0];
    competitionLbl.text = [AppCommon getCurrentCompetitionName];
    [self ResultsWebservice];
    self.popTbl.hidden = YES;
    
}

-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    
    UIView* view= self.view.subviews.firstObject;
    [view addSubview:objCustomNavigation.view];
    
    BOOL isBackEnable = [[NSUserDefaults standardUserDefaults] boolForKey:@"BACK"];
    
    isBackEnable = YES;
    if (isBackEnable) {
        objCustomNavigation.menu_btn.hidden =YES;
        objCustomNavigation.btn_back.hidden =NO;
        
        [objCustomNavigation.btn_back addTarget:self action:@selector(didClickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
        //[objCustomNavigation.btn_back addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    else
    {
        objCustomNavigation.menu_btn.hidden =NO;
        objCustomNavigation.btn_back.hidden =YES;
        [objCustomNavigation.menu_btn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.navi_View addSubview:objCustomNavigation.view];
    //    objCustomNavigation.tittle_lbl.text=@"";
    
}

-(IBAction)didClickCompetetion:(id)sender
{
//    if(isPop==NO)
//    {
//        [self.ListTbl setUserInteractionEnabled:NO];
//        self.popTbl.hidden = NO;
//        isPop = YES;
//        isList = NO;
//
//        self.popXposition.constant = self.v1.frame.origin.x;
//        self.popWidth.constant = self.CompetBtn.frame.size.width;
//
//        //[self.popTbl reloadData];
//
//    }
//    else
//    {
//        isPop=NO;
//        isList = YES;
//        self.popTbl.hidden = YES;
//        [self.ListTbl setUserInteractionEnabled:YES];
//    }
   /*
    DropDownTableViewController* dropVC = [[DropDownTableViewController alloc] init];
    dropVC.protocol = self;
    dropVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    dropVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [dropVC.view setBackgroundColor:[UIColor clearColor]];
    
        dropVC.array = appDel.ArrayCompetition;
        dropVC.key = @"CompetitionName";
        [dropVC.tblDropDown setFrame:CGRectMake(CGRectGetMinX(v1.frame), CGRectGetMaxY(v1.superview.frame)+10, CGRectGetWidth(v1.frame), 300)];
   */
   
    
    DropDownTableViewController* dropVC = [[DropDownTableViewController alloc] init];
    dropVC.protocol = self;
    dropVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    dropVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [dropVC.view setBackgroundColor:[UIColor clearColor]];
    
    if ([sender tag] == 1) { // TEAM
        
        
        NSMutableArray *teamArray = [[NSMutableArray alloc]init];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:@"All" forKey:@"TeamName"];
        [dic setObject:@"" forKey:@"TeamCode"];
        [teamArray addObject:dic];
        
        for(int i=0;i<appDel.ArrayTeam.count;i++)
        {
            [teamArray addObject:[appDel.ArrayTeam objectAtIndex:i]];
        }
        dropVC.array = teamArray;
        dropVC.key = @"TeamName";
        [dropVC.tblDropDown setFrame:CGRectMake(CGRectGetMinX(self.v2.frame), CGRectGetMaxY(self.v2.frame)+self.v2.frame.size.height+20, CGRectGetWidth(self.v2.frame), 300)];
        
        
    }
    else // COMPETETION
        {
        dropVC.array = appDel.ArrayCompetition;
        dropVC.key = @"CompetitionName";
        [dropVC.tblDropDown setFrame:CGRectMake(CGRectGetMinX(self.v1.frame), CGRectGetMaxY(self.v1.frame)+self.v1.frame.size.height+20, CGRectGetWidth(self.v1.frame), 300)];
        
        }
    
    
    [appDel.frontNavigationController presentViewController:dropVC animated:YES completion:^{
        NSLog(@"DropDown loaded");
    }];
    
}

//-(IBAction)didClickTeam:(id)sender
//{
//
//    if(isPop==NO)
//    {
//        self.popTbl.hidden = NO;
//        isPop = YES;
//        isList = NO;
//        self.popXposition.constant = self.v2.frame.origin.x;
//        self.popWidth.constant = self.SeasonBtn.frame.size.width;
//
//    }
//    else
//    {
//        isPop=NO;
//        isList = YES;
//        self.popTbl.hidden = YES;
//    }
//
//    [self.popTbl reloadData];
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(isList)
    {
        return self.resultArr.count;
    }
    if(isPop)
    {
        return self.listCompArray.count;
    }
    
    return nil;
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(isList==YES)
    {
        
        static NSString *MyIdentifier = @"MyIdentifier";
        
        
        
        ResultsCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
        if (cell == nil)
        {
            // cell = [[PointsTableCell alloc] initWithStyle:UITableViewCellStyleDefaultreuseIdentifier:MyIdentifier];
            
            if(IS_IPHONE_DEVICE)
            {
                [[NSBundle mainBundle] loadNibNamed:@"ResultsCell_iPhone" owner:self options:nil];
            }
            else
            {
                [[NSBundle mainBundle] loadNibNamed:@"ResultsCell_iPad" owner:self options:nil];
            }
        }
        cell = self.objCell;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSMutableArray *firstobj = [[NSMutableArray alloc]init];
        
        firstobj = [self.resultArr objectAtIndex:indexPath.row];
        
        NSString *dttime = [firstobj valueForKey:@"DateTime"];
        
        NSArray *components = [dttime componentsSeparatedByString:@" "];
        NSString *day = components[0];
        NSString *monthyear = components[1];
        NSString *time = components[2];
        NSString *local = components[3];
        
        cell.date.text = [NSString stringWithFormat:@"%@ %@",day,monthyear];
        cell.time.text = [NSString stringWithFormat:@"%@ %@",time,local];
        
        
        NSString *key = [firstobj valueForKey:@"TeamA"];
        
        if([ key isEqualToString:@"India"])
        {
            cell.team1Img.image = [UIImage imageNamed:@"Indialogo"];
            cell.team2Img.image = [UIImage imageNamed:@"Srilankalogo"];
        }
        else
        {
            cell.team1Img.image = [UIImage imageNamed:@"Srilankalogo"];
            cell.team2Img.image = [UIImage imageNamed:@"Indialogo"];
        }
        
        
        //        NSString *ground = [firstobj valueForKey:@"Ground"];
        //        NSString *place = [firstobj valueForKey:@"GroundCode"];
        //        cell.groundName.text = [NSString stringWithFormat:@"%@,%@",ground,place];
        
        
        if(![[firstobj valueForKey:@"FIRSTINNINGSSCORE"] isEqual:[NSNull null]])
        {
            if(![[firstobj valueForKey:@"FIRSTINNINGSSCORE"] isEqualToString:@"0 /0 (0.0 Ov)"])
            {
                cell.firstInn.text = [firstobj valueForKey:@"FIRSTINNINGSSCORE"];
            }
            else
            {
                cell.firstInn.text = @"";
            }
        }
        
        if(![[firstobj valueForKey:@"SECONDINNINGSSCORE"] isEqual:[NSNull null]])
        {
            if(![[firstobj valueForKey:@"SECONDINNINGSSCORE"] isEqualToString:@"0 /0 (0.0 Ov)"])
            {
                cell.secondInn.text = [firstobj valueForKey:@"SECONDINNINGSSCORE"];
            }
            else
            {
                cell.secondInn.text = @"";
            }
        }
        
        if(![[firstobj valueForKey:@"THIRDINNINGSSCORE"] isEqual:[NSNull null]])
        {
            if(![[firstobj valueForKey:@"THIRDINNINGSSCORE"] isEqualToString:@"0 /0 (0.0 Ov)"])
            {
                cell.thirdInn.text = [firstobj valueForKey:@"THIRDINNINGSSCORE"];
            }
            else
            {
                cell.thirdInn.text = @"";
            }
            
            //cell.thirdInn.text = [firstobj valueForKey:@"THIRDINNINGSSCORE"];
        }
        
        
        if(![[firstobj valueForKey:@"FOURTHINNINGSSCORE"] isEqual:[NSNull null]])
        {
            if(![[firstobj valueForKey:@"FOURTHINNINGSSCORE"] isEqualToString:@"0 /0 (0.0 Ov)"])
            {
                cell.fourthInn.text = [firstobj valueForKey:@"FOURTHINNINGSSCORE"];
            }
            else
            {
                cell.fourthInn.text = @"";
            }
        }
        
        cell.team1.text = [firstobj valueForKey:@"TeamA"];
        cell.team2.text = [firstobj valueForKey:@"TeamB"];
        
        if(![[firstobj valueForKey:@"MATCHRESULTORRUNSREQURED"] isEqualToString:@""])
        {
            cell.resultDetails.text = [firstobj valueForKey:@"MATCHRESULTORRUNSREQURED"];
        }
        
        return cell;
    }
    
    if(isPop==YES)
    {
        
        static NSString *MyIdentifier = @"MyIdentifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
        
        
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:nil];
        }
        
        cell.textLabel.text = [[self.listCompArray valueForKey:@"COMPETITIONNAME"] objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(isPop== YES)
    {
        return 50;
    }
    else
    {
        return 140;
    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(isPop==YES)
    {
        self.competitionLbl.text = [[self.listCompArray valueForKey:@"COMPETITIONNAME"]objectAtIndex:indexPath.row];
        
        isList = NO;
        isPop =NO;
        self.popTbl.hidden =YES;
        [self ResultsWebservice];
        [self.ListTbl setUserInteractionEnabled:YES];
    
    }
    if(isList==YES)
    {
        //        isList = NO;
        //        isPop =YES;
        displayMatchCode = [[self.resultArr valueForKey:@"MATCHCODE"] objectAtIndex:indexPath.row];
        NSMutableArray *scoreArray = [[NSMutableArray alloc]init];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        
        NSString *ground = [[self.resultArr valueForKey:@"Ground"]objectAtIndex:indexPath.row];
        NSString *place = [[self.resultArr valueForKey:@"GroundCode"]objectAtIndex:indexPath.row];
        
        [dic setValue:[NSString stringWithFormat:@"%@,%@",ground,place] forKey:@"ground"];
        [dic setValue:[[self.resultArr valueForKey:@"TeamA"] objectAtIndex:indexPath.row] forKey:@"team1"];
        [dic setValue:[[self.resultArr valueForKey:@"TeamB"]objectAtIndex:indexPath.row] forKey:@"team2"];
        [dic setValue:[[self.resultArr valueForKey:@"FIRSTINNINGSSCORE"]objectAtIndex:indexPath.row] forKey:@"Inn1Score"];
        [dic setValue:[[self.resultArr valueForKey:@"SECONDINNINGSSCORE"]objectAtIndex:indexPath.row] forKey:@"Inn2Score"];
        [dic setValue:[[self.resultArr valueForKey:@"THIRDINNINGSSCORE"]objectAtIndex:indexPath.row] forKey:@"Inn3Score"];
        [dic setValue:[[self.resultArr valueForKey:@"FOURTHINNINGSSCORE"]objectAtIndex:indexPath.row] forKey:@"Inn4Score"];
        [dic setValue:[[self.resultArr valueForKey:@"MATCHRESULTORRUNSREQURED"]objectAtIndex:indexPath.row] forKey:@"result"];
        [dic setValue:[[self.resultArr valueForKey:@"COMPETITIONNAME"]objectAtIndex:indexPath.row] forKey:@"Competition"];
        
        [scoreArray addObject:dic];
        
//        ScoreCardVC * objFix = [[ScoreCardVC alloc]init];
//        objFix = (ScoreCardVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"ScoreCardVC"];
//        objFix.matchCode = displayMatchCode;
//        objFix.matchDetails = scoreArray;
//        objFix.backkey = @"yes";
//        [self.navigationController pushViewController:objFix animated:YES];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        objtab = (TabbarVC *)[storyboard instantiateViewControllerWithIdentifier:@"TabbarVC"];
        appDel.Currentmatchcode = displayMatchCode;
        appDel.Scorearray = scoreArray;
        //objtab.backkey = @"yes";
        //[self.navigationController pushViewController:objFix animated:YES];
        [appDel.frontNavigationController pushViewController:objtab animated:YES];
        
    }
}

-(void)ResultsWebservice
{
    [AppCommon showLoading];
    if([COMMON isInternetReachable])
    {
    
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",ResultsKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        //NSString *competition = [[self.listCompArray valueForKey:@""] objectAtIndex:0];
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if([AppCommon getCurrentCompetitionCode])
            [dic    setObject:[AppCommon getCurrentCompetitionCode]     forKey:@"Competitioncode"];
    
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                
                self.resultArr = [[NSMutableArray alloc]init];
                NSMutableArray * filterarr = [[NSMutableArray alloc]init];
                
                if ([responseObject valueForKey:@"lstFixturesGridValues"]) {
                    filterarr = [responseObject valueForKey:@"lstFixturesGridValues"];

                }
                
                for( int i=0;i<filterarr.count;i++)
                {
                    if(![[[filterarr valueForKey:@"FIRSTINNINGSSCORE"] objectAtIndex:i] isEqual:[NSNull null]] || ![[[filterarr valueForKey:@"SECONDINNINGSSCORE"] objectAtIndex:i] isEqual:[NSNull null]] || ![[[filterarr valueForKey:@"THIRDINNINGSSCORE"] objectAtIndex:i] isEqual:[NSNull null]] || ![[[filterarr valueForKey:@"FOURTHINNINGSSCORE"] objectAtIndex:i] isEqual:[NSNull null]]  )
                    {
                        
                        [self.resultArr addObject:[filterarr objectAtIndex:i]];
                        
                        
                        
                        isList=YES;
                    }
                }
                self.TotalMatchesArr = [[NSMutableArray alloc]init];
                self.TotalMatchesArr = self.resultArr;
                
                self.teamLbl.text = @"All";
                Teamcode = @"";
                [self setFilterResults];
                
                
                //self.resultArr = [responseObject valueForKey:@"lstFixturesGridValues"];
                
            }
            
            
            //[self.ListTbl reloadData];
            
            [AppCommon hideLoading];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed");
            [COMMON webServiceFailureError:error];
            
        }];
    }
    
}


-(IBAction)didClickBackBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)selectedValue:(NSMutableArray *)array andKey:(NSString*)key andIndex:(NSIndexPath *)Index
{
    
    if ([key  isEqualToString: @"CompetitionName"]) {
        
        competitionLbl.text = [[array objectAtIndex:Index.row] valueForKey:key];
        NSString* Competetioncode = [[array objectAtIndex:Index.row] valueForKey:@"CompetitionCode"];
        
        [[NSUserDefaults standardUserDefaults] setValue:competitionLbl.text forKey:@"SelectedCompetitionName"];
        [[NSUserDefaults standardUserDefaults] setValue:Competetioncode forKey:@"SelectedCompetitionCode"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self ResultsWebservice];
        
    } else {
        
        self.teamLbl.text = [[array objectAtIndex:Index.row] valueForKey:key];
        Teamcode = [[array objectAtIndex:Index.row] valueForKey:@"TeamCode"];
        
        [[NSUserDefaults standardUserDefaults] setValue:self.teamLbl.text forKey:@"SelectedTeamName"];
        [[NSUserDefaults standardUserDefaults] setValue:Teamcode forKey:@"SelectedTeamCode"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    
         [self setFilterResults];
        }
    
}

-(void)setFilterResults
{
    
    if(![competitionLbl.text isEqualToString:@""] || ![self.teamLbl.text isEqualToString:@""] )
    {
        
        if([Teamcode isEqualToString:@""])
        {
            self.teamLbl.text =@"All";
            self.resultArr = [[NSMutableArray alloc]init];
            self.resultArr = self.TotalMatchesArr;
        }
        else
        {
            NSMutableArray *ReqTeamArray = [[NSMutableArray alloc]init];
            ReqTeamArray = self.TotalMatchesArr;
        
            self.resultArr = [[NSMutableArray alloc]init];
            for( int i=0;i<ReqTeamArray.count;i++)
            {
                NSString *selectedTeamCodeA = [[ReqTeamArray valueForKey:@"TeamACode"] objectAtIndex:i];
                NSString *selectedTeamCodeB = [[ReqTeamArray valueForKey:@"TeamBCode"] objectAtIndex:i];
                NSString *GlobalteamCode = [AppCommon getCurrentTeamCode];
                if([Teamcode isEqualToString:selectedTeamCodeA])
                {
                    [self.resultArr addObject:[ReqTeamArray objectAtIndex:i]];
                }
                else if([Teamcode isEqualToString:selectedTeamCodeB])
                {
                    [self.resultArr addObject:[ReqTeamArray objectAtIndex:i]];
                }
            }
        }
        [self.ListTbl reloadData];
    
    }
}

@end
