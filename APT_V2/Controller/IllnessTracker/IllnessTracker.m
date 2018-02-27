//
//  IllnessTracker.m
//  APT_V2
//
//  Created by MAC on 26/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "IllnessTracker.h"
#import "CustomNavigation.h"
#import "WebService.h"
#import "Config.h"
#import "AppCommon.h"

@interface IllnessTracker () {
    
    WebService * objWebservice;
    NSString * cliendCode ;
    NSString * RoleCode;
    NSString * userCode;
    
    BOOL isExpected;
    BOOL isOnset;
    BOOL isAffect;
    BOOL isCause;
    BOOL isMainSymptom;
    BOOL isSelectPop;
    
    NSString * selectAffectSystemCode;
    NSString * selectMainSymptromCode;
    NSString * selectCauseCode;
    
    UIDatePicker * datePicker;
    NSString * selectExpertOpinionCode;
    
    UITableView *dropDownTblView;
}

@property (nonatomic,strong) NSMutableArray *affectArray;
@property (nonatomic,strong) NSMutableArray* mainSymptomArray;
@property (nonatomic,strong) NSMutableArray *causeIllnessArray;
@property (nonatomic,strong) NSMutableArray * commonArray;
@end

@implementation IllnessTracker

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    dropDownTblView = [[UITableView alloc]init];
    dropDownTblView.dataSource = self;
    dropDownTblView.delegate = self;
    
    //Navigation View
    [self customnavigationmethod];
    
    self.filePopView.hidden = YES;
    objWebservice =[[WebService alloc]init];
    
        //UIDatePicker
    datePicker = [[UIDatePicker alloc] init];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    
        //create left side empty space so that done button set on right side
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonAction)];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style: UIBarButtonItemStyleDone target:self action:@selector(doneButtonAction)];
    NSMutableArray *toolbarArray = [NSMutableArray new];
    [toolbarArray addObject:cancelBtn];
    [toolbarArray addObject:flexSpace];
    [toolbarArray addObject:doneBtn];
    
    [toolbar setItems:toolbarArray animated:false];
    [toolbar sizeToFit];
    
        //setting toolbar as inputAccessoryView
    self.expectedDateTF.inputAccessoryView = toolbar;
    self.onsetDateTF.inputAccessoryView = toolbar;
    
    [self Fetchillnessloadingwebservice];
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

-(void)customnavigationmethod
{
    CustomNavigation *objCustomNavigation=[CustomNavigation new];
    [self.navigationView addSubview:objCustomNavigation.view];
        //    objCustomNavigation.tittle_lbl.text=@"";
    objCustomNavigation.btn_back.hidden =NO;
    objCustomNavigation.menu_btn.hidden =YES;
    [objCustomNavigation.btn_back addTarget:self action:@selector(actionBack) forControlEvents:UIControlEventTouchUpInside];
}

-(void)actionBack
{
    [appDel.frontNavigationController popViewControllerAnimated:YES];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"BACK"];
}


-(void) cancelButtonAction {
    if(isExpected == YES) {
        self.expectedDateTF.text = @"";
        [self.expectedDateTF resignFirstResponder];
    } else if(isOnset == YES) {
        self.onsetDateTF.text = @"";
        [self.onsetDateTF resignFirstResponder];
    }
    [self.view endEditing:true];
}


-(void) doneButtonAction {
    [self.view endEditing:true];
}

- (IBAction)expectedDateButtonTapped:(id)sender {
    isExpected =YES;
//    isOnset =NO;
    [self displayDatePicker];
}

- (IBAction)onsetDateButtonTapped:(id)sender {
    isExpected =NO;
    isOnset =YES;
    [self displayDatePicker];
}

-(void)displayDatePicker
{
    if (isExpected) {
        datePicker.datePickerMode = UIDatePickerModeDate;
        self.expectedDateTF.inputView = datePicker;
        [datePicker addTarget:self action:@selector(displaySelectedDateAndTime:) forControlEvents:UIControlEventValueChanged];
        [self.expectedDateTF addTarget:self action:@selector(displaySelectedDateAndTime:) forControlEvents:UIControlEventEditingDidBegin];
        [self.expectedDateTF becomeFirstResponder];
    } else if (isOnset) {
        datePicker.datePickerMode = UIDatePickerModeDate;
        self.onsetDateTF.inputView = datePicker;
        [datePicker addTarget:self action:@selector(displaySelectedDateAndTime:) forControlEvents:UIControlEventValueChanged];
        [self.onsetDateTF addTarget:self action:@selector(displaySelectedDateAndTime:) forControlEvents:UIControlEventEditingDidBegin];
        [self.onsetDateTF becomeFirstResponder];
    }
}


- (void) displaySelectedDateAndTime:(UIDatePicker*)sender {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //   2016-06-25 12:00:00
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [datePicker setLocale:locale];
    [datePicker reloadInputViews];
    
    if(isExpected==YES)
    {
        self.expectedDateTF.text = [dateFormatter stringFromDate:[datePicker date]];
    } else if (isOnset) {
        self.onsetDateTF.text = [dateFormatter stringFromDate:[datePicker date]];
    }
}

