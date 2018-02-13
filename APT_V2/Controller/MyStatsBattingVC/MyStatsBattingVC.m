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
    [self myStatsBattingWebService];
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
//        if([[overAllArray valueForKey:@"hunderds"] isEqual:[NSNull null]] || [[overAllArray valueForKey:@"hunderds"] isEqual:@"<null>"] )
//            {
//                cell.overallHundredsLbl.text = @"0";
//            } else {
//
//                cell.overallHundredsLbl.text = [overAllArray valueForKey:@"hunderds"];
//            }
        //[overAllArray valueForKey:@"hunderds"];
        NSLog(@"S:%@", [[overAllArray objectAtIndex:indexPath.row] valueForKey:@"hunderds"]);
        cell.overallHundredsLbl.text = [self checkNull:[[overAllArray objectAtIndex:indexPath.row] valueForKey:@"hunderds"]];
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
            /*
            cell.matchSRiPadLbl.text = @"";
            cell.matchDotiPadLbl.text = @"";
            cell.matchBDYiPadLbl.text = @"";
            cell.matchFoursiPadLbl.text = @"";
            cell.matchSixsiPadLbl.text = @"";
            cell.matchBDYFqiPadLbl.text = @"";
            */
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
            /*
            cell.matchSRiPhoneLbl.text = @"";
            cell.matchDotiPhoneLbl.text = @"";
            cell.matchBDYiPhoneLbl.text = @"";
            cell.matchFoursiPhoneLbl.text = @"";
            cell.matchSixsiPhoneLbl.text = @"";
            cell.matchBDYFqiPhoneLbl.text = @"";
             */
        }
    
        return cell;
    }
     return nil;
}

#pragma mark - UITableViewDelegate
    // when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        [self.batttingTableView beginUpdates];
        
        if(indexPath.row == selectedIndex) {
            selectedIndex = -1;
                //cell.scoreView.hidden = YES;
            lastIndex = NULL;
        } else {
                //cell.scoreView.hidden = NO;
            if(lastIndex != nil) {
                [self.batttingTableView reloadRowsAtIndexPaths:@[lastIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
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

- (void)myStatsBattingWebService {
    
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
        
//        [self battingAction:nil];
        
//            [AppCommon showAlertWithMessage:@"My Stats Batting Failed"];
        
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

- (IBAction)battingAction:(id)sender {
    
    
}

-(NSString *)checkNull:(NSString *)_value
{
    
    if ([_value isEqual:[NSNull null]] || _value == nil || [_value isEqual:@"<null>"]) {
        _value=@"0";
    }
    return _value;
    
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
