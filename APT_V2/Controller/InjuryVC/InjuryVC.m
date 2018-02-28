//
//  InjuryVC.m
//  APT_V2
//
//  Created by Mac on 05/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "InjuryVC.h"
#import "CustomNavigation.h"
#import "SWRevealViewController.h"

typedef enum {
    kDelayed,
    kTraumatic
} OnSetType;

//typedef enum {
//    kDelayed,
//    kTraumatic
//} ExpertOptionType;


@interface InjuryVC () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    BOOL isOccurrence;
    BOOL isLocation;
    BOOL isSite;
    BOOL isType;
    BOOL isCasuse;
    BOOL isSelectPop;
    NSString* selectsliderValue;
    NSString *mrData;
    NSString *ctData;
    NSString *xrData;
    WebService * objWebservice;
}

@property (weak, nonatomic) IBOutlet UILabel *lblFile1;
@property (weak, nonatomic) IBOutlet UILabel *lblFile2;
@property (weak, nonatomic) IBOutlet UILabel *lblFile3;
@property (weak, nonatomic) IBOutlet UILabel *lblFIle4;


@property (weak, nonatomic) IBOutlet StepSlider *Slider1;
@property (nonatomic,strong)NSMutableArray  * InjuryListArray;
@property (nonatomic,weak) IBOutlet UITextField * compliant_Txt;
@property (nonatomic,weak) IBOutlet UITextField * comfirmatory_Txt;
@property (nonatomic,weak) IBOutlet UITextField * diagnosis_Txt;
@property (nonatomic,weak) IBOutlet UIButton * delay_Btn;
@property (nonatomic,weak) IBOutlet UIButton * tur_Btn;
@property (nonatomic,weak) IBOutlet UIButton * right_Btn;
@property (nonatomic,weak) IBOutlet UIButton * left_Btn;
@property (nonatomic,weak) IBOutlet UIButton * expectedright_Btn;
@property (nonatomic,weak) IBOutlet UIButton * expectedLeft_Btn;
@property (nonatomic,weak) IBOutlet UILabel * date_lbl;
@property (nonatomic,weak) IBOutlet UIView * navigation_view;
@property (nonatomic,weak) IBOutlet UITableView * pop_Tbl;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint * popviewYposition;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint * popviewXposition;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint * popviewWidth;

@property (nonatomic,weak) IBOutlet UIView * occurrence_view;
@property (nonatomic,weak) IBOutlet UIView * location_view;
@property (nonatomic,weak) IBOutlet UIView * site_view;
@property (nonatomic,weak) IBOutlet UIView * type_view;
@property (nonatomic,weak) IBOutlet UIView * casuse_view;

@property (nonatomic,weak)IBOutlet UIView * filepopview;
@property (nonatomic,weak) IBOutlet UIButton * selectFile;


@end

@implementation InjuryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    objWebservice = [WebService new];

    [self customnavigationmethod];
    [self setBorderwidthMethod];
    self.filepopview.hidden = YES;
    
    
    self.Slider1.labels = @[@"1", @"2", @"3", @"4", @"5",@"6",@"7"];
    self.Slider1.maxCount = 7;
    self.Slider1.trackHeight = 4;
    self.Slider1.trackCircleRadius = 5;
    self.Slider1.trackColor = [UIColor grayColor];
    self.Slider1.sliderCircleColor = [UIColor whiteColor];
    self.Slider1.labelColor = [UIColor whiteColor];
    self.Slider1.sliderCircleRadius = self.Slider1.trackCircleRadius+10;

}