- (IBAction)didClickExpertYesOpinion:(id)sender {
    
    if([self.expertYesBtn.currentImage isEqual:[UIImage imageNamed:@"radio_off"]])
    {
        [self.expertYesBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
        [self.expertNoBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
        
        selectExpertOpinionCode=@"MSC215";
    }
}


- (IBAction)didClickExpertNoOpinion:(id)sender {
    
    if([self.expertNoBtn.currentImage isEqual:[UIImage imageNamed:@"radio_off"]])
    {
        [self.expertYesBtn setImage:[UIImage imageNamed:@"radio_off"] forState:UIControlStateNormal];
        [self.expertNoBtn setImage:[UIImage imageNamed:@"radio_on"] forState:UIControlStateNormal];
        
        selectExpertOpinionCode=@"MSC216";
    }
}

- (IBAction)didClickAffectSystem:(id)sender {
    
    if(dropDownTblView != nil){
        [dropDownTblView removeFromSuperview];
    }
    
    if (!isAffect) {
        [self resetDropDownIllnesstatus];
        isAffect = YES;
        
        self.commonArray =[[NSMutableArray alloc]init];
        self.commonArray = self.affectArray;
        
        if (IS_IPAD) {
            dropDownTblView.frame = CGRectMake(self.affectSystemView.frame.origin.x, self.affectSystemView.frame.origin.y+self.affectSystemView.frame.size.height+288, self.affectSystemView.frame.size.width, self.commonArray.count >= 5 ? 150 : self.commonArray.count*45);
        } else {
            dropDownTblView.frame = CGRectMake(self.affectSystemView.frame.origin.x, self.affectSystemView.frame.origin.y+self.affectSystemView.frame.size.height+288, self.affectSystemView.frame.size.width, self.commonArray.count >= 5 ? 150 : self.commonArray.count*45);
        }
        
        
        dropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
        [self.view addSubview:dropDownTblView];
        [dropDownTblView reloadData];
    } else {
        [self resetDropDownIllnesstatus];
    }
    
}

- (IBAction)didClickMainSymptom:(id)sender {
    
    if(dropDownTblView != nil) {
        [dropDownTblView removeFromSuperview];
    }
    
    if (!isMainSymptom) {
        [self resetDropDownIllnesstatus];
        isMainSymptom = YES;
        
        self.commonArray =[[NSMutableArray alloc]init];
        self.commonArray = self.mainSymptomArray;
        if (IS_IPAD) {
            dropDownTblView.frame = CGRectMake(self.mainSymptomView.frame.origin.x, self.mainSymptomView.frame.origin.y+self.mainSymptomView.frame.size.height+335, self.mainSymptomView.frame.size.width, self.commonArray.count >= 5 ? 150 : self.commonArray.count*45);
        } else {
            dropDownTblView.frame = CGRectMake(self.mainSymptomView.frame.origin.x, self.mainSymptomView.frame.origin.y+self.mainSymptomView.frame.size.height+335, self.mainSymptomView.frame.size.width, self.commonArray.count >= 5 ? 150 : self.commonArray.count*45);
        }
        
        
        dropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
        [self.view addSubview:dropDownTblView];
        [dropDownTblView reloadData];
    } else {
        [self resetDropDownIllnesstatus];
    }
    
}
- (IBAction)didClickCauseOfIllness:(id)sender {
    
    if(dropDownTblView != nil){
        [dropDownTblView removeFromSuperview];
    }
    
    if (!isCause) {
        [self resetDropDownIllnesstatus];
        isCause = YES;
        
        self.commonArray =[[NSMutableArray alloc]init];
        self.commonArray = self.causeIllnessArray;
        if (IS_IPAD) {
            dropDownTblView.frame = CGRectMake(self.causeIllnessView.frame.origin.x, self.causeIllnessView.frame.origin.y+self.causeIllnessView.frame.size.height+385, self.causeIllnessView.frame.size.width, self.commonArray.count >= 5 ? 150 : self.commonArray.count*45);
        } else {
            dropDownTblView.frame = CGRectMake(self.causeIllnessView.frame.origin.x, self.causeIllnessView.frame.origin.y+self.causeIllnessView.frame.size.height, self.causeIllnessView.frame.size.width, self.commonArray.count >= 5 ? 150 : self.commonArray.count*45);
        }
        
        dropDownTblView.backgroundColor=[UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
        [self.view addSubview:dropDownTblView];
        [dropDownTblView reloadData];
    } else {
        [self resetDropDownIllnesstatus];
    }
    
}

- (void)resetDropDownIllnesstatus {
    isAffect =NO;
    isMainSymptom =NO;
    isCause   =NO;
}

- (IBAction)didClickInvestigationsUpload:(id)sender {
    
    if(isSelectPop == NO)
        {
        self.filePopView.hidden = NO;
        isSelectPop = YES;
//        [self showAnimate];
        }
    else
        {
        self.filePopView.hidden = YES;
        isSelectPop = NO;
//        [self removeAnimate];
        }
    
}

- (IBAction)didClickSave:(id)sender {
}

- (IBAction)didClickUpdate:(id)sender {
}

- (IBAction)didClickDelete:(id)sender {
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
    return self.commonArray.count;
}
    // the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"illmnessCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    if (tableView == dropDownTblView) {
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor colorWithRed:(8/255.0f) green:(26/255.0f) blue:(77/255.0f) alpha:1.0f];
        cell.selectedBackgroundView = bgColorView;
        cell.textLabel.textColor = [UIColor whiteColor];
       
        
            if (isAffect == YES)
            {
            cell.textLabel.text = [[self.commonArray valueForKey:@"IlnessMetaDataTypeCode"] objectAtIndex:indexPath.row];
            
            }
            else if (isCause == YES)
            {
            cell.textLabel.text = [[self.commonArray valueForKey:@"IlnessMetaDataTypeCode"] objectAtIndex:indexPath.row];
            
            }
            else if (isMainSymptom == YES)
            {
            cell.textLabel.text = [[self.commonArray valueForKey:@"IlnessMetaDataTypeCode"] objectAtIndex:indexPath.row];
            
            }
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
    // when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == dropDownTblView) {
        
        if (isAffect) {
            self.affectSystemTF.text = [[self.commonArray valueForKey:@"IlnessMetaDataTypeCode"] objectAtIndex:indexPath.row];
            selectAffectSystemCode = [[self.commonArray valueForKey:@"IllnessMetaSubCode"] objectAtIndex:indexPath.row];
        } else if (isMainSymptom) {
            self.mainSymptomTF.text = [[self.commonArray valueForKey:@"IlnessMetaDataTypeCode"] objectAtIndex:indexPath.row];
            selectMainSymptromCode = [[self.commonArray valueForKey:@"IllnessMetaSubCode"] objectAtIndex:indexPath.row];
        } else if (isCause) {
            self.causeOfIllnessTF.text = [[self.commonArray valueForKey:@"IlnessMetaDataTypeCode"] objectAtIndex:indexPath.row];
            selectCauseCode = [[self.commonArray valueForKey:@"IllnessMetaSubCode"] objectAtIndex:indexPath.row];
        }
        
        if(dropDownTblView != nil){
            [dropDownTblView removeFromSuperview];
        }
        [self resetDropDownIllnesstatus];
    }
    
}

