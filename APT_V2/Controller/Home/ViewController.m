//
//  ViewController.m
//  APT_V2
//
//  Created by user on 02/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "ViewController.h"
#import "TestPropertyCollectionViewCell.h"

@interface ViewController () <SKSTableViewDelegate,selectedDropDown,DatePickerProtocol>
{
    NSString * usercode;
    NSString *clientCode;
    BOOL isEdit;
    NSInteger currentlySelectedHeader;
    NSString* currentlySelectedDate;
    NSArray* arrayTestName;
    
}

@property (nonatomic,strong) NSMutableArray * objContenArray;
@property (nonatomic,strong) NSString * SelectScreenId;;
@property (nonatomic,strong) DBAConnection *objDBconnection;

@property (nonatomic,strong) NSDictionary * SelectDetailDic;
@property (nonatomic,strong) NSString * assessmentCodeStr;
@property (nonatomic,strong) NSString * ModuleCodeStr;
@property (nonatomic,strong) NSString * selectDate;

@end

@implementation ViewController
@synthesize tblAssesments;

@synthesize tblDropDown;

@synthesize txtTitle,txtModule;

@synthesize assCollection,lblRangeName,lblRangeValue;

@synthesize lblAssessmentName,lblUnitValue;

@synthesize txtRemarks,popupVC,lblNOData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    tblAssesments.SKSTableViewDelegate = self;
    
    arrayTestName = @[
                      @{@"TestName":@"Rom",@"TestCode":@"ASTT001"},
                      @{@"TestName":@"Special",@"TestCode":@"ASTT002"},
                      @{@"TestName":@"MMT",@"TestCode":@"ASTT003"},
                      @{@"TestName":@"Gaint",@"TestCode":@"ASTT004"},
                      @{@"TestName":@"Posture",@"TestCode":@"ASTT005"},
                      @{@"TestName":@"Coaching",@"TestCode":@"ASTT006"},
                      @{@"TestName":@"SC",@"TestCode":@"ASTT007"}
                      ];
    
    usercode = [AppCommon GetUsercode];
    clientCode = [AppCommon GetClientCode];
    
    [self customnavigationmethod];
    currentlySelectedHeader = -1;
    
    [assCollection registerNib:[UINib nibWithNibName:@"TestPropertyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"AssessmentCell"];

    
}

-(void)viewDidAppear:(BOOL)animated
{
    [txtModule setup];
    [txtTitle setup];
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
    
    UIView* view= self.view.subviews.firstObject;
    [view addSubview:objCustomNavigation.view];
    
    objCustomNavigation.btn_back.hidden =YES;
    objCustomNavigation.menu_btn.hidden =NO;
    //        [objCustomNavigation.btn_back addTarget:self action:@selector(didClickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.menu_btn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    //        [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)tableValuesMethod
{
    
    if (!txtTitle.hasText || !txtModule.hasText || !currentlySelectedDate.length) {
        
        NSLog(@"input required");
        return;
    }
    
    self.objDBconnection = [[DBAConnection alloc]init];
    self.objContenArray =[[NSMutableArray alloc]init];
    NSMutableArray * ComArray = [[NSMutableArray alloc]init];
    
    NSMutableArray * TestAsseementArray =  [self.objDBconnection TestByAssessment:clientCode :txtTitle.selectedCode :txtModule.selectedCode];
    
    NSLog(@"%@", TestAsseementArray);
    
    NSMutableArray * AssessmentTypeTest;
    NSMutableArray * AssessmentNameArray;
    NSMutableDictionary * MainDic = [[NSMutableDictionary alloc]init];
    for (int i = 0; i <TestAsseementArray.count; i++)
    {
        NSMutableDictionary * tempDict = [[NSMutableDictionary alloc]init];

        AssessmentNameArray =[[NSMutableArray alloc]init];
        [tempDict setValue:[[TestAsseementArray valueForKey:@"TestCode"] objectAtIndex:i] forKey:@"TestTypeCode"];
        [tempDict setValue:[[TestAsseementArray valueForKey:@"TestName"] objectAtIndex:i] forKey:@"TestTypeName"];
        
        NSString *assessmentTestCode = [[TestAsseementArray valueForKey:@"TestCode"] objectAtIndex:i];
        NSString * Screenid =  [self.objDBconnection ScreenId:txtTitle.selectedCode :assessmentTestCode ];
        NSLog(@" ScreenID %@", Screenid);
        [tempDict setValue:Screenid forKey:@"ScreenID"];
        
        NSString * Screencount =  [self.objDBconnection ScreenCount :txtTitle.selectedCode :assessmentTestCode];
        
        int count = [Screencount intValue];
        
        AssessmentTypeTest = [[NSMutableArray alloc]init];
        if(count>0)
        {
            
            AssessmentTypeTest = [self.objDBconnection AssementForm :Screenid :clientCode:txtModule.selectedCode:txtTitle.selectedCode :assessmentTestCode ];
        }
        
        for(int j=0;j<AssessmentTypeTest.count;j++)
        {
            
            NSMutableDictionary * objDic = [[NSMutableDictionary alloc]init];
            
            [objDic setValue:[[AssessmentTypeTest valueForKey:@"TestTypeCode"] objectAtIndex:j] forKey:@"TestTypeCode"];
            [objDic setValue:[[AssessmentTypeTest valueForKey:@"TestTypeName"] objectAtIndex:j] forKey:@"TestTypeName"];
            [objDic setValue:Screenid forKey:@"ScreenID"];
            
//            NSMutableArray * objArray = [self.objDBconnection getAssessmentEnrtyByDateTestType:[self.SelectDetailDic valueForKey:@"AssessmentCode"] :usercode :self.ModuleCodeStr :[self.SelectDetailDic valueForKey:@"SelectDate"] :clientCode :TestTypeCode : self.SelectTestCodeStr];
            
            currentlySelectedDate = [currentlySelectedDate stringByAppendingString:@" 12:00:00 AM"];
            NSMutableArray * objArray = [self.objDBconnection getAssessmentEnrtyByDateTestType:txtTitle.selectedCode :usercode :txtModule.selectedCode : currentlySelectedDate:currentlySelectedDate :[tempDict valueForKey:@"TestTypeCode"] : [objDic valueForKey:@"TestTypeCode"]];
            
            [AssessmentNameArray addObject:objDic];
            
        }
        [tempDict setObject:AssessmentNameArray forKey:@"TestValues"];
        [self.objContenArray addObject:tempDict];

    }
    
    [tblAssesments reloadData];
    
}

-(void)assmentValues:(NSString *)TestTypeCode
{
//    NSString * TestTypeCode =[objDic valueForKey:@"TestTypeCode"];
//    NSMutableArray * objArray = [self.objDBconnection getAssessmentEnrtyByDateTestType:[self.SelectDetailDic valueForKey:@"AssessmentCode"] :usercode :self.ModuleCodeStr :[self.SelectDetailDic valueForKey:@"SelectDate"] :clientCode :TestTypeCode : self.SelectTestCodeStr];

}


#pragma mark - UITableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    [lblNOData setHidden:self.objContenArray.count];
    return self.objContenArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (currentlySelectedHeader == section) {
        return 70;
    }
    else
    {
        return 45;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *cellIdentifier = @"Header";
    AssesmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"AssesmentTableViewCell" owner:self options:nil];
    if (nil == cell)
    {
        cell = array[0];
    }
    
    NSString* title = [[self.objContenArray objectAtIndex:section] valueForKey:@"TestTypeName"];
    [cell.btnAssTitle setTitle:title forState:UIControlStateNormal];
    cell.btnAssTitle.tag = section;
    [cell.btnAssTitle addTarget:self action:@selector(AssmentHeaderHeight:) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"viewForHeaderInSection section %ld ",(long)section);
    cell.translatesAutoresizingMaskIntoConstraints = NO;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (currentlySelectedHeader == section) {
        NSLog(@"numberOfRowsInSection open %ld ",(long)section);
        return [[[self.objContenArray objectAtIndex:currentlySelectedHeader] valueForKey:@"TestValues"] count];
    }
    else
    {
        NSLog(@"numberOfRowsInSection close %ld ",(long)section);
        return 0;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 35;
    
//    if (indexPath.row == 0) {
//        height = 30;
//    }
//    else
//    {
//        height = 35;
//    }

    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    AssesmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSArray* array;
    
    if(cell == nil)
    {
        array = [[NSBundle mainBundle] loadNibNamed:@"AssesmentTableViewCell" owner:self options:nil];
    }
    
    cell = array[3];
    cell.lblTestName.text = [[[[self.objContenArray objectAtIndex:indexPath.section] valueForKey:@"TestValues"] objectAtIndex:indexPath.row] valueForKey:@"TestTypeName"];

//    if (indexPath.row == 0) {
//        cell = array[2];
//    }
//    else
//    {
//        cell = array[3];
//
//    }
    
    cell.translatesAutoresizingMaskIntoConstraints = NO;

//    cell.textLabel.text = arrItems[indexPath.row];
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    lblAssessmentName.text = [[[[self.objContenArray objectAtIndex:indexPath.section] valueForKey:@"TestValues"] objectAtIndex:indexPath.row] valueForKey:@"TestTypeName"];
    NSString* testCode = [[[[self.objContenArray objectAtIndex:indexPath.section] valueForKey:@"TestValues"] objectAtIndex:indexPath.row] valueForKey:@"ScreenID"];
//    NSInteger index = [arrayTestName indexOfObject:[arrayTestName valueForKeyPath:@"TestCode"]];
//
//    for (NSDictionary* ndict in arrayTestName) {
//        if ([ndict valueForKey:testCode] == testCode) {
//            NSInteger index = [arrayTestName indexOfObject:ndict];
//        }
//    }
    
    
    self.Shadowview.layer.masksToBounds = NO;
    self.Shadowview.layer.shadowColor = [UIColor blackColor].CGColor;
    self.Shadowview.layer.shadowOffset = CGSizeZero;
    self.Shadowview.layer.shadowRadius = 10.0f;
    self.Shadowview.layer.shadowOpacity = 1.0f;

    
    if ([testCode isEqualToString:@"ASTT001"]) {
        
    }
    else if ([testCode isEqualToString:@"ASTT002"]) {
        
    }
    else if ([testCode isEqualToString:@"ASTT003"]) {
        
    }
    else if ([testCode isEqualToString:@"ASTT004"]) {
        
    }
    else if ([testCode isEqualToString:@"ASTT005"]) {
        
    }
    else if ([testCode isEqualToString:@"ASTT006"]) {
        
    }
    else if ([testCode isEqualToString:@"ASTT007"]) {
        
    }
    
    
    [self presentViewController:popupVC animated:YES completion:nil];
}

-(IBAction)closePopup:(id)sender
{
    [popupVC dismissViewControllerAnimated:YES completion:nil];
}
-(void)AssmentHeaderHeight:(UIButton *)sender
{
    if (currentlySelectedHeader == sender.tag) {
        currentlySelectedHeader = -1;
    }
    else
    {
        currentlySelectedHeader = sender.tag;

    }
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
//        [tblAssesments reloadSections:[NSIndexSet indexSetWithIndex:currentlySelectedHeader] withRowAnimation:UITableViewRowAnimationAutomatic];
        
//        [tblAssesments reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.objContenArray.count-1)] withRowAnimation:UITableViewRowAnimationAutomatic];

        
//        [tblAssesments beginUpdates];
        [tblAssesments reloadData];
//        [tblAssesments endUpdates];

    });
}


