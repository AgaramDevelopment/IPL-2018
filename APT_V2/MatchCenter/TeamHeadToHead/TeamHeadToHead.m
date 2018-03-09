//
//  TeamHeadToHead.m
//  APT_V2
//
//  Created by Apple on 28/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "TeamHeadToHead.h"
#import "CustomNavigation.h"
#import "SWRevealViewController.h"
#import "Config.h"
#import "WebService.h"
#import "AppCommon.h"


@interface TeamHeadToHead ()
{
    BOOL isteam1;
    BOOL isteam2;
    BOOL isGround;
    BOOL isCompetition;
    
    NSString *team1Code;
    NSString *team2Code;
    NSString *groundCode;
    NSString *competitionCode;
    
    NSString *team1InnsNum, *team2InnsNum, *tossWonTeamCode, *fromOver, *toOver;
    NSString *teamName, *competitionName;
}
@property (nonatomic, strong) IBOutlet NSMutableArray *commonArray;
@property (nonatomic, strong) IBOutlet NSMutableArray *commonArray1;
//@property (nonatomic, strong) IBOutlet NSMutableArray *h2hResultsArray;
@property (nonatomic, strong)IBOutlet  NSLayoutConstraint *tableWidth;
@property (nonatomic, strong)IBOutlet  NSLayoutConstraint *tableXposition;
@property (nonatomic, strong)IBOutlet  NSLayoutConstraint *tableYposition;

@end

@implementation TeamHeadToHead

- (void)viewDidLoad {
    [super viewDidLoad];
    
    groundCode = @"";
    team1InnsNum = @"" ;
    team2InnsNum = @"";
    tossWonTeamCode = @"";
    fromOver = @"";
    toOver = @"";
    
    team1Code = [AppCommon getCurrentTeamCode];
    teamName = [AppCommon getCurrentTeamName];
    competitionCode = [AppCommon getCurrentCompetitionCode];
    competitionName = [AppCommon getCurrentCompetitionName];

    self.team1TF.text = teamName;
    self.competitionTF.text = competitionName;
    
    self.Poptable.hidden = YES;
    [self customnavigationmethod];
    [self setBorderForButtons];
    [self headToHeadPageLoadGetService];
}

-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.headerView addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"Head To Head";
    objCustomNavigation.btn_back.hidden = YES;
    objCustomNavigation.home_btn.hidden = YES;
    objCustomNavigation.menu_btn.hidden =NO;
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    [objCustomNavigation.menu_btn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setBorderForButtons {
    self.firstInn.layer.borderWidth = 1.0f;
    self.firstInn.layer.borderColor = [UIColor blackColor].CGColor;
    self.firstInn.layer.cornerRadius = 2.0f;
    
    self.secondInn.layer.borderWidth = 1.0f;
    self.secondInn.layer.borderColor = [UIColor blackColor].CGColor;
    self.secondInn.layer.cornerRadius = 2.0f;
    
    self.team1win.layer.borderWidth = 1.0f;
    self.team1win.layer.borderColor = [UIColor blackColor].CGColor;
    self.team1win.layer.cornerRadius = 2.0f;
    
    self.team2win.layer.borderWidth = 1.0f;
    self.team2win.layer.borderColor = [UIColor blackColor].CGColor;
    self.team2win.layer.cornerRadius = 2.0f;
    
    self.spell1Inn.layer.borderWidth = 1.0f;
    self.spell1Inn.layer.borderColor = [UIColor blackColor].CGColor;
    self.spell1Inn.layer.cornerRadius = 2.0f;
    
    self.spell2Inn.layer.borderWidth = 1.0f;
    self.spell2Inn.layer.borderColor = [UIColor blackColor].CGColor;
    self.spell2Inn.layer.cornerRadius = 2.0f;
    
    self.spell3Inn.layer.borderWidth = 1.0f;
    self.spell3Inn.layer.borderColor = [UIColor blackColor].CGColor;
    self.spell3Inn.layer.cornerRadius = 2.0f;
}

- (IBAction)GroundBtnAction:(id)sender
{
    isteam1 = NO;
    isteam2 = NO;
    isGround = YES;
    isCompetition = NO;
    self.Poptable.hidden = NO;
    self.commonArray = [NSMutableArray new];
    self.commonArray = self.commonArray1;
    self.tableWidth.constant = self.groundView.frame.size.width;
    self.tableXposition.constant = self.groundView.frame.origin.x+5;
    self.tableYposition.constant = self.groundView.frame.origin.y+self.groundView.frame.size.height+20;
    //Re-load Table View
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.Poptable reloadData];
    });
}