-(void)Fetchillnessloadingwebservice
{
        //[COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
        {
        [objWebservice getFetchMetadataList :illnessFetchload success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
                {
                
                self.AffectArray =[[NSMutableArray alloc]init];
                self.mainSymptomArray =[[NSMutableArray alloc]init];
                self.causeIllnessArray =[[NSMutableArray alloc]init];
                
                
                self.AffectArray =[responseObject valueForKey:@"AffectedSystem"];
                
                self.mainSymptomArray =[responseObject valueForKey:@"MainSymptoms"];
                
                self.causeIllnessArray =[responseObject valueForKey:@"CauseOfIllness"];
                
                /*
                if(self.isUpdate == YES)
                    {
                    
                    
                    NSString *CauseOfillnessCode = [self.objSelectobjIllnessArray valueForKey:@"causeOfIllnessCode"];
                    
                    NSMutableArray *selectedCause;
                    selectedCause = [[NSMutableArray alloc]init];
                    for(int i=0;i<self.causeillnessArray.count;i++)
                        {
                        NSDictionary *players = [[NSDictionary alloc]init];
                        players = [self.causeillnessArray objectAtIndex:i];
                        NSString *Cascode = [players valueForKey:@"IllnessMetaSubCode"];
                        
                        if([CauseOfillnessCode isEqualToString:Cascode])
                            {
                            [selectedCause addObject:players];
                            }
                        }
                    
                    NSMutableArray *tt=[[NSMutableArray alloc]init];
                    tt=[selectedCause objectAtIndex:0];
                    
                    self.CauseLbl.text =[tt valueForKey:@"IlnessMetaDataTypeCode"];
                    
                    
                    }
                */
                }
             [AppCommon hideLoading];
            [self.view setUserInteractionEnabled:YES];
        } failure:^(AFHTTPRequestOperation *operation, id error) {
            [COMMON webServiceFailureError:error];
            [self.view setUserInteractionEnabled:YES];
        }];
        
        }
}


    // press return to hide keyboard
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    if(textField == self.illnessNameTF){
        [self.chiefCompliantTF becomeFirstResponder];
        
    }else if(textField == self.chiefCompliantTF){
        [textField resignFirstResponder];
        [self didClickAffectSystem:self.affectSystemBtn];
        
    }else if(textField == self.affectSystemTF){
        [textField resignFirstResponder];
        [self didClickMainSymptom:self.mainSymptomBtn];
        
    }else if(textField == self.mainSymptomTF){
        [textField resignFirstResponder];
        [self didClickCauseOfIllness:self.causeBtn];
        
    }else if(textField == self.causeOfIllnessTF){
        [textField resignFirstResponder];
        return NO;
    }
    
    return YES;
}

@end