//#pragma mark - UITableViewDataSource
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return [self.objContenArray count];
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [self.objContenArray[section] count];
//}
//
//- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
//{
//    return [self.objContenArray[indexPath.section][indexPath.row] count]-1;
//}
//
//- (BOOL)tableView:(SKSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"SKSTableViewCell";
//
//    SKSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//
//    if (!cell)
//        cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//
//    NSDictionary * objDic = self.objContenArray[indexPath.section][indexPath.row][0];
//    cell.textLabel.text = [NSString stringWithFormat:@"%@", [objDic valueForKey:@"TestTypeName"]];
//    cell.textLabel.textColor =[UIColor whiteColor];
//    cell.textLabel.font = (IS_IPAD)? [UIFont fontWithName:@"Helvetica" size:15]:[UIFont fontWithName:@"Helvetica" size:13];
//    cell.expandable = YES;
////    NSInteger row = indexPath.row;
//
////    if (indexPath.section == 0 && (indexPath.row == row))
////        cell.expandable = YES;
////    else
////        cell.expandable = NO;
//    cell.backgroundColor =[UIColor colorWithRed:(17/255.0f) green:(24/255.0f) blue:(67/255.0f) alpha:0.9];
//
//    return cell;
//
////    static NSString *cellIdentifier = @"Header";
////    AssesmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
////    NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"AssesmentTableViewCell" owner:self options:nil];
////
////        cell = array[1];
////
////        NSDictionary * objDic = self.objContenArray[indexPath.section][indexPath.row][0];
////        [cell.btnAssTitle setTitle:[objDic valueForKey:@"TestTypeName"] forState:normal];
////        cell.btnAssTitle.tag = indexPath.row;
////        [cell.btnAssTitle addTarget:self action:@selector(AssmentHeaderHeight:) forControlEvents:UIControlEventTouchUpInside];
////
////    return cell;
//
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    static NSString *CellIdentifier = @"UITableViewCell";
////
////    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
////
////    if (!cell)
////        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
////
////    NSDictionary * objStr = self.objContenArray [indexPath.section][indexPath.row][indexPath.subRow];
////
////
////    cell.textLabel.text = [NSString stringWithFormat:@"%@",[objStr valueForKey:@"TestTypeName"]] ;//[NSString stringWithFormat:@"%@", self.objContenArray [indexPath.section][indexPath.row][indexPath.subRow]];
////    cell.backgroundColor =[UIColor clearColor];
////    cell.textLabel.textColor =[UIColor blackColor];
////    [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size: (IS_IPAD ? 15 : 14)]];
////    return cell;
//
//    static NSString *cellIdentifier = @"Cell";
//    AssesmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"AssesmentTableViewCell" owner:self options:nil];
//    if (indexPath.row == 0 && indexPath.section == 0) {
//        cell = array[2];
//    }
//    else
//    {
//        cell = array[3];
//    }
//
//    NSDictionary * objStr = self.objContenArray [indexPath.section][indexPath.row][indexPath.subRow];
//    NSLog(@"TestTypeName %@ ",[objStr valueForKey:@"TestTypeName"]);
//    //    cell.textLabel.text = [NSString stringWithFormat:@"%@",[objStr valueForKey:@"TestTypeName"]] ;
//    //    [cell.btnAssTitle setTitle:objStr[@"TestTypeName"] forState:normal];
//
//    return cell;
//
//}
//
////- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
////{
////    return UITableViewAutomaticDimension;
////}
////- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
////{
////    return UITableViewAutomaticDimension;
////}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"didSelectRow");
//    //NSDictionary * objDic = self.objContenArray[indexPath.section][indexPath.row][0];
//    //self.SelectTestCodeStr = [objDic valueForKey:@"TestTypeCode"];
//    //self.SelectTestNameStr = [objDic valueForKey:@"TestTypeName"];
//    //self.SelectScreenId    =[objDic valueForKey:@"ScreenID"];
//
//
//}
//
//- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"didSelectSubRow");
//    NSDictionary * objTitleDic = self.objContenArray[indexPath.section][indexPath.row][0];
//    NSDictionary * objDic  = self.objContenArray[indexPath.section][indexPath.row][indexPath.subRow];
//    NSString * TestTypeCode =[objDic valueForKey:@"TestTypeCode"];
//    NSMutableArray * objArray = [self.objDBconnection getAssessmentEnrtyByDateTestType:[self.SelectDetailDic valueForKey:@"AssessmentCode"] :usercode :self.ModuleCodeStr :[self.SelectDetailDic valueForKey:@"SelectDate"] :clientCode :TestTypeCode :  [objTitleDic valueForKey:@"TestTypeCode"]];
//    isEdit = NO;
//    if(objArray.count>0)
//    {
//        isEdit= YES;
//    }
//
//    //    TestAssessmentEntryVC * objAssessmentVC =[[TestAssessmentEntryVC alloc]init];
//    //    objAssessmentVC = (TestAssessmentEntryVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"TestAssessmentEntryVC"];
//    //    objAssessmentVC.selectAllValueDic =self.SelectDetailDic;
//    //    objAssessmentVC.SectionTestCodeStr = [objTitleDic valueForKey:@"TestTypeCode"];
//    //    objAssessmentVC.SelectTestStr = [objDic valueForKey:@"TestTypeName"];
//    //    objAssessmentVC.ModuleStr = self.ModuleCodeStr;
//    //    objAssessmentVC.IsEdit    =isEdit;
//    //    objAssessmentVC.SelectTestTypecode = TestTypeCode;
//    //    objAssessmentVC.SelectScreenId =[objDic valueForKey:@"ScreenID"];
//    //    [self.navigationController pushViewController:objAssessmentVC animated:YES];
//
//}