- (IBAction)CompetitionBtnAction:(id)sender {
    isteam1 = NO;
    isteam2 = NO;
    isGround = NO;
    isCompetition = YES;
    self.Poptable.hidden = NO;
    self.commonArray = [NSMutableArray new];
    NSLog(@"%@", appDel.ArrayCompetition);
    self.commonArray = appDel.ArrayCompetition;
    self.tableWidth.constant = self.competitionView.frame.size.width;
    self.tableXposition.constant = self.competitionView.frame.origin.x+5;
    self.tableYposition.constant = self.competitionView.frame.origin.y+self.competitionView.frame.size.height+20;
        //Re-load Table View
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.Poptable reloadData];
    });
}


- (IBAction)Team1BtnAction:(id)sender
{
    isteam1 = YES;
    isteam2 = NO;
    isGround = NO;
    isCompetition = NO;
    self.Poptable.hidden = NO;
    
    self.commonArray = [NSMutableArray new];
    self.commonArray = self.commonArray1;
    self.tableWidth.constant = self.team1View.frame.size.width;
    self.tableXposition.constant = self.team1View.frame.origin.x+5;
    self.tableYposition.constant = self.team1View.frame.origin.y+5;
        //Re-load Table View
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.Poptable reloadData];
    });
}

- (IBAction)Team2BtnAction:(id)sender {
    isteam1 = NO;
    isteam2 = YES;
    isGround = NO;
    isCompetition = NO;
    
    self.Poptable.hidden = NO;
    self.commonArray = [NSMutableArray new];
    self.commonArray = self.commonArray1;
    self.tableWidth.constant = self.team2View.frame.size.width;
    self.tableXposition.constant = self.InsideTeam2View.frame.origin.x+self.team2View.frame.origin.x;
    self.tableYposition.constant = self.InsideTeam2View.frame.origin.y+5;
        //Re-load Table View
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.Poptable reloadData];
    });
}
- (IBAction)firstInningsAction:(id)sender {
    team1InnsNum = @"1";
    [self headToHeadResultsPostService];
}
- (IBAction)secondInningsAction:(id)sender {
    team2InnsNum = @"2";
    [self headToHeadResultsPostService];
}

