//
//  MCOverViewVC.m
//  APT_V2
//
//  Created by apple on 05/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "MCOverViewVC.h"
#import "MCOverViewResultCVC.h"
#import "CustomNavigation.h"
#import "SWRevealViewController.h"
#import "Config.h"
#import "WebService.h"
#import "ResultsVc.h"

@interface MCOverViewVC ()
{
    WebService *objWebservice;
    ResultsVc *objresult;
    NSMutableArray *recentMatchesArray;
    NSMutableArray *resultsArray;
    NSMutableArray *CommonArray;
    NSMutableArray *BatsmenArray;
    NSMutableArray *BowlersArray;
    NSMutableArray *FieldersArray;
    NSArray* competetinArray;
    
    NSString *CompetitionCode;
    NSString *teamcode;
    
    BOOL isComp;
    BOOL isTeam;
}

@end

@implementation MCOverViewVC

@synthesize competitionlbl,dropviewComp;

@synthesize viewCompetetion,viewTeam;

@synthesize lblCompetetion,lblTeamName;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    
    NSString *rolecode = [[NSUserDefaults standardUserDefaults]stringForKey:@"RoleCode"];
    NSString *plyRolecode = @"ROL0000002";
    
    if([rolecode isEqualToString:plyRolecode])
    {
        self.viewTeam.hidden = YES;
    }
    else
    {
        self.viewTeam.hidden = NO;
    }
    
    self.CompetitionListtbl.hidden = YES;
    //self.popTableView.hidden = YES;
    self.prevBtn.hidden = YES;
    self.NodataView.hidden = YES;
    
    CompetitionCode = [AppCommon getCurrentCompetitionCode];
    teamcode = [AppCommon getCurrentTeamCode];
    
    
    [self.resultCollectionView registerNib:[UINib nibWithNibName:@"MCOverViewResultCVC" bundle:nil] forCellWithReuseIdentifier:@"mcResultCVC"];
    
   // [_scrollView contentSize ]
   // _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, 3000);

    _scrollView.contentSize = _contentView.frame.size;
