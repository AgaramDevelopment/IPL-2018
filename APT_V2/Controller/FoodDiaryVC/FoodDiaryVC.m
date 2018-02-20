//
//  FoodDiaryVC.m
//  APT_V2
//
//  Created by MAC on 17/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "FoodDiaryVC.h"
#import "FoodDiaryCell.h"
#import "FoodDescriptionCell.h"
#import "Config.h"
#import "AppCommon.h"
#import "WebService.h"
#import "SWRevealViewController.h"
@interface FoodDiaryVC () {
    NSString *clientCode;
    NSString *userCode;
    NSString *userRefCode;
    UIDatePicker * datePicker;
    BOOL isDate;
    BOOL isTime;
    NSComparisonResult result;
    NSMutableArray *foodDiaryArray;
    NSMutableArray *foodArray;
}

@end

@implementation FoodDiaryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    foodArray = [[NSMutableArray alloc] init];

        //Adds a shadow to contentView
    self.addBtn.layer.masksToBounds = NO;
    self.addBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    self.addBtn.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.addBtn.layer.shadowRadius = 5;
    self.addBtn.layer.shadowOpacity = 0.8f;
    
    [self.foodDiaryCollectionView registerNib:[UINib nibWithNibName:@"FoodDiaryCell" bundle:nil] forCellWithReuseIdentifier:@"foodCell"];
    
        //UIDatePicker
    datePicker = [[UIDatePicker alloc] init];
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    
        //create left side empty space so that done button set on right side
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonAction)];
    
        //    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style: UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonAction)];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style: UIBarButtonItemStyleDone target:self action:@selector(doneButtonAction)];
    NSMutableArray *toolbarArray = [NSMutableArray new];
    [toolbarArray addObject:cancelBtn];
    [toolbarArray addObject:flexSpace];
    [toolbarArray addObject:doneBtn];
    
    [toolbar setItems:toolbarArray animated:false];
    [toolbar sizeToFit];
    
        //setting toolbar as inputAccessoryView
    self.dateTF.inputAccessoryView = toolbar;
    self.timeTF.inputAccessoryView = toolbar;
    
    
//    [self foodDiaryFetchDetailsPostMethodWebService];

}

-(void)viewWillAppear:(BOOL)animated
{
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController.panGestureRecognizer setEnabled:YES];
    [revealController.tapGestureRecognizer setEnabled:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) doneButtonAction {
    [self.view endEditing:true];
}

-(void) cancelButtonAction {
    if(isDate==YES) {
        self.dateTF.text = @"";
        [self.dateTF resignFirstResponder];
    } else if(isTime==YES) {
        self.timeTF.text = @"";
        [self.timeTF resignFirstResponder];
    }
    [self.view endEditing:true];
}
- (IBAction)addFoodDiaryButtonTapped:(id)sender {
    self.dateTF.text = @"";
    self.timeTF.text = @"";
    self.mealTypeTF = @"";
    [foodArray removeAllObjects];
    self.locationTF = @"";
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.foodTableView reloadData];
        [self setClearBorderForMealTypeAndLocation];
    });
}

- (IBAction)dateButtonTapped:(id)sender {
    isDate =YES;
    [self DisplaydatePicker];
}

-(void)DisplaydatePicker
{
    datePicker.datePickerMode = UIDatePickerModeDate;
    self.dateTF.inputView = datePicker;
    [datePicker addTarget:self action:@selector(displaySelectedDateAndTime:) forControlEvents:UIControlEventValueChanged];
    [self.dateTF addTarget:self action:@selector(displaySelectedDateAndTime:) forControlEvents:UIControlEventEditingDidBegin];
    [self.dateTF becomeFirstResponder];
}

- (IBAction)timeButtonTapped:(id)sender {
    
    isDate =NO;
    isTime =YES;
    [self DisplayTime];
}

-(void)DisplayTime {
    datePicker.datePickerMode = UIDatePickerModeTime;
    self.timeTF.inputView = datePicker;
    [datePicker addTarget:self action:@selector(displaySelectedDateAndTime:) forControlEvents:UIControlEventValueChanged];
    [self.timeTF addTarget:self action:@selector(displaySelectedDateAndTime:) forControlEvents:UIControlEventEditingDidBegin];
    [self.timeTF becomeFirstResponder];
}