-(void)viewWillAppear:(BOOL)animated
{
    SWRevealViewController *revealController = [self revealViewController];
    [revealController.panGestureRecognizer setEnabled:YES];
    [revealController.tapGestureRecognizer setEnabled:YES];
    
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
    [self.navigation_view addSubview:objCustomNavigation.view];
    
    objCustomNavigation.btn_back.hidden =YES;
    objCustomNavigation.menu_btn.hidden =NO;
    //        [objCustomNavigation.btn_back addTarget:self action:@selector(didClickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.menu_btn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    //        [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setBorderwidthMethod
{
    self.compliant_Txt.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.compliant_Txt.layer.borderWidth = 1.0;
    self.compliant_Txt.layer.masksToBounds = YES;
    
    self.comfirmatory_Txt.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.comfirmatory_Txt.layer.borderWidth = 1.0;
    self.comfirmatory_Txt.layer.masksToBounds = YES;
    
    self.diagnosis_Txt.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.diagnosis_Txt.layer.borderWidth = 1.0;
    self.diagnosis_Txt.layer.masksToBounds = YES;
    
    self.delay_Btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.delay_Btn.layer.borderWidth = 1.0;
    self.delay_Btn.layer.masksToBounds = YES;
    
    self.tur_Btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tur_Btn.layer.borderWidth = 1.0;
    self.tur_Btn.layer.masksToBounds = YES;
    
    self.right_Btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.right_Btn.layer.borderWidth = 1.0;
    self.right_Btn.layer.masksToBounds = YES;
    
    self.left_Btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.left_Btn.layer.borderWidth = 1.0;
    self.left_Btn.layer.masksToBounds = YES;
    
    self.expectedright_Btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.expectedright_Btn.layer.borderWidth = 1.0;
    self.expectedright_Btn.layer.masksToBounds = YES;
    
    self.expectedLeft_Btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.expectedLeft_Btn.layer.borderWidth = 1.0;
    self.expectedLeft_Btn.layer.masksToBounds = YES;
    
    self.date_lbl.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.date_lbl.layer.borderWidth = 1.0;
    self.date_lbl.layer.masksToBounds = YES;
    
    self.pop_Tbl.layer.borderColor = [UIColor brownColor].CGColor;
    self.pop_Tbl.layer.borderWidth = 1.0;
    self.pop_Tbl.layer.masksToBounds = YES;
    
    self.pop_Tbl.layer.cornerRadius = 10;
    self.pop_Tbl.layer.masksToBounds =YES;
    
    self.pop_Tbl.hidden= YES;
}

-(IBAction)didClickOccurrencePopBtn:(id)sender
{
    self.popviewYposition.constant = self.occurrence_view.frame.origin.y-95;
    self.popviewXposition.constant = self.view.frame.size.width - (self.view.frame.size.width/1.25);
    self.popviewWidth.constant = self.occurrence_view.frame.size.width-180;
    if(isOccurrence == NO)
    {
        self.pop_Tbl.hidden = NO;
        isOccurrence = YES;
        [self showAnimate];
        
    }
    else
    {
        self.pop_Tbl.hidden = YES;
        isOccurrence = NO;
        [self removeAnimate];
    }
    
    isCasuse = NO;
    isLocation = NO;
    isSite = NO;
    isType = NO;
}

-(IBAction)didClickLocationPopBtn:(id)sender
{
    self.popviewYposition.constant = self.location_view.frame.origin.y-85;
    self.popviewXposition.constant = self.view.frame.size.width - (self.view.frame.size.width/1.25);
    self.popviewWidth.constant = self.location_view.frame.size.width-180;
    if(isLocation == NO)
    {
        self.pop_Tbl.hidden = NO;
        isLocation = YES;
        [self showAnimate];
    }
    else
    {
        self.pop_Tbl.hidden = YES;
        isLocation = NO;
        [self removeAnimate];
    }
    
    isCasuse = NO;
    isOccurrence = NO;
    isSite = NO;
    isType = NO;
}

-(IBAction)didClicksitePopBtn:(id)sender
{
    self.popviewYposition.constant = self.site_view.frame.origin.y-40;
    self.popviewXposition.constant = self.view.frame.size.width - (self.view.frame.size.width/1.25);
    self.popviewWidth.constant = self.site_view.frame.size.width-180;
    if(isSite == NO)
    {
        self.pop_Tbl.hidden = NO;
        isSite = YES;
        [self showAnimate];
    }
    else
    {
        self.pop_Tbl.hidden = YES;
        isSite = NO;
        [self removeAnimate];
    }
    
    isCasuse = NO;
    isOccurrence = NO;
    isLocation = NO;
    isType = NO;
}
-(IBAction)didClickTypeBtn:(id)sender
{
    self.popviewYposition.constant = self.type_view.frame.origin.y-150;
    self.popviewXposition.constant = 5;
    self.popviewWidth.constant = self.type_view.frame.size.width/2.1;
    
    if(isType == NO)
    {
        self.pop_Tbl.hidden = NO;
        isType = YES;
        [self showAnimate];
    }
    else
    {
        self.pop_Tbl.hidden = YES;
        isType = NO;
        [self removeAnimate];
    }
    
    isCasuse = NO;
    isOccurrence = NO;
    isLocation = NO;
    isSite = NO;
}
-(IBAction)didClickCasuseBtn:(id)sender
{
    self.popviewYposition.constant = self.type_view.frame.origin.y-150;
    self.popviewXposition.constant = self.view.frame.size.width - (self.view.frame.size.width/2.05);
    self.popviewWidth.constant = self.type_view.frame.size.width/2.1;
    if(isCasuse == NO)
    {
        self.pop_Tbl.hidden = NO;
        isCasuse = YES;
        [self showAnimate];
    }
    else
    {
        self.pop_Tbl.hidden = YES;
        isCasuse = NO;
        [self removeAnimate];
    }
    
    isType = NO;
    isOccurrence = NO;
    isLocation = NO;
    isSite = NO;
}

-(IBAction)didClickDelayBtn:(id)sender
{
    [self setInningsBySelection:@"1"];
}

-(IBAction)didClickTramaticBtn:(id)sender
{
    [self setInningsBySelection:@"2"];
}
-(IBAction)didClicksideLeftBtn:(id)sender
{
    [self setInningsBySelection:@"3"];
}
-(IBAction)didClickSideRightBtn:(id)sender
{
    [self setInningsBySelection:@"4"];
}
-(IBAction)didClickExpectedLeftBtn:(id)sender
{
    [self setInningsBySelection:@"5"];
}
-(IBAction)didClickExpectedRightBtn:(id)sender
{
    [self setInningsBySelection:@"6"];
}
-(IBAction)didClickfilePopview:(id)sender
{
    if(isSelectPop == NO)
    {
        self.filepopview.hidden = NO;
        isSelectPop = YES;
        [self showAnimate];
    }
    else
    {
        self.filepopview.hidden = YES;
        isSelectPop = NO;
        [self removeAnimate];
    }
    
}
- (void)showAnimate
{
    self.pop_Tbl.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.pop_Tbl.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.pop_Tbl.alpha = 1;
        self.pop_Tbl.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)removeAnimate
{
    [UIView animateWithDuration:.25 animations:^{
        self.pop_Tbl.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.pop_Tbl.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            // [self.popTblView removeFromSuperview];
            self.pop_Tbl.hidden = YES;
        }
    }];
}