- (IBAction)CSKWinAction:(id)sender {
    tossWonTeamCode = @"TEA0000010";
    [self headToHeadResultsPostService];
}
- (IBAction)MIWinAction:(id)sender {
    tossWonTeamCode = @"TEA0000008";
    [self headToHeadResultsPostService];
}
- (IBAction)oneToSixOversAction:(id)sender {
    fromOver = @"0";
    toOver = @"5";
    [self headToHeadResultsPostService];
}
- (IBAction)sevenToFifteenOversAction:(id)sender {
    fromOver = @"6";
    toOver = @"14";
    [self headToHeadResultsPostService];
}
- (IBAction)sixteenToTwentyOversAction:(id)sender {
    fromOver = @"15";
    toOver = @"19";
    [self headToHeadResultsPostService];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.commonArray.count;
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
    
    cell.textLabel.numberOfLines = 2;
    [cell.textLabel setAdjustsFontSizeToFitWidth:YES];
    
    if(isteam1 == YES) {
        cell.textLabel.text = [[self.commonArray objectAtIndex:indexPath.row] valueForKey:@"TeamBName"];
    }
    
     if(isteam2 == YES) {
        cell.textLabel.text = [[self.commonArray objectAtIndex:indexPath.row] valueForKey:@"TeamBName"];
    }
    
    if(isCompetition == YES) {
        cell.textLabel.text = [[self.commonArray objectAtIndex:indexPath.row] valueForKey:@"CompetitionName"];
    }
  
    if(isGround == YES) {
        cell.textLabel.text = [[self.commonArray objectAtIndex:indexPath.row] valueForKey:@"Ground"];
    }
    
    cell.selectionStyle = UIAccessibilityTraitNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(isteam1==YES)
    {
        self.team1TF.text = [[self.commonArray objectAtIndex:indexPath.row] valueForKey:@"TeamBName"];
        team1Code = [[self.commonArray objectAtIndex:indexPath.row] valueForKey:@"TeamBcode"];
    
    if ([self.team1TF.text isEqualToString:self.team2TF.text]) {
        [self altermsg:@"Please Select different Team for Team-A"];
        self.team1TF.text = @"";
        team1Code = @"";
    }
        self.Poptable.hidden = YES;
    }
    
    if(isteam2==YES)
    {
        self.team2TF.text = [[self.commonArray objectAtIndex:indexPath.row] valueForKey:@"TeamBName"];
        team2Code = [[self.commonArray objectAtIndex:indexPath.row] valueForKey:@"TeamBcode"];
    
    if ([self.team1TF.text isEqualToString:self.team2TF.text]) {
        [self altermsg:@"Please Select different Team for Team-B"];
        self.team2TF.text = @"";
        team2Code = @"";
    }
    
         self.Poptable.hidden = YES;
    }
    
    if(isCompetition == YES)
    {
        self.competitionTF.text = [[self.commonArray objectAtIndex:indexPath.row] valueForKey:@"CompetitionName"];
    competitionCode = [[self.commonArray objectAtIndex:indexPath.row] valueForKey:@"CompetitionCode"];
        self.Poptable.hidden = YES;
    
//    [[NSUserDefaults standardUserDefaults] setValue:self.competitionTF.text forKey:@"SelectedCompetitionName"];
//    [[NSUserDefaults standardUserDefaults] setValue:competitionCode forKey:@"SelectedCompetitionCode"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    if(isGround==YES)
    {
        self.groundTF.text = [[self.commonArray objectAtIndex:indexPath.row] valueForKey:@"Ground"];
        groundCode = [[self.commonArray objectAtIndex:indexPath.row] valueForKey:@"Groundcode"];
        self.Poptable.hidden = YES;
        [self checkValidations];
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewAutomaticDimension;
//}

- (void)headToHeadPageLoadGetService {
    /*
     API URL    :   http://192.168.0.151:8044/AGAPTService.svc/FETCH_SCORECARD_PITCHMAP/
     METHOD     :   GET
     PARAMETER  :   {PLAYERCODE}/{MATCHCODE}/{INNGS}
     */
    
    if(![COMMON isInternetReachable])
        return;
    
    [AppCommon showLoading];
    
    NSString *API_URL = [NSString stringWithFormat:@"%@/%@/%@",URL_FOR_RESOURCE(@""),HTHPageLoad, @"TEA0000001"];
    
//     NSString *API_URL = [NSString stringWithFormat:@"%@/%@/%@",URL_FOR_RESOURCE(@""),HTHPageLoad, @"TEA0000001"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = requestSerializer;
    
    [manager GET:API_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"SUCCESS RESPONSE:%@",responseObject);
        self.commonArray1 = [[NSMutableArray alloc] init];
        self.commonArray1 = responseObject;
        [AppCommon hideLoading];
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"FAILURE RESPONSE %@",error.description);
        [COMMON webServiceFailureError:error];
    }];
}

- (void)checkValidations {
    
    if ([self.team1TF.text isEqualToString:@""]) {
        [self altermsg:@"Please Select Team1"];
    } else if ([self.team2TF.text isEqualToString:@""]) {
        [self altermsg:@"Please Select Team2"];
    } else if ([self.competitionTF.text isEqualToString:@""]) {
        [self altermsg:@"Please Select Competition"];
    }
 /*   else if ([self.groundTF.text isEqualToString:@""])
    {
        [self altermsg:@"Please Select Ground"];
    } */
    else {
//        [self headToHeadResultsGetService];
         [self headToHeadResultsPostService];
    }
}