-(IBAction)openDropDown:(id)sender
{
    DropDownTableViewController* dropVC = [[DropDownTableViewController alloc] init];
    dropVC.protocol = self;
    
    if ([sender tag] == 0) {
        
        NSMutableDictionary *coachdict = [[NSMutableDictionary alloc]initWithCapacity:2];
        [coachdict setValue:@"Coach" forKey:@"ModuleName"];
        [coachdict setValue:@"MSC084" forKey:@"ModuleCode"];
        
        NSMutableDictionary *physiodict = [[NSMutableDictionary alloc]initWithCapacity:2];
        
        [physiodict setValue:@"Physio" forKey:@"ModuleName"];
        [physiodict setValue:@"MSC085" forKey:@"ModuleCode"];
        
        NSMutableDictionary *Sandcdict = [[NSMutableDictionary alloc]initWithCapacity:2];
        
        [Sandcdict setValue:@"S and C" forKey:@"ModuleName"];
        [Sandcdict setValue:@"MSC086" forKey:@"ModuleCode"];
        
        dropVC.array = @[coachdict,physiodict,Sandcdict];
        dropVC.key = @"ModuleName";
        
    }
    else
    {
        DBAConnection *Db = [[DBAConnection alloc]init];
        NSString *clientCode = [AppCommon GetClientCode];
        NSString *userCode = [AppCommon GetUsercode];
        
        dropVC.array = [Db AssessmentTestType:clientCode :userCode :txtModule.selectedCode];
        dropVC.key = @"AssessmentName";
        
    }
    CGFloat yposition = [sender superview].frame.origin.y + CGRectGetMaxY([sender frame]);
    
    dropVC.tblDropDown.frame = CGRectMake([sender frame].origin.x,yposition, 200, 200);
    dropVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    dropVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [dropVC.view setBackgroundColor:[UIColor clearColor]];
    [self presentViewController:dropVC animated:YES completion:nil];
    
}