- (void) displaySelectedDateAndTime:(UIDatePicker*)sender {
    
    if(isDate==YES)
        {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //   2016-06-25 12:00:00
        [dateFormatter setDateFormat:@"MM-dd-yyyy"];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [datePicker setLocale:locale];
        [datePicker reloadInputViews];
        self.dateTF.text = [dateFormatter stringFromDate:[datePicker date]];
        
        NSDate *today = [NSDate date];
        result = [today compare:datePicker.date]; // comparing two dates
        
        } else if(isTime == YES){
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                //   2016-06-25 12:00:00
            [dateFormatter setDateFormat:@"hh:mm a"];
            NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
            [datePicker setLocale:locale];
            [datePicker reloadInputViews];
            self.timeTF.text=[dateFormatter stringFromDate:datePicker.date];
            
        }
}
/*
 // Food Diary Code's
MSC342    BREAKFAST
MSC343    SNACK
MSC344    LUNCH
MSC345    DINNER
*/
- (IBAction)mealTypeBreakfastAction:(id)sender {
//        self.mealTypeTF = @"Breakfast";
        self.mealTypeTF = @"MSC342";
        [self setBorderForMealType:1];
}

- (IBAction)mealTypeSnacksAction:(id)sender {
//        self.mealTypeTF = @"Snacks";
        self.mealTypeTF = @"MSC343";
        [self setBorderForMealType:2];
}

- (IBAction)mealTypeLunchAction:(id)sender {
//    self.mealTypeTF = @"Lunch";
    self.mealTypeTF = @"MSC344";
    [self setBorderForMealType:3];
}

- (IBAction)mealTypeDinnerAction:(id)sender {
//    self.mealTypeTF = @"Dinner";
    self.mealTypeTF = @"MSC345";
    [self setBorderForMealType:4];
}

- (IBAction)mealTypeSupplementsAction:(id)sender {
    self.mealTypeTF = @"Supplements";
    [self setBorderForMealType:5];
}

- (IBAction)foodDescriptionButtonTapped:(id)sender {
    /*
    if([self.dateTF.text isEqualToString:@""]) {
        [self altermsg:@"Please select date"];
            
    } else if ([self.timeTF.text isEqualToString:@""]) {
        [self altermsg:@"Please select time"];
    }
    */
    if ([self.foodItemTF.text isEqualToString:@""]) {
        [self altermsg:@"Please enter food item"];
    } else if ([self.quantityTF.text isEqualToString:@""]) {
        [self altermsg:@"Please enter food quantity"];
    } else {
    
        NSMutableDictionary *foodDescriptionDict = [NSMutableDictionary new];
        [foodDescriptionDict setObject:self.foodItemTF.text forKey:@"FOOD"];
        [foodDescriptionDict setObject:self.quantityTF.text forKey:@"FOODQUANTITY"];
        [foodArray addObject:foodDescriptionDict];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.foodTableView reloadData];
            self.foodItemTF.text = @"";
            self.quantityTF.text = @"";
        });
    }
    
}

- (IBAction)locationTeamAction:(id)sender {
        self.locationTF = @"Team";
        [self setBorderForLocation:6];
}
- (IBAction)locationRestaurantAction:(id)sender {
        self.locationTF = @"Restaurant";
        [self setBorderForLocation:7];
}

- (IBAction)locationHomeAction:(id)sender {
        self.locationTF = @"Home";
        [self setBorderForLocation:8];
}

- (IBAction)locationOtherAction:(id)sender {
        self.locationTF = @"Other";
        [self setBorderForLocation:9];
}

- (IBAction)saveOrUpdateButtonTapped:(id)sender {
    
    if([self.dateTF.text isEqualToString:@""]) {
        [self altermsg:@"Please select date"];
    } else if ([self.timeTF.text isEqualToString:@""]) {
        [self altermsg:@"Please select time"];
    } else if ([self.mealTypeTF isEqualToString:@""]) {
         [self altermsg:@"Please select Meal Type"];
    } else if (foodArray.count == 0) {
        [self altermsg:@"Please select Food Description"];
    }
    else if ([self.locationTF isEqualToString:@""]) {
        [self altermsg:@"Please enter Location"];
    }  else {
        
        [self foodDiaryInsertPostMethodWebService];
    }
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    FoodDiaryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"foodCell" forIndexPath:indexPath];
    
    cell.layer.masksToBounds = NO;
    cell.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    cell.layer.shadowRadius = 3;
    cell.layer.shadowOpacity = 0.8f;

    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (IS_IPAD) {
//        return CGSizeMake(140, 160);
        return CGSizeMake(120, 140);
    } else {
        return CGSizeMake(120, 140);
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma Tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return foodArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"foodDescriptionCell";
    
    FoodDescriptionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"FoodDescriptionCell" owner:self options:nil];
    cell = arr[0];
    
    if (foodArray.count) {
        cell.foodItemLbl.text = [[foodArray objectAtIndex:indexPath.row] valueForKey:@"FOOD"];
        cell.quantityLbl.text = [[foodArray objectAtIndex:indexPath.row] valueForKey:@"FOODQUANTITY"];
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_IPAD) {
        return 45;
    } else {
        return 35;
    }
    
}