- (void)headToHeadResultsPostService {
    
    if(![COMMON isInternetReachable])
        return;
    
    [AppCommon showLoading];
    
    NSString *URLString =  URL_FOR_RESOURCE(HTHResults);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.requestSerializer = requestSerializer;
    
    /*
     http://localhost:58774/AGAPTService.svc/APT_HTHRESULTS
     {"CompetitionCode":"UCC0000008",
     "TeamACode":"TEA0000008",
     "TeamBCode":"TEA0000010",
     "GroundCode":"",
     "ATInnsNum":"",
     "BTInnsNum":"",
     "TossWonTeamCode":"TEA0000010",
     "FromOver":"0",
     "ToOver":"19"
     }
     */
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic    setObject:competitionCode     forKey:@"CompetitionCode"];
    [dic    setObject:team1Code     forKey:@"TeamACode"];
    [dic    setObject:team2Code     forKey:@"TeamBCode"];
    [dic    setObject:groundCode     forKey:@"GroundCode"];
    [dic    setObject:team1InnsNum     forKey:@"ATInnsNum"];
    [dic    setObject:team2InnsNum     forKey:@"BTInnsNum"];
    [dic    setObject:tossWonTeamCode     forKey:@"TossWonTeamCode"];
    [dic    setObject:fromOver     forKey:@"FromOver"];
    [dic    setObject:toOver     forKey:@"ToOver"];
    
    NSLog(@"parameters : %@",dic);
    [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response ; %@",responseObject);
            
            NSLog(@"SUCCESS RESPONSE:%@",responseObject);
            NSMutableDictionary *h2hResultsDict = [[NSMutableDictionary alloc] init];
            h2hResultsDict = responseObject;
            [self assignH2HResultsArrayValuesToView:h2hResultsDict];
        
        [AppCommon hideLoading];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed");
        [COMMON webServiceFailureError:error];
        [AppCommon hideLoading];
        
    }];
    
}
- (void)headToHeadResultsGetService {
    /*
     API URL    :   http://192.168.0.151:8044/AGAPTService.svc/FETCH_SCORECARD_PITCHMAP/
     METHOD     :   GET
     PARAMETER  :   {PLAYERCODE}/{MATCHCODE}/{INNGS}
     */
    
    /*
     http://localhost:58774/AGAPTService.svc/APT_HTHRESULTS
     {"CompetitionCode":"UCC0000008",
     "TeamACode":"TEA0000008",
     "TeamBCode":"TEA0000010",
     "GroundCode":"",
     "ATInnsNum":"",
     "BTInnsNum":"",
     "TossWonTeamCode":"TEA0000010",
     "FromOver":"0",
     "ToOver":"19"
     }
     */
    if(![COMMON isInternetReachable])
        return;
    
    [AppCommon showLoading];
    
    NSString *API_URL = [NSString stringWithFormat:@"%@/%@/%@/%@/%@/%@",URL_FOR_RESOURCE(@""),HTHResults, competitionCode, team1Code, team2Code, groundCode];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = requestSerializer;
    
    [manager GET:API_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"SUCCESS RESPONSE:%@",responseObject);
        NSMutableDictionary *h2hResultsDict = [[NSMutableDictionary alloc] init];
        h2hResultsDict = responseObject;
        [self assignH2HResultsArrayValuesToView:h2hResultsDict];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"FAILURE RESPONSE %@",error.description);
        [COMMON webServiceFailureError:error];
    }];
}