-(void) setInningsBySelection: (NSString*) innsNo{
    
//    [self setInningsButtonUnselect:self.delay_Btn];
//    [self setInningsButtonUnselect:self.tur_Btn];
//    [self setInningsButtonUnselect:self.right_Btn];
//    [self setInningsButtonUnselect:self.left_Btn];
//    [self setInningsButtonUnselect:self.expectedright_Btn];
//    [self setInningsButtonUnselect:self.expectedLeft_Btn];

    
    if([innsNo isEqualToString:@"1"]){
        
        [self setInningsButtonUnselect:self.tur_Btn];

        [self setInningsButtonSelect:self.delay_Btn];
        
    }else if([innsNo isEqualToString:@"2"]){
        
        [self setInningsButtonUnselect:self.delay_Btn];

        [self setInningsButtonSelect:self.tur_Btn];
    }
    else if([innsNo isEqualToString:@"3"]){
        
        [self setInningsButtonUnselect:self.right_Btn];

        [self setInningsButtonSelect:self.left_Btn];
    }
    else if([innsNo isEqualToString:@"4"]){
        
        [self setInningsButtonUnselect:self.left_Btn];

        [self setInningsButtonSelect:self.right_Btn];
    }
    else if([innsNo isEqualToString:@"5"]){
        [self setInningsButtonUnselect:self.expectedright_Btn];

        [self setInningsButtonSelect:self.expectedLeft_Btn];
    }
    else if([innsNo isEqualToString:@"6"]){
        [self setInningsButtonUnselect:self.expectedLeft_Btn];

        [self setInningsButtonSelect:self.expectedright_Btn];
    }
    
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
    [scanner scanHexInt:&hexint];
    
    //-----------------------------------------
    // Create color object, specifying alpha
    //-----------------------------------------
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:1.0f];
    
    return color;
}