//    [self.nextBtn setTag:0];
//    self.prevBtn.hidden = YES;
//    [self.nextBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    competitionlbl.text = @"";
    

}
-(void)viewWillAppear:(BOOL)animated
{
//    if ([competitionlbl.text isEqualToString:@""] ||
//        ![competitionlbl.text isEqualToString:[AppCommon getCurrentCompetitionName]])
//    {
//
//    }
    

    lblCompetetion.text = [AppCommon getCurrentCompetitionName];
    lblTeamName.text = [AppCommon getCurrentTeamName];
    
    [self OverviewWebservice];



-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.headerView addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"Overview";
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
        return recentMatchesArray.count;
    }else{
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if(collectionView == self.resultCollectionView){
        
        
        
        MCOverViewResultCVC* cell = [self.resultCollectionView dequeueReusableCellWithReuseIdentifier:@"mcResultCVC" forIndexPath:indexPath];
        
        cell.Teamname1lbl.text = [[recentMatchesArray valueForKey:@"ATName"] objectAtIndex:indexPath.row];
        cell.Teamname2lbl.text = [[recentMatchesArray valueForKey:@"BTName"] objectAtIndex:indexPath.row];
        
        NSString * team1Score = [NSString stringWithFormat:@"%@/%@",[[recentMatchesArray valueForKey:@"ATMaxInnsTotal"] objectAtIndex:indexPath.row],[[recentMatchesArray valueForKey:@"ATMaxInnsWckts"] objectAtIndex:indexPath.row]];
        cell.runs1lbl.text = team1Score;
        
        NSString * team2Score = [NSString stringWithFormat:@"%@/%@",[[recentMatchesArray valueForKey:@"BTMaxInnsTotal"] objectAtIndex:indexPath.row],[[recentMatchesArray valueForKey:@"BTMaxInnsWckts"] objectAtIndex:indexPath.row]];
        cell.runs2lbl.text = team2Score;
        
        cell.TeamOvers1lbl.text = [[recentMatchesArray valueForKey:@"ATOvers"] objectAtIndex:indexPath.row];
        cell.TeamOver2lbl.text = [[recentMatchesArray valueForKey:@"BTOvers"] objectAtIndex:indexPath.row];
        cell.runrate1lbl.text = [[recentMatchesArray valueForKey:@"ATRR"] objectAtIndex:indexPath.row];
        cell.runrate2lbl.text = [[recentMatchesArray valueForKey:@"BTRR"] objectAtIndex:indexPath.row];
        
        NSString *matchdate = [[recentMatchesArray valueForKey:@"ATMatchDate"] objectAtIndex:indexPath.row];
        NSArray *arr = [matchdate componentsSeparatedByString:@" "];
        cell.Datelbl.text = arr[0];
        
        
        NSString * photourl = [NSString stringWithFormat:@"%@%@",IMAGE_URL,[[recentMatchesArray valueForKey:@"ATPhoto"] objectAtIndex:0]];
        [self downloadImageWithURL:[NSURL URLWithString:photourl] completionBlock:^(BOOL succeeded, UIImage *image) {
            if (succeeded) {
                // change the image in the cell
                cell.team1Img.image = image;
                
                // cache the image for use later (when scrolling up)
                cell.team1Img.image = image;
            }
            else
            {
                cell.team1Img.image = [UIImage imageNamed:@"no-image"];
            }
        }];
        
        
        NSString * photourl2 = [NSString stringWithFormat:@"%@%@",IMAGE_URL,[[recentMatchesArray valueForKey:@"BTPhoto"] objectAtIndex:0]];
        [self downloadImageWithURL:[NSURL URLWithString:photourl2] completionBlock:^(BOOL succeeded, UIImage *image) {
            if (succeeded) {
                // change the image in the cell
                cell.team2Img.image = image;
                
                // cache the image for use later (when scrolling up)
                cell.team2Img.image = image;
            }
            else
            {
                cell.team2Img.image = [UIImage imageNamed:@"no-image"];
            }
        }];
        
        
        return cell;
        
    }
    return nil;
    
}

