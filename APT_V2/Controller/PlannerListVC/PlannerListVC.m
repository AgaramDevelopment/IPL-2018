//
//  PlannerListVC.m
//  AlphaProTracker
//
//  Created by Mac on 14/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "PlannerListVC.h"
#import "PlannerCell.h"
#import "CustomNavigation.h"
#import "PlannerAddEvent.h"
#import "WebService.h"
#import "AppCommon.h"
#import "Config.h"
//#import "HomeVC.h"


@interface PlannerListVC ()
{
    NSString *usercode;
    NSString *cliendcode;
    NSString *userref;
    
}
@property (nonatomic,strong) IBOutlet UIButton * addBtn;
@property (nonatomic,strong) WebService * objWebservice;

@property (nonatomic,strong) NSMutableArray * AllEventListArray;
@property (nonatomic,strong) NSMutableArray * AllEventDetailListArray;
@property (nonatomic,strong) NSMutableArray * ParticipantsTypeArray;
@property (nonatomic,strong) NSMutableArray * PlayerTeamArray;
@property (nonatomic,strong) NSMutableArray * EventStatusArray;
@property (nonatomic,strong) NSMutableArray * EventTypeArray;

@end

@implementation PlannerListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    self.addBtn.layer.cornerRadius = 20;
    self.addBtn.layer.masksToBounds = YES;
    self.objWebservice =[[WebService alloc]init];
    
    usercode = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
    
    cliendcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    
    userref = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
    
    [self EventTypeWebservice :usercode:cliendcode:userref];
    
}
//-(void)viewWillAppear:(BOOL)animated
//{
//
//    [super viewWillAppear:animated];
//
//   // [self EventTypeWebservice :usercode:cliendcode:userref];
//
//
//}

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
-(void)EventTypeWebservice:(NSString *) usercode :(NSString*) cliendcode:(NSString *)userreference
{
    
    if([COMMON isInternetReachable])
    {
        [AppCommon showLoading];
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",PlannerEventKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(usercode)   [dic    setObject:usercode     forKey:@"CreatedBy"];
        if(cliendcode)   [dic    setObject:cliendcode     forKey:@"ClientCode"];
        if(userreference)   [dic    setObject:userreference     forKey:@"Userreferencecode"];
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                NSLog(@"%@",responseObject);
                self.AllEventListArray = [[NSMutableArray alloc]init];
                
                NSMutableArray * objAlleventArray= [responseObject valueForKey:@"ListEventTypeDetails"];
                
                
                NSMutableDictionary *mutableDict = [[NSMutableDictionary alloc]init];
                [mutableDict setObject:@"" forKey:@"EventTypeColor"];
                [mutableDict setObject:@"" forKey:@"EventTypeCode"];
                [mutableDict setObject:@"All EVENT" forKey:@"EventTypename"];
                
                [self.AllEventListArray addObject:mutableDict];
                for(int i=0; objAlleventArray.count>i;i++)
                {
                    NSMutableDictionary * objDic =[objAlleventArray objectAtIndex:i];
                    [self.AllEventListArray addObject:objDic];
                }
                
                self.ParticipantsTypeArray =[[NSMutableArray alloc]init];
                self.ParticipantsTypeArray=[responseObject valueForKey:@"ListParticipantsTypeDetails"];
                
                self.PlayerTeamArray =[[NSMutableArray alloc]init];
                self.PlayerTeamArray =[responseObject valueForKey:@"ListPlayerTeamDetails"];
                
                self.EventTypeArray  =[[NSMutableArray alloc]init];
                self.EventTypeArray =[responseObject valueForKey:@"ListEventTypeDetails"];
                
                self.EventStatusArray =[[NSMutableArray alloc]init];
                self.EventStatusArray =[responseObject valueForKey:@"ListEventStatusDetails"];
                
                [self.PlannerListTbl reloadData];
                
            }
            
            
            
            [AppCommon hideLoading];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed");
            [COMMON webServiceFailureError:error];
        }];
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.objPlannerArray count];    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"Plannerlistcell";
    
    
    PlannerCell * objCell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (objCell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"PlannerCell" owner:self options:nil];
        objCell = self.objPlannercell;
    }
    
    objCell.objEventName_lbl.text =[[self.objPlannerArray valueForKey:@"title"] objectAtIndex:indexPath.row];
    
    NSString * startdate =[[self.objPlannerArray valueForKey:@"startdatetime"] objectAtIndex:indexPath.row];
    NSDateFormatter *dateFormatters = [[NSDateFormatter alloc] init];
    [dateFormatters setDateFormat:@"dd/MM/yyyy hh:mm a"];
    NSDate *dates = [dateFormatters dateFromString:startdate];
    
    NSDateFormatter* dfs = [[NSDateFormatter alloc]init];
    [dfs setDateFormat:@"hh:mma"];
    NSString * endDateStr = [dfs stringFromDate:dates];
    
    
    NSString * endtime =[[self.objPlannerArray valueForKey:@"enddatetime"] objectAtIndex:indexPath.row];
    NSDateFormatter *dateFormatterss = [[NSDateFormatter alloc] init];
    [dateFormatterss setDateFormat:@"dd/MM/yyyy hh:mm a"];
    NSDate *date = [dateFormatters dateFromString:endtime];
    
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"hh:mma"];
    NSString * endtimeStr = [df stringFromDate:date];
    
    objCell.objStartTime_lbl.text = endDateStr;
    objCell.objendTime_lbl.text = endtimeStr;
    objCell.selectionStyle =UITableViewCellSelectionStyleNone;
    objCell.contentView.backgroundColor = [UIColor whiteColor];
    
    return objCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * selectDic = [self.objPlannerArray objectAtIndex:indexPath.row];
    PlannerAddEvent  * objaddEvent=[[PlannerAddEvent alloc]init];
    objaddEvent = (PlannerAddEvent *)[self.storyboard instantiateViewControllerWithIdentifier:@"AddEvent"];
    objaddEvent.isEdit =YES;
    objaddEvent.objSelectEditDic =selectDic;
    objaddEvent.ListeventTypeArray = self.EventTypeArray;
    objaddEvent.ListeventStatusArray =self.EventStatusArray;
    objaddEvent.ListparticipantTypeArray =self.ParticipantsTypeArray;

    [self.navigationController pushViewController:objaddEvent animated:YES];
    
    
    