-(void) setInningsButtonSelect : (UIButton*) innsBtn{
    // innsBtn.layer.cornerRadius = 25;
    UIColor *extrasBrushBG = [self colorWithHexString : @"#2CA7DB"];
    
    innsBtn.layer.backgroundColor = extrasBrushBG.CGColor;
    innsBtn.tag = 1;
    
}

-(void) setInningsButtonUnselect : (UIButton*) innsBtn{
    //  innsBtn.layer.cornerRadius = 25;
    UIColor *extrasBrushBG = [self colorWithHexString : @"#FFFFFF"];
    
    innsBtn.layer.backgroundColor = extrasBrushBG.CGColor;
    innsBtn.tag = 0;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(void)FetchInjuryListWebService
{
    if(![COMMON isInternetReachable])
        return;
    
        
        NSString *URLString =  URL_FOR_RESOURCE(FetchInjuryList);
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        NSString* cliendCode = [AppCommon GetClientCode];
        NSString* userRefcode = [AppCommon GetuserReference];

        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(cliendCode)   [dic    setObject:cliendCode     forKey:@"ClientCode"];
        if(userRefcode)   [dic    setObject:userRefcode     forKey:@"Userreferencecode"];
        
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                self.InjuryListArray =[[NSMutableArray alloc] init];
                self.InjuryListArray =[responseObject valueForKey:@"InjuryWebs"];
                if(self.InjuryListArray.count>0)
                {
//                    [self.injuryTbl reloadData];
                }
            }
            
            [AppCommon hideLoading];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed");
            [COMMON webServiceFailureError:error];
            
        }];
    
}

- (IBAction)actionVisualSelection:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"BACK"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    InjurySelectionViewController* selectedVC = [InjurySelectionViewController new];
    [appDel.frontNavigationController pushViewController:selectedVC animated:YES];
    
}

-(NSString* )getOnSetType
{
    NSString* str = @"";
    NSArray* arr = @[_delay_Btn,_tur_Btn];
    for (UIButton* btn in arr) {
        if (btn.tag) {
            str = btn.titleLabel.text;
            break;
        }
    }
    
    return str;
}

- (IBAction)getSliderValue_VAS:(id)sender {
    
    selectsliderValue = [NSString stringWithFormat:@"%lu",(unsigned long)self.Slider1.index];
}

-(NSString *)getExpertOption
{
    NSString* str = @"";
    NSArray* arr = @[_left_Btn,_right_Btn];
    for (UIButton* btn in arr) {
        if (btn.tag) {
            str = btn.titleLabel.text;
            break;
        }
    }
    
    return str;
}


- (IBAction)actionOpenDate:(id)sender {
    
    CalendarViewController  * objTabVC = [CalendarViewController new];
    //    objTabVC.datePickerFormat = @"yyy-MM-dd"; // 2/9/2018 12:00:00 AM
    objTabVC.datePickerFormat = @"dd/MM/yyy";
    objTabVC.datePickerDelegate = self;
    objTabVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    objTabVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [objTabVC.view setBackgroundColor:[UIColor clearColor]];
    [self presentViewController:objTabVC animated:YES completion:nil];
    
}

-(void)selectedDate:(NSString *)Date
{
//    currentlySelectedDate = Date;
    NSLog(@"selectedDate %@ ",Date);
//    [self tableValuesMethod];
    
}

- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}
-(void)opengallery
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * objPath =[[picker valueForKey:@"mediaTypes"] objectAtIndex:0];
    NSString *savedImagePath =   [documentsDirectory stringByAppendingPathComponent:objPath];