-(void)OverviewWebservice :(NSString *)compCode :(NSString *)temCode
{
    
    if (![COMMON isInternetReachable]) {
        return;
    }
    
    [AppCommon showLoading ];
    NSLog(@"TEAM CODE %@",appDel.ArrayTeam);
    
    self.competitionlbl.text = [AppCommon getCurrentCompetitionName];
     self.teamlbl.text = [AppCommon getCurrentTeamName];
    
//    NSString *CompetitionCode = [AppCommon getCurrentCompetitionCode];
//    NSString *teamcode = [AppCommon getCurrentTeamCode];
    objWebservice = [[WebService alloc]init];
    
    
    [objWebservice Overview:OverviewKey :compCode : temCode success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        
        NSMutableArray *teamDetailsArray = [[NSMutableArray alloc]init];
        teamDetailsArray = [responseObject valueForKey:@"Overview"];

        if(teamDetailsArray.count >0)
        {
            
                self.Teamnamelbl.text = [[teamDetailsArray valueForKey:@"TeamName"] objectAtIndex:0];
            
                NSString *groundDetails = [NSString stringWithFormat:@"%@,%@",[[teamDetailsArray valueForKey:@"GroundName"] objectAtIndex:0], [[teamDetailsArray valueForKey:@"Venue"] objectAtIndex:0]];
                self.Groundmnamelbl.text = [[teamDetailsArray valueForKey:@"GroundName"] objectAtIndex:0];
                self.Captainnamelbl.text = [NSString stringWithFormat:@"Captain :%@",[[teamDetailsArray valueForKey:@"PlayerName"] objectAtIndex:0]];
            
//                [[teamDetailsArray valueForKey:@"PlayerName"] objectAtIndex:0];
            
            
                NSString * photourl = [NSString stringWithFormat:@"%@%@",IMAGE_URL,[[teamDetailsArray valueForKey:@"TeamPhotoLink"] objectAtIndex:0]];

            [self downloadImageWithURL:[NSURL URLWithString:photourl] completionBlock:^(BOOL succeeded, UIImage *image) {
                if (succeeded) {
                    // change the image in the cell
                    self.TeamImgView.image = image;
                    
                    // cache the image for use later (when scrolling up)
                    self.TeamImgView.image = image;
                }
                else
                {
                    self.TeamImgView.image = [UIImage imageNamed:@"no-image"];
                }
            }];
            
            
            recentMatchesArray = [[NSMutableArray alloc]init];
            recentMatchesArray = [responseObject valueForKey:@"OvBatRecentmatch"];
            
            resultsArray = [[NSMutableArray alloc]init];
            resultsArray = [responseObject valueForKey:@"OvATResults"];
            
            self.TotalMatcheslbl.text = [resultsArray valueForKey:@"ATMatches"] ;
            
            self.winLosslbl.text = [resultsArray valueForKey:@"ATWinper"];
            NSString *wincount = [NSString stringWithFormat:@"%@/%@",[resultsArray valueForKey:@"ATWon"],[resultsArray valueForKey:@"ATMatches"]];
            self.winLossCountlbl.text =wincount;
            
            self.Forlbl.text =[resultsArray valueForKey:@"For"];
            NSString *forcount = [NSString stringWithFormat:@"%@/%@",[resultsArray valueForKey:@"ATRuns"],[resultsArray valueForKey:@"ATOvers"]];
            self.ForCountlbl.text =forcount;
            
            
            self.Againstlbl.text = [resultsArray valueForKey:@"Against"];
            NSString *Againstcount = [NSString stringWithFormat:@"%@/%@",[resultsArray valueForKey:@"BTRuns"],[resultsArray valueForKey:@"BTOvers"]];
            self.AgainstCountlbl.text =Againstcount;
            
            self.nrrlbl.text = [resultsArray valueForKey:@"NetRR"];
            
            NSString *wkts = [NSString stringWithFormat:@"%@/%@",[resultsArray valueForKey:@"BTWcktsTkn"],[resultsArray valueForKey:@"ATWcktsGvn"]];
            self.Wktslbl.text = wkts;
            
            BatsmenArray = [[NSMutableArray alloc]init];
            BatsmenArray = [responseObject valueForKey:@"BatsmenOV"];
            
            BowlersArray = [[NSMutableArray alloc]init];
            BowlersArray = [responseObject valueForKey:@"BowlersOV"];
            
            FieldersArray = [[NSMutableArray alloc]init];
            FieldersArray = [responseObject valueForKey:@"FieldOV"];
            
            [self.resultCollectionView reloadData];
            
            [self.nextBtn setTag:0];
            self.prevBtn.hidden = NO;
            self.prevBtn.hidden = YES;
            [self.nextBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
            
           
        }
        [AppCommon hideLoading];
        
    }
                         failure:^(AFHTTPRequestOperation *operation, id error) {
                             NSLog(@"failed");
                             [COMMON webServiceFailureError:error];
                         }];
    
}


- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}