- (void)assignH2HResultsArrayValuesToView:(NSMutableDictionary *)h2hResultsDict {
    
    //Matches Win/Loss
    NSMutableArray *matchResultsArray = [h2hResultsDict valueForKey:@"Matchresults"];
    NSLog(@"matchResultsDict:%@", matchResultsArray);
    for (id key in matchResultsArray) {
        //Team-1
        self.playedT1Lbl.text = [self checkNSNumber:[key valueForKey:@"TeamA"]];
        self.playedT1PV.progress = 1 - [self.playedT1Lbl.text floatValue]/100;
        
        self.homeT1Lbl.text = [self checkNSNumber:[key valueForKey:@"HomeAT"]];
        self.homeT1PV.progress = 1 - [self.homeT1Lbl.text floatValue]/100;
        
        self.awayT1Lbl.text = [self checkNSNumber:[key valueForKey:@"AwayAT"]];
        self.awayT1PV.progress = 1 - [self.awayT1Lbl.text floatValue]/100;
        
        self.playOffsT1Lbl.text = [self checkNSNumber:[key valueForKey:@"PlayOffAT"]];
        self.playOffsT1PV.progress = 1 - [self.playOffsT1Lbl.text floatValue]/100;
        
        //Team-2
        self.playedT2Lbl.text = [self checkNSNumber:[key valueForKey:@"TeamB"]];
        self.playedT2PV.progress = [self.playedT2Lbl.text floatValue]/100;
        
        self.homeT2Lbl.text = [self checkNSNumber:[key valueForKey:@"HomeBT"]];
        self.homeT2PV.progress = [self.homeT2Lbl.text floatValue]/100;
        
        self.awayT2Lbl.text = [self checkNSNumber:[key valueForKey:@"AwayBT"]];
        self.awayT2PV.progress = [self.awayT2Lbl.text floatValue]/100;
        
        self.playOffsT2Lbl.text = [self checkNSNumber:[key valueForKey:@"PlayOffBT"]];
        self.playOffsT2PV.progress = [self.playOffsT2Lbl.text floatValue]/100;
    }
    
    //Team1 & Team2 Score Card and Progress View
    NSMutableArray *teamWideResultArray = [h2hResultsDict valueForKey:@"Teamwideresult"];
    NSLog(@"teamWideResultDict:%@", teamWideResultArray);
    for (id key in teamWideResultArray) {
        //Team1
        self.avgRunsT1Lbl.text = [self checkNull:[key valueForKey:@"AAvgRuns"]];
        self.avgWicketsT1Lbl.text = [self checkNull:[key valueForKey:@"AAvgwkts"]];
        self.avgRunsOrWicketsT1Lbl.text = [self checkNull:[key valueForKey:@"AAVGRW"]];
        self.highScoreT1Lbl.text = [self checkNull:[key valueForKey:@"ATHighscore"]];
        self.lowScoreT1Lbl.text = [self checkNull:[key valueForKey:@"ATLowscore"]];
        
        //Team1 Progress View
        self.runsScoredT1Lbl.text = [self checkNSNumber:[key valueForKey:@"ATRuns"]];
        self.runsScoredT1PV.progress = 1 - [self.runsScoredT1Lbl.text floatValue]/100;
        
        self.runsPerOverT1Lbl.text = [self checkNSNumber:[key valueForKey:@"ATOvers"]];
        self.runsPerOverT1PV.progress = 1 - [self.runsPerOverT1Lbl.text floatValue]/100;
        
        self.wicketsLostT1Lbl.text = [self checkNSNumber:[key valueForKey:@"ATWkts"]];
        self.wicketsLostT1PV.progress = 1 - [self.wicketsLostT1Lbl.text floatValue]/100;
        
        self.battingSRT1Lbl.text = [self checkNSNumber:[key valueForKey:@"ATBATSR"]];
        self.battingSRT1PV.progress = 1 - [self.battingSRT1Lbl.text floatValue]/100;
        
        self.dotBallPercentT1Lbl.text = [self checkNSNumber:[key valueForKey:@"ADotBall"]];
        self.dotBallPercentT1PV.progress = 1 - [self.dotBallPercentT1Lbl.text floatValue]/100;
        
        self.boundariesPercentT1Lbl.text = [self checkNSNumber:[key valueForKey:@"ATBound"]];
        self.boundariesPercentT1PV.progress = 1 - [self.dotBallPercentT1Lbl.text floatValue]/100;
        
        self.bowlingSRT1Lbl.text = [self checkNSNumber:[key valueForKey:@"ABowlingSR"]];
        self.bowlingSRT1PV.progress = 1 - [self.bowlingSRT1Lbl.text floatValue]/100;
        
        self.bowlingAvgT1Lbl.text = [self checkNSNumber:[key valueForKey:@""]];
        self.bowlingAvgT1PV.progress = 1 - [self.bowlingAvgT1Lbl.text floatValue]/100;
        
        //Team2
        self.avgRunsT2Lbl.text = [self checkNull:[key valueForKey:@"BAvgRuns"]];
        self.avgWicketsT2Lbl.text = [self checkNull:[key valueForKey:@"BAvgwkts"]];
        self.avgRunsOrWicketsT1Lbl.text = [self checkNull:[key valueForKey:@"BAVGRW"]];
        self.highScoreT2Lbl.text = [self checkNull:[key valueForKey:@"BTHighscore"]];
        self.lowScoreT2Lbl.text = [self checkNull:[key valueForKey:@"BTLowscore"]];
        
        //Team2 Progress View
        self.runsScoredT2Lbl.text = [self checkNSNumber:[key valueForKey:@"BTRuns"]];
        self.runsScoredT2PV.progress = [self.runsScoredT2Lbl.text floatValue]/100;
        
        self.runsPerOverT2Lbl.text = [self checkNSNumber:[key valueForKey:@"BTOvers"]];
        self.runsPerOverT2PV.progress = [self.runsPerOverT2Lbl.text floatValue]/100;
        
        self.wicketsLostT2Lbl.text = [self checkNSNumber:[key valueForKey:@"BTWkts"]];
        self.wicketsLostT2PV.progress = [self.wicketsLostT2Lbl.text floatValue]/100;
        
        self.battingSRT2Lbl.text = [self checkNSNumber:[key valueForKey:@"BTBATSR"]];
        self.battingSRT2PV.progress = [self.battingSRT2Lbl.text floatValue]/100;
        
        self.dotBallPercentT2Lbl.text = [self checkNSNumber:[key valueForKey:@"BDotBall"]];
        self.dotBallPercentT2PV.progress = [self.dotBallPercentT2Lbl.text floatValue]/100;
        
        self.boundariesPercentT2Lbl.text = [self checkNSNumber:[key valueForKey:@"BTBound"]];
        self.boundariesPercentT2PV.progress = [self.dotBallPercentT2Lbl.text floatValue]/100;
        
        self.bowlingSRT2Lbl.text = [self checkNSNumber:[key valueForKey:@"BBowlingSR"]];
        self.bowlingSRT2PV.progress = [self.bowlingSRT2Lbl.text floatValue]/100;
        
        self.bowlingAvgT2Lbl.text = [self checkNSNumber:[key valueForKey:@""]];
        self.bowlingAvgT2PV.progress = [self.bowlingAvgT2Lbl.text floatValue]/100;
    }
    
    //Toss Decision
    NSMutableArray *tossResultsArray = [h2hResultsDict valueForKey:@"Tossresults"];
    NSLog(@"tossResults:%@", tossResultsArray);
    //Team-1
    for (id key in tossResultsArray) {
        self.tossWonT1Lbl.text = [self checkNSNumber:[key valueForKey:@"TosswonTeamA"]];
        self.tossWonT1PV.progress = 1 - [self.tossWonT1Lbl.text floatValue]/100;
        
        self.decisionBatT1Lbl.text = [self checkNSNumber:[key valueForKey:@"DecisionBattingA"]];
        self.decisionBatT1PV.progress = 1 - [self.decisionBatT1Lbl.text floatValue]/100;
        
        self.decisionBowlT1Lbl.text = [self checkNSNumber:[key valueForKey:@"DecisionBowlingA"]];
        self.decisionBowlT1PV.progress = 1 - [self.decisionBowlT1Lbl.text floatValue]/100;
        
        self.battingFirstInnWinT1Lbl.text = [self checkNSNumber:[key valueForKey:@"BatFirstInnsTeamA"]];
        self.battingFirstInnWinT1PV.progress = 1 - [self.battingFirstInnWinT1Lbl.text floatValue]/100;
        
        self.battingSecondInnWinT1Lbl.text = [self checkNSNumber:[key valueForKey:@"BatSecondInnsTeamA"]];
        self.battingSecondInnWinT1PV.progress = 1 - [self.battingSecondInnWinT1Lbl.text floatValue]/100;
        
        //Team-2
        self.tossWonT2Lbl.text = [self checkNSNumber:[key valueForKey:@"TosswonTeamB"]];
        self.tossWonT2PV.progress = [self.tossWonT2Lbl.text floatValue]/100;
        
        self.decisionBatT2Lbl.text = [self checkNSNumber:[key valueForKey:@"DecisionBattingB"]];
        self.decisionBatT2PV.progress = [self.decisionBatT2Lbl.text floatValue]/100;
        
        self.decisionBowlT2Lbl.text = [self checkNSNumber:[key valueForKey:@"DecisionBowlingB"]];
        self.decisionBowlT2PV.progress = [self.decisionBowlT2Lbl.text floatValue]/100;
        
        self.battingFirstInnWinT2Lbl.text = [self checkNSNumber:[key valueForKey:@"BatFirstInnsTeamB"]];
        self.battingFirstInnWinT2PV.progress = [self.battingFirstInnWinT2Lbl.text floatValue]/100;
        
        self.battingSecondInnWinT2Lbl.text = [self checkNSNumber:[key valueForKey:@"BatSecondInnsTeamB"]];
        self.battingSecondInnWinT2PV.progress = [self.battingSecondInnWinT2Lbl.text floatValue]/100;
    }
}

-(void)altermsg:(NSString *) message
{
    UIAlertView * objaltert =[[UIAlertView alloc]initWithTitle:@"Head To Head" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [objaltert show];
}

- (NSString *)checkNSNumber:(id)unknownTypeParameter {
    
    NSString *str;
    if([unknownTypeParameter isKindOfClass:[NSNumber class]])
        {
        
        NSNumber *vv = [self checkNull:unknownTypeParameter];
        str = [vv stringValue];
        }
    else
        {
        str = [self checkNull:unknownTypeParameter];
        }
    return str;
}

- (NSString *)checkNull:(NSString *)_value
{
    if ([_value isEqual:[NSNull null]] || _value == nil || [_value isEqual:@"<null>"]) {
        _value=@"";
    }
    return _value;
}

@end