//    PlannerAddEvent *objaddEvent = [[PlannerAddEvent alloc] initWithNibName:@"PlannerAddEvent" bundle:nil];
//    objaddEvent.isEdit =YES;
//    objaddEvent.objSelectEditDic =selectDic;
//    objaddEvent.ListeventTypeArray = self.EventTypeArray;
//    objaddEvent.ListeventStatusArray =self.EventStatusArray;
//    objaddEvent.ListparticipantTypeArray =self.ParticipantsTypeArray;
//    [self.view addSubview:objaddEvent.view];

}

-(IBAction)didClickAddBtn:(id)sender
{
//    PlannerAddEvent  * objaddEvent=[[PlannerAddEvent alloc]init];
//    objaddEvent = (PlannerAddEvent *)[self.storyboard instantiateViewControllerWithIdentifier:@"AddEvent"];
//    //objaddEvent.selectDateStr =selectdate;
//    objaddEvent.isEdit =NO;
//    objaddEvent.ListeventTypeArray = self.EventTypeArray;
//    objaddEvent.ListeventStatusArray =self.EventStatusArray;
//    objaddEvent.ListparticipantTypeArray =self.ParticipantsTypeArray;
//    
//    [self.navigationController pushViewController:objaddEvent animated:YES];
    
    PlannerAddEvent *objaddEvent = [[PlannerAddEvent alloc] initWithNibName:@"PlannerAddEvent" bundle:nil];
    objaddEvent.isEdit =NO;
    objaddEvent.ListeventTypeArray = self.EventTypeArray;
    objaddEvent.ListeventStatusArray =self.EventStatusArray;
    objaddEvent.ListparticipantTypeArray =self.ParticipantsTypeArray;
    [self.view addSubview:objaddEvent.view];
}

-(IBAction)didClickBackBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(IBAction)HomeBtnAction:(id)sender
{
//    HomeVC  * objTabVC=[[HomeVC alloc]init];
//    objTabVC = (HomeVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"HomeVC"];
//    [self.navigationController pushViewController:objTabVC animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