-(void)selectedValue:(NSMutableArray *)array andKey:(NSString *)key andIndex:(NSIndexPath *)Index
{
    if([key isEqualToString:@"AssessmentName"])
    {
        txtTitle.text = [[array objectAtIndex:Index.row] valueForKey:key];
        txtTitle.selectedCode = [[array objectAtIndex:Index.row] valueForKey:@"AssessmentCode"];
    }
    else
    {
        txtModule.text = [[array objectAtIndex:Index.row] valueForKey:key];
        txtModule.selectedCode = [[array objectAtIndex:Index.row] valueForKey:@"ModuleCode"];
        
    }
    
    [self tableValuesMethod];

}

-(void)selectedDate:(NSString *)Date
{
    currentlySelectedDate = Date;
    NSLog(@"selectedDate %@ ",Date);
    [self tableValuesMethod];

}

- (IBAction)actionOpenDate:(id)sender {
    
    CalendarViewController  * objTabVC = [CalendarViewController new];
//    objTabVC.datePickerFormat = @"yyy-MM-dd"; // 2/9/2018 12:00:00 AM
    objTabVC.datePickerFormat = @"d/MM/yyy";
    objTabVC.datePickerDelegate = self;
    objTabVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    objTabVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [objTabVC.view setBackgroundColor:[UIColor clearColor]];
    [self presentViewController:objTabVC animated:YES completion:nil];

}
- (IBAction)actionAssessmentSave:(id)sender {
    
}



#pragma mark UICOLLECTIONVIEW DELAGATES

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TestPropertyCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AssessmentCell" forIndexPath:indexPath];
    
    return cell;

}

@end