//    imageToPost = image;
//    if(isXray ==YES)
//    {
//        self.xrayLbl.text =savedImagePath;
//        xrData = [self encodeToBase64String:imageToPost];
//    }
//    else if (isCT ==YES)
//    {
//        self.CTScanLbl.text =savedImagePath;
//        ctData = [self encodeToBase64String:imageToPost];
//    }
//    else if (isMRI ==YES)
//    {
//        self.MRILbl.text =savedImagePath;
//        mrData = [self encodeToBase64String:imageToPost];
//    }
//    else if (isBlood ==YES)
//    {
//        self.BloodTestLbl.text =savedImagePath;
//        bloodData = [self encodeToBase64String:imageToPost];
//    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)InsertWebservice
{
    if(![COMMON isInternetReachable])
        return;
    
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSString* cliendcode = [AppCommon GetClientCode];
        if(cliendcode)   [dic    setObject:cliendcode     forKey:@"CLIENTCODE"];
    
    NSString* RoleCode = [AppCommon GetUserRoleCode];
    NSString* selectGameCode = [AppCommon GetUserRoleCode];
    NSString* selectTeamCode = [AppCommon GetUserRoleCode];
    NSString* selectPlayerCode = [AppCommon GetUserRoleCode];

        if([RoleCode isEqualToString:@"ROL0000003"])
        {
            if(selectGameCode)   [dic setObject:selectGameCode forKey:@"GAMECODE"];
            if(selectTeamCode)   [dic setObject:selectTeamCode forKey:@"TEAMCODE"];
            if(selectPlayerCode)   [dic setObject:selectPlayerCode forKey:@"PLAYERCODE"];
        }
        else{
            [dic setObject:@"" forKey:@"GAMECODE"];
            [dic setObject:@"" forKey:@"TEAMCODE"];
            [dic setObject:@"" forKey:@"PLAYERCODE"];
        }
    
//        if(self.assessmentLbl.text)   [dic    setObject:self.assessmentLbl.text     forKey:@"DATEOFASSESSMENT"];
//        if(self.onSetLbl.text)   [dic    setObject:self.onSetLbl.text     forKey:@"ONSETDATE"];
//        if(selectOnsetTypeCode)   [dic    setObject:selectOnsetTypeCode     forKey:@"ONSETTYPE"];
//        if(self.injuryNameTxt.text)   [dic    setObject:self.injuryNameTxt.text    forKey:@"INJURYNAME"];
    
        if(self.compliant_Txt.hasText)   [dic    setObject:self.compliant_Txt.text     forKey:@"CHIEFCOMPLIANT"];
    
        if(selectsliderValue)   [dic    setObject:selectsliderValue     forKey:@"VAS"];
//        if(selectInjuryOccuranceCode)   [dic    setObject:selectInjuryOccuranceCode     forKey:@"INJURYOCCURANCECODE"];
//        if(selectoccurancecode)   [dic    setObject:selectoccurancecode     forKey:@"INJURYOCCURANCESUBCODE"];
//        if(selectInjuryLocationCode)   [dic    setObject:selectInjuryLocationCode     forKey:@"INJURYLOCATIONCODE"];
//        if(selectlocationCode)   [dic    setObject:selectlocationCode     forKey:@"INJURYLOCATIONSUBCODE"];
//        if(selectInjurySiteCode)   [dic    setObject:selectInjurySiteCode     forKey:@"INJURYSITECODE"];
//        if(selectInjurySideCode)   [dic    setObject:selectInjurySideCode     forKey:@"INJURYSIDECODE"];
//        if(injuryTypeCode)   [dic    setObject:injuryTypeCode     forKey:@"INJURYTYPECODE"];
//        if(injuryCausecode)   [dic    setObject:injuryCausecode     forKey:@"INJURYCAUSECODE"];
//        if(selectExpertOpinionCode)   [dic    setObject:selectExpertOpinionCode     forKey:@"EXPERTOPTIONTAKENCODE"];
    
    
//        if(xrData==nil)
//        {
//            [dic    setObject:@""     forKey:@"XRAYSFILE"];
//        }
//        else{
//            [dic    setObject:xrData     forKey:@"XRAYSFILE"];
//        }
//        [dic    setObject:@"Xray.png"     forKey:@"XRAYSFILENAME"];
//
//
//
//        if(ctData==nil)
//        {
//            [dic    setObject:@""     forKey:@"CTSCANSFILE"];
//        }
//        else
//        {
//            [dic    setObject:ctData     forKey:@"CTSCANSFILE"];
//        }
//        [dic    setObject:@"Ctscan.png"     forKey:@"CTSCANSFILENAME"];
//
//
//
//        if(mrData==nil)
//        {
//            [dic    setObject:@""     forKey:@"MRISCANSFILE"];
//        }
//        else
//        {
//            [dic    setObject:mrData     forKey:@"MRISCANSFILE"];;
//        }
//        [dic    setObject:@"Mriscan.png"     forKey:@"MRISCANSFILENAME"];
//
//
//        if(bloodData==nil)
//        {
//            [dic    setObject:@""     forKey:@"BLOODTESTFILE"];
//        }
//        else
//        {
//            [dic    setObject:bloodData     forKey:@"BLOODTESTFILE"];;
//        }
//        [dic    setObject:@"Bloodtest.png"     forKey:@"BLOODTESTFILENAME"];
//
//        if(self.expectedLbl.text)   [dic    setObject:self.expectedLbl.text     forKey:@"EXPECTEDDATEOFRECOVERY"];
//        if(usercode)   [dic    setObject:usercode     forKey:@"CREATEDBY"];
    
    
        NSLog(@"parameters : %@",dic);
    
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        //NSDictionary *parameters = @{@"foo": @"bar"};
        NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
        NSString * url = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",injuryInsert]];
        [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileURL:filePath name:@"image" error:nil];
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"Success: %@", responseObject);
            BOOL status=[responseObject valueForKey:@"Status"];
            if(status == YES)
            {
                [AppCommon showAlertWithMessage:@"Injury Inserted Successfully"];
                
//                UIAlertView * objaltert =[[UIAlertView alloc]initWithTitle:@"Add Injury" message:[NSString stringWithFormat:@"Injury Inserted Successfully"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                objaltert.tag = 201;
//                [objaltert show];
                
//                self.xrayLbl.text = @"";
//                self.CTScanLbl.text = @"";
//                self.BloodTestLbl.text = @"";
//                self.MRILbl.text = @"";
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            else{
//                [self altermsg:@"Injury Insert failed"];
            }
            [AppCommon hideLoading];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [COMMON webServiceFailureError:error];
        }];
    
    
}