- (IBAction)onClickNextBtn:(id)sender
{
    self.NodataView.hidden = YES;
    if(self.nextBtn.tag==0)
    {
        self.PlayerTypelbl.text = @"Top Batsmens";
        self.prevBtn.hidden = YES;
        [self.nextBtn setTag:1];
        CommonArray =[[NSMutableArray alloc]init];
        CommonArray = BatsmenArray;
        if(CommonArray.count>0)
        {
            self.NodataView.hidden = YES;
            [self SetValuesOfTopPlayers:CommonArray];
            
        }
        else
        {
            self.NodataView.hidden = NO;
        }
    }
    else if(self.nextBtn.tag==1)
    {
        self.prevBtn.hidden = NO;
        self.PlayerTypelbl.text = @"Top Bowlers";
        [self.nextBtn setTag:2];
        [self.prevBtn setTag:1];
        
        CommonArray =[[NSMutableArray alloc]init];
        CommonArray = BowlersArray;
        if(CommonArray.count>0)
        {
            self.NodataView.hidden = YES;
            [self SetValuesOfTopPlayers:CommonArray];
            
        }
        else
        {
            self.NodataView.hidden = NO;
        }
    }
    else if(self.nextBtn.tag==2)
    {
        self.NodataView.hidden = YES;
        self.PlayerTypelbl.text = @"Top Fielders";
        self.nextBtn.hidden = YES;
        [self.prevBtn setTag:2];
        
        CommonArray =[[NSMutableArray alloc]init];
        CommonArray = FieldersArray;
        if(CommonArray.count>0)
        {
            self.NodataView.hidden = YES;
            [self SetValuesOfTopPlayers:CommonArray];
        }
        else
        {
            self.NodataView.hidden = NO;
        }
    }
    
    
    
}


- (IBAction)onClickMoreMatches:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    objresult = (ResultsVc *)[storyboard instantiateViewControllerWithIdentifier:@"ResultsVc"];
    //[self.navigationController pushViewController:objFix animated:YES];
    [appDel.frontNavigationController pushViewController:objresult animated:YES];
    
}




- (IBAction)onClickCompetitionBtn:(id)sender
{
    isComp = YES;
    isTeam = NO;
    self.CompetitionListtbl.hidden = NO;
    
    self.tableWidth.constant = self.competView.frame.size.width;
    self.tableXposition.constant = self.competView.frame.origin.x;
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    arr = appDel.ArrayCompetition;
    [self.CompetitionListtbl reloadData];
    
}

- (IBAction)onClickTeamBtn:(id)sender
{
    isComp = NO;
    isTeam = YES;
    self.CompetitionListtbl.hidden = NO;
    self.tableWidth.constant = self.teamView.frame.size.width;
    self.tableXposition.constant = self.teamView.frame.origin.x;
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    arr = appDel.ArrayTeam;
    
    [self.CompetitionListtbl reloadData];
    
}

- (IBAction)onClickPrevBtn:(id)sender
{
   if(self.prevBtn.tag==1)
   {
       self.NodataView.hidden = YES;
       self.PlayerTypelbl.text = @"Top Batsmens";
       self.prevBtn.hidden = YES;
       [self.nextBtn setTag:1];
       
       CommonArray =[[NSMutableArray alloc]init];
       CommonArray = BatsmenArray;
       if(CommonArray.count>0)
       {
           self.NodataView.hidden = YES;
           [self SetValuesOfTopPlayers:CommonArray];
           
       }
       else
       {
           self.NodataView.hidden = NO;
       }
   }
   else if(self.prevBtn.tag==2)
   {
       self.NodataView.hidden = YES;
       self.PlayerTypelbl.text = @"Top Bowlers";
       [self.nextBtn setTag:2];
       [self.prevBtn setTag:1];
       self.nextBtn.hidden = NO;
       
       CommonArray =[[NSMutableArray alloc]init];
       CommonArray = BowlersArray;
       if(CommonArray.count>0)
       {
           self.NodataView.hidden = YES;
           [self SetValuesOfTopPlayers:CommonArray];
           
       }
       else
       {
           self.NodataView.hidden = NO;
       }
   }
   
}