- (void)foodDiaryFetchDetailsPostMethodWebService {
    
    if(![COMMON isInternetReachable])
        return;
    
    [AppCommon showLoading];
    
    NSString *URLString =  URL_FOR_RESOURCE(foodDiaryFetch);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.requestSerializer = requestSerializer;
    //CLIENTCODE, PLAYERCODE, DATE
    clientCode = [AppCommon GetClientCode];
    userRefCode = [AppCommon GetuserReference];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if(clientCode)   [dic    setObject:clientCode     forKey:@"CLIENTCODE"];
    if(userRefCode)   [dic    setObject:userRefCode     forKey:@"PLAYERCODE"];
    [dic setObject:@"02-19-2018" forKey:@"DATE"];
    NSLog(@"parameters : %@",dic);
    [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response ; %@",responseObject);
        
        
        [AppCommon hideLoading];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed");
        [COMMON webServiceFailureError:error];
        [AppCommon hideLoading];
        
    }];
    
}


- (void)foodDiaryInsertPostMethodWebService {
    
    if(![COMMON isInternetReachable])
        return;
    
    [AppCommon showLoading];
    
    NSString *URLString =  URL_FOR_RESOURCE(foodDiaryInsert);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.requestSerializer = requestSerializer;
        //CLIENTCODE, PLAYERCODE, DATE
    clientCode = [AppCommon GetClientCode];
    userCode = [AppCommon GetUsercode];
    userRefCode = [AppCommon GetuserReference];
    
    //CLIENTCODE, PLAYERCODE, DATE, STARTTIME, ENDTIME, MEALCODE, LOCATION, CREATEDBY, FOODLIST(FOOD, FOODQUANTITY)
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if(clientCode)   [dic    setObject:clientCode     forKey:@"CLIENTCODE"];
    if(userCode)   [dic    setObject:userCode     forKey:@"CREATEDBY"];
    if(userRefCode)   [dic    setObject:userRefCode     forKey:@"PLAYERCODE"];
    
    [dic setObject:self.dateTF.text forKey:@"DATE"];
    [dic setObject:self.timeTF.text forKey:@"STARTTIME"];
    [dic setObject:self.timeTF.text forKey:@"ENDTIME"];
    [dic setObject:self.mealTypeTF forKey:@"MEALCODE"];
    [dic setObject:self.locationTF forKey:@"LOCATION"];
//    [dic setObject:@"Dinner" forKey:@"MEALCODE"];
//    [dic setObject:@"Other" forKey:@"LOCATION"];
    [dic setObject:foodArray forKey:@"FOODLIST"];
    
    NSLog(@"parameters : %@",dic);
    [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response ; %@",responseObject);
        
        if ([[responseObject valueForKey:@"STATUS"] integerValue] == 1) {
             [self altermsg:[responseObject valueForKey:@"MESSAGE"]];
        }
        
        [AppCommon hideLoading];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed");
        [COMMON webServiceFailureError:error];
        [AppCommon hideLoading];
        
    }];
    
}

-(void)setBorderForMealType:(int)selectedTag
{
    NSArray *arr = @[self.breakfastBtn,self.snacksBtn,self.lunchBtn,self.dinnerBtn,self.supplementsBtn];
    
    for (UIButton *btn in arr) {
        if(btn.tag == selectedTag)
            {
            btn.layer.borderWidth = 2.0f;
            btn.layer.borderColor = [UIColor blackColor].CGColor;
            }
        else
            {
            btn.layer.borderWidth = 0.0f;
            btn.layer.borderColor = [UIColor clearColor].CGColor;
            }
        
    }
}

-(void)setBorderForLocation:(int)selectedTag
{
    NSArray *arr = @[self.teamBtn,self.restaurantBtn,self.homeBtn,self.otherBtn];
    
    for (UIButton *btn in arr) {
        if(btn.tag == selectedTag)
            {
            btn.layer.borderWidth = 2.0f;
            btn.layer.borderColor = [UIColor blackColor].CGColor;
            }
        else
            {
            btn.layer.borderWidth = 0.0f;
            btn.layer.borderColor = [UIColor clearColor].CGColor;
            }
        
    }
}

-(void)setClearBorderForMealTypeAndLocation {
    NSArray *arr = @[self.breakfastBtn,self.snacksBtn,self.lunchBtn,self.dinnerBtn,self.supplementsBtn, self.teamBtn,self.restaurantBtn,self.homeBtn,self.otherBtn];
    for (UIButton *btn in arr) {
            btn.layer.borderWidth = 0.0f;
            btn.layer.borderColor = [UIColor blackColor].CGColor;
            }
}

-(void)altermsg:(NSString *) message
{
    UIAlertView * objaltert =[[UIAlertView alloc]initWithTitle:@"Food Diary" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [objaltert show];
}

#pragma mark - UITextField Delegate Methods
- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.foodItemTF) {
        [self.quantityTF becomeFirstResponder];
    } else if (textField == self.quantityTF) {
        [textField resignFirstResponder];
    }
    return YES;
}

@end