-(void)startFetchTeamPlayerGameService
{
    if(![COMMON isInternetReachable])
        return;
    
    NSString* cliendcode = [AppCommon GetClientCode];

        [objWebservice getFetchGameandTeam:FetchGameTeam :cliendcode  success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                
//                self.gameArray =[responseObject valueForKey:@"fetchGame"];
//                self.TeamArray =[responseObject valueForKey:@"fetchTeam"];
//                self.playerArray =[responseObject valueForKey:@"fetchAthlete"];
                
//                if(self.isUpdate == YES)
//                {
//                    self.saveBtn.hidden=YES;
//                    self.updateBtn.hidden =NO;
//                    self.deleteBtn.hidden =NO;
                    
                    //        self.gameLbl.text =[self.objSelectInjuryArray valueForKey:@"PLAYERCODE"];
                    //        self.TeamLbl.text =[self.objSelectInjuryArray valueForKey:@"teamName"];
                    //        self.playerLbl.text =[self.objSelectInjuryArray valueForKey:@"playerName"];
                    
//                    NSString *plycode = [self.objSelectInjuryArray valueForKey:@"PlayerCode"];
//
//                    NSMutableArray *selectedPlayer;
//                    selectedPlayer = [[NSMutableArray alloc]init];
//                    for(int i=0;i<self.playerArray.count;i++)
//                    {
//                        NSDictionary *players = [[NSDictionary alloc]init];
//                        players = [self.playerArray objectAtIndex:i];
//                        NSString *plyscode = [players valueForKey:@"athleteCode"];
//
//                        if([plycode isEqualToString:plyscode])
//                        {
//                            [selectedPlayer addObject:players];
//                        }
//                    }
//
//
//                    NSMutableArray *tt=[[NSMutableArray alloc]init];
//                    tt=[selectedPlayer objectAtIndex:0];
//                    self.playerLbl.text =[tt valueForKey:@"athleteName"];
//                    NSString *teamcode = [tt valueForKey:@"teamCode"];
//
//                    NSMutableArray *selectedTeam;
//                    for(int i=0;i<self.TeamArray.count;i++)
//                    {
//                        NSDictionary *Team = [[NSDictionary alloc]init];
//                        Team = [self.TeamArray objectAtIndex:i];
//                        NSString *tcode = [Team valueForKey:@"teamCode"];
//
//                        if([teamcode isEqualToString:tcode])
//                        {
//                            selectedTeam = [[NSMutableArray alloc]init];
//                            [selectedTeam addObject:Team];
//                        }
//                    }
//
//
//
//                    NSMutableArray *gg=[[NSMutableArray alloc]init];
//                    gg=[selectedTeam objectAtIndex:0];
//                    self.TeamLbl.text =[gg valueForKey:@"teamName"];
//                    NSString *gamecode = [gg valueForKey:@"gameCode"];
//
//                    NSMutableArray *selectedGame;
//                    for(int i=0;i<self.gameArray.count;i++)
//                    {
//                        NSDictionary *game = [[NSDictionary alloc]init];
//                        game = [self.gameArray objectAtIndex:i];
//
//                        NSString *gcode = [game valueForKey:@"gameCode"];
//
//                        if([gamecode isEqualToString:gcode])
//                        {
//                            selectedGame = [[NSMutableArray alloc]init];
//                            [selectedGame addObject:game];
//                        }
//                    }
//
//                    NSMutableArray *ggg=[[NSMutableArray alloc]init];
//                    ggg=[selectedGame objectAtIndex:0];
//
//                    self.gameLbl.text =[ggg valueForKey:@"gameName"];
//
//
//
//                    self.assessmentLbl.text =[self.objSelectInjuryArray valueForKey:@"DateOfAssessment"];
//
//                    self.onSetLbl.text =[self.objSelectInjuryArray valueForKey:@"OnSetDate"];
//                    //self.injurytypeLbl.text =[self.objSelectInjuryArray valueForKey:@"mainSymptomName"];
//                    //self.injuryCauseLbl.text =[self.objSelectInjuryArray valueForKey:@"causeOfIllnessName"];
//                    self.expectedLbl.text =[self.objSelectInjuryArray valueForKey:@"ExpectedDateOfRecovery"];
//                    self.injuryNameTxt.text =[self.objSelectInjuryArray valueForKey:@"InjuryName"];
//                    self.cheifcomplientTxt.text =[self.objSelectInjuryArray valueForKey:@"ChiefCompliant"];
//                    selectGameCode =[self.objSelectInjuryArray valueForKey:@"GameCode"];
//                    selectTeamCode =[self.objSelectInjuryArray valueForKey:@"TeamCode"];
//                    selectPlayerCode =[self.objSelectInjuryArray valueForKey:@"PlayerCode"];
//                    injuryTypeCode =[self.objSelectInjuryArray valueForKey:@"InjuryTypeCode"] ;
//                    injuryCausecode =[self.objSelectInjuryArray valueForKey:@"InjuryCauseCode"];
//                    //selectCauseCode =[self.objSelectInjuryArray valueForKey:@"causeOfIllnessCode"];
//                    selectExpertOpinionCode =[self.objSelectInjuryArray valueForKey:@"ExpertOptionTakenCode"];
//                    selectOnsetTypeCode =[self.objSelectInjuryArray valueForKey:@"OnSetType"];
//                    selectInjuryOccuranceCode =[self.objSelectInjuryArray valueForKey:@"InjuaryOccuranceCode"];
//                    selectInjuryLocationCode = [self.objSelectInjuryArray valueForKey:@"InjuryLocationCode"];
//                    selectInjurySiteCode = [self.objSelectInjuryArray valueForKey:@"InjurySiteCode"];
//                    selectInjurySideCode = [self.objSelectInjuryArray valueForKey:@"InjurySideCode"];
//
//                    selectInjuryCode  = [self.objSelectInjuryArray valueForKey:@"InjuryCode"];
//
//                    VasValue = [self.objSelectInjuryArray valueForKey:@"Vas"];
//
//                    int a = [VasValue intValue];
//                    self.StSlider.index = a-1;
//                    [self didChandeslidervalue:0];
                    
                    
                    
//                }
                
//                [self FetchMetadatawebservice];
                
            }
            [AppCommon hideLoading];
        } failure:^(AFHTTPRequestOperation *operation, id error) {
            [COMMON webServiceFailureError:error];
        }];
        
    
}

@end