-(void)SetValuesOfTopPlayers :(NSMutableArray *)ReqArray
{
   if([self.PlayerTypelbl.text isEqualToString:@"Top Batsmens"])
   {
    self.Player1Namelbl.text = [[ReqArray valueForKey:@"PlayerName"] objectAtIndex:0];
    self.Player2Namelbl.text = [[ReqArray valueForKey:@"PlayerName"] objectAtIndex:1];
    self.Player3Namelbl.text = [[ReqArray valueForKey:@"PlayerName"] objectAtIndex:2];
    self.Player4Namelbl.text = [[ReqArray valueForKey:@"PlayerName"] objectAtIndex:3];
    self.Player5Namelbl.text = [[ReqArray valueForKey:@"PlayerName"] objectAtIndex:4];
    
    self.Player1Countlbl.text = [[ReqArray valueForKey:@"Runs"] objectAtIndex:0];
    self.Player2Countlbl.text = [[ReqArray valueForKey:@"Runs"] objectAtIndex:1];
    self.Player3Countlbl.text = [[ReqArray valueForKey:@"Runs"] objectAtIndex:2];
    self.Player4Countlbl.text = [[ReqArray valueForKey:@"Runs"] objectAtIndex:3];
    self.Player5Countlbl.text = [[ReqArray valueForKey:@"Runs"] objectAtIndex:4];
    
    self.Player1SRlbl.text = [[ReqArray valueForKey:@"SR"] objectAtIndex:0];
    self.Player2SRlbl.text = [[ReqArray valueForKey:@"SR"] objectAtIndex:1];
    self.Player3SRlbl.text = [[ReqArray valueForKey:@"SR"] objectAtIndex:2];
    self.Player4SRlbl.text = [[ReqArray valueForKey:@"SR"] objectAtIndex:3];
    self.Player5SRlbl.text = [[ReqArray valueForKey:@"SR"] objectAtIndex:4];
       
       
      
       
       
   }
   else if([self.PlayerTypelbl.text isEqualToString:@"Top Bowlers"])
   {
       self.Player1Namelbl.text = [[ReqArray valueForKey:@"PlayerName"] objectAtIndex:0];
       self.Player2Namelbl.text = [[ReqArray valueForKey:@"PlayerName"] objectAtIndex:1];
       self.Player3Namelbl.text = [[ReqArray valueForKey:@"PlayerName"] objectAtIndex:2];
       self.Player4Namelbl.text = [[ReqArray valueForKey:@"PlayerName"] objectAtIndex:3];
       self.Player5Namelbl.text = [[ReqArray valueForKey:@"PlayerName"] objectAtIndex:4];
       
       self.Player1Countlbl.text = [[ReqArray valueForKey:@"Wickets"] objectAtIndex:0];
       self.Player2Countlbl.text = [[ReqArray valueForKey:@"Wickets"] objectAtIndex:1];
       self.Player3Countlbl.text = [[ReqArray valueForKey:@"Wickets"] objectAtIndex:2];
       self.Player4Countlbl.text = [[ReqArray valueForKey:@"Wickets"] objectAtIndex:3];
       self.Player5Countlbl.text = [[ReqArray valueForKey:@"Wickets"] objectAtIndex:4];
       
       self.Player1SRlbl.text = [[ReqArray valueForKey:@"SR"] objectAtIndex:0];
       self.Player2SRlbl.text = [[ReqArray valueForKey:@"SR"] objectAtIndex:1];
       self.Player3SRlbl.text = [[ReqArray valueForKey:@"SR"] objectAtIndex:2];
       self.Player4SRlbl.text = [[ReqArray valueForKey:@"SR"] objectAtIndex:3];
       self.Player5SRlbl.text = [[ReqArray valueForKey:@"SR"] objectAtIndex:4];
   }
   else if([self.PlayerTypelbl.text isEqualToString:@"Top Fielders"])
   {
       self.Player1Namelbl.text = [[ReqArray valueForKey:@"PlayerName"] objectAtIndex:0];
       self.Player2Namelbl.text = [[ReqArray valueForKey:@"PlayerName"] objectAtIndex:1];
       self.Player3Namelbl.text = [[ReqArray valueForKey:@"PlayerName"] objectAtIndex:2];
       self.Player4Namelbl.text = [[ReqArray valueForKey:@"PlayerName"] objectAtIndex:3];
       self.Player5Namelbl.text = [[ReqArray valueForKey:@"PlayerName"] objectAtIndex:4];
       
       self.Player1Countlbl.text = [[ReqArray valueForKey:@"Wickets"] objectAtIndex:0];
       self.Player2Countlbl.text = [[ReqArray valueForKey:@"Wickets"] objectAtIndex:1];
       self.Player3Countlbl.text = [[ReqArray valueForKey:@"Wickets"] objectAtIndex:2];
       self.Player4Countlbl.text = [[ReqArray valueForKey:@"Wickets"] objectAtIndex:3];
       self.Player5Countlbl.text = [[ReqArray valueForKey:@"Wickets"] objectAtIndex:4];
       
       self.Player1SRlbl.text = [[ReqArray valueForKey:@"SR"] objectAtIndex:0];
       self.Player2SRlbl.text = [[ReqArray valueForKey:@"SR"] objectAtIndex:1];
       self.Player3SRlbl.text = [[ReqArray valueForKey:@"SR"] objectAtIndex:2];
       self.Player4SRlbl.text = [[ReqArray valueForKey:@"SR"] objectAtIndex:3];
       self.Player5SRlbl.text = [[ReqArray valueForKey:@"SR"] objectAtIndex:4];
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
    
    
    if(isComp==YES)
    {
        return appDel.ArrayCompetition.count;
    }
    else if(isTeam==YES)
    {
        return appDel.ArrayTeam.count;
    }
    return nil;
    
}
// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *MyIdentifier = @"cellid";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MyIdentifier];
    }
    
    if(isComp ==YES)
    {
        cell.textLabel.text = [[appDel.ArrayCompetition valueForKey:@"CompetitionName"]objectAtIndex:indexPath.row];
    }
    else if(isTeam == YES)
    {
        cell.textLabel.text = [[appDel.ArrayTeam objectAtIndex:indexPath.row] valueForKey:@"TeamName"];
        
    }
    

    
    cell.selectionStyle = UIAccessibilityTraitNone;
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(isComp == YES)
    {
        //        cell..text = [[appDel.ArrayCompetition valueForKey:@"CompetitionName"]objectAtIndex:indexPath.row];
        
        self.competitionlbl.text = [[appDel.ArrayCompetition objectAtIndex:indexPath.row] valueForKey:@"CompetetionName"];
       CompetitionCode = [[appDel.ArrayCompetition objectAtIndex:indexPath.row] valueForKey:@"CompetitionCode"];
        
        [[NSUserDefaults standardUserDefaults] setValue:self.competitionlbl.text forKey:@"SelectedCompetitionName"];
        [[NSUserDefaults standardUserDefaults] setValue:CompetitionCode forKey:@"SelectedCompetitionCode"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else if(isTeam == YES)
    {
        lblTeamName.text = [[array objectAtIndex:Index.row] valueForKey:key];
        NSString* Teamcode = [[array objectAtIndex:Index.row] valueForKey:@"TeamCode"];
        
        self.teamlbl.text = [[appDel.ArrayTeam objectAtIndex:indexPath.row] valueForKey:@"TeamName"];
        teamcode = [[appDel.ArrayTeam objectAtIndex:indexPath.row] valueForKey:@"TeamCode"];
        [[NSUserDefaults standardUserDefaults] setValue:self.teamlbl.text forKey:@"SelectedTeamName"];
        [[NSUserDefaults standardUserDefaults] setValue:teamcode forKey:@"SelectedTeamCode"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
    //isComp = NO;
   // isTeam = NO;
    self.CompetitionListtbl.hidden = YES;
    
    [self OverviewWebservice:CompetitionCode:teamcode];
    
}




@end
