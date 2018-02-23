    //
    //  NutritionVC.m
    //  APT_V2
    //
    //  Created by MAC on 21/02/18.
    //  Copyright © 2018 user. All rights reserved.
    //

#import "NutritionVC.h"
#import "NutritionCell.h"
#import "CustomNavigation.h"
#import "SWRevealViewController.h"
#import "Config.h"
#import "AppCommon.h"
#import "WebService.h"
#import "PopOverVC.h"

@interface NutritionVC () {
    NSString *clientCode;
    NSString *userCode;
    NSString *userRefCode;
    NSMutableArray *foodDiaryArray;
    NSMutableArray *foodDiaryCodeArray;
    NSMutableArray *breakfastMoreArray;
    NSMutableArray *snacksMoreArray;
    NSMutableArray *lunchMoreArray;
    NSMutableArray *dinnerMoreArray;
    NSMutableArray *supplementsMoreArray;
}

@end

@implementation NutritionVC

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view from its nib.
    
    [self customnavigationmethod];
    
    [self.nutritionCollectionView registerNib:[UINib nibWithNibName:@"NutritionCell" bundle:nil] forCellWithReuseIdentifier:@"nutritionCell"];
    /*
     MSC342    BREAKFAST
     MSC343    SNACK
     MSC344    LUNCH
     MSC345    DINNER
     */
    foodDiaryCodeArray = [[NSMutableArray alloc] initWithObjects:@"MSC342", @"MSC343", @"MSC344", @"MSC345", @"MSC412", nil];
    
        //Fetch Service Call
    [self foodDiaryFetchDetailsPostMethodWebService];
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
    
    BOOL isBackEnable = [[NSUserDefaults standardUserDefaults] boolForKey:@"BACK"];
    
    if (isBackEnable) {
        objCustomNavigation.menu_btn.hidden =YES;
        objCustomNavigation.btn_back.hidden =NO;
        [objCustomNavigation.btn_back addTarget:self action:@selector(actionBack) forControlEvents:UIControlEventTouchUpInside];
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

-(void)actionBack
{
    [appDel.frontNavigationController popViewControllerAnimated:YES];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"BACK"];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return foodDiaryArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NutritionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"nutritionCell" forIndexPath:indexPath];
    
    cell.layer.masksToBounds = NO;
    cell.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    cell.layer.shadowRadius = 5;
    cell.layer.shadowOpacity = 0.8f;
    
    cell.breakfastBtn.hidden = YES;
    cell.snacksBtn.hidden = YES;
    cell.lunchBtn.hidden = YES;
    cell.dinnerBtn.hidden = YES;
    cell.supplementsBtn.hidden = YES;
    /*
     MSC342    BREAKFAST
     MSC343    SNACK
     MSC344    LUNCH
     MSC345    DINNER
     MSC412    Supplements
     */
    NSMutableArray *foodDateArray = [NSMutableArray new];
    foodDateArray = [foodDiaryArray objectAtIndex:indexPath.row];
    
    for (id dateDict in foodDateArray) {
        
            //For  MSC342    BREAKFAST
        if ([[dateDict valueForKey:@"MEALCODE"] isEqualToString:@"MSC342"]) {
            cell.breakfastTimeLbl.text = [dateDict valueForKey:@"STARTTIME"];
            NSMutableArray *foodListArray = [dateDict valueForKey:@"FOODLIST"];
            
            if (foodListArray.count == 1) {
                cell.breakfast1Lbl.text = [[foodListArray objectAtIndex:0] valueForKey:@"FOOD"];
                    //                cell.breakfast2Lbl.text = @"-";
                    //                cell.breakfast3Lbl.text = @"-";
                cell.breakfast2Lbl.text = @"";
                cell.breakfast3Lbl.text = @"";
                [breakfastMoreArray addObject:@""];
                
            } else if (foodListArray.count == 2) {
                cell.breakfast1Lbl.text = [[foodListArray objectAtIndex:0] valueForKey:@"FOOD"];
                cell.breakfast2Lbl.text = [[foodListArray objectAtIndex:1] valueForKey:@"FOOD"];
                    //                cell.breakfast3Lbl.text = @"-";
                cell.breakfast3Lbl.text = @"";
                [breakfastMoreArray addObject:@""];
                
            } else if (foodListArray.count == 3) {
                cell.breakfast1Lbl.text = [[foodListArray objectAtIndex:0] valueForKey:@"FOOD"];
                cell.breakfast2Lbl.text = [[foodListArray objectAtIndex:1] valueForKey:@"FOOD"];
                cell.breakfast3Lbl.text = [[foodListArray objectAtIndex:2] valueForKey:@"FOOD"];
                [breakfastMoreArray addObject:@""];
                
            } else if (foodListArray.count > 3) {
                cell.breakfastBtn.hidden = NO;
                breakfastMoreArray = [NSMutableArray new];
                for (id listDict in foodListArray) {
                    [breakfastMoreArray addObject:[listDict valueForKey:@"FOOD"]];
                }
            }
        }
        else {
                //            Data is not available then Declare values with "-"
                //            cell.breakfast1Lbl.text = @"-";
                //            cell.breakfast2Lbl.text = @"-";
                //            cell.breakfast3Lbl.text = @"-";
        }
        
            //For  MSC343    SNACK
        if ([[dateDict valueForKey:@"MEALCODE"] isEqualToString:@"MSC343"]) {
            cell.snacksTimeLbl.text = [dateDict valueForKey:@"STARTTIME"];
            NSMutableArray *foodListArray = [dateDict valueForKey:@"FOODLIST"];
            
            if (foodListArray.count == 1) {
                cell.snacks1Lbl.text = [[foodListArray objectAtIndex:0] valueForKey:@"FOOD"];
                    //                cell.snacks2Lbl.text = @"-";
                    //                cell.snacks3Lbl.text = @"-";
                cell.snacks2Lbl.text = @"";
                cell.snacks3Lbl.text = @"";
                [snacksMoreArray addObject:@""];
                
            } else if (foodListArray.count == 2) {
                cell.snacks1Lbl.text = [[foodListArray objectAtIndex:0] valueForKey:@"FOOD"];
                cell.snacks2Lbl.text = [[foodListArray objectAtIndex:1] valueForKey:@"FOOD"];
                    //                cell.snacks3Lbl.text = @"-";
                cell.snacks3Lbl.text = @"";
                [snacksMoreArray addObject:@""];
                
            } else if (foodListArray.count == 3) {
                cell.snacks1Lbl.text = [[foodListArray objectAtIndex:0] valueForKey:@"FOOD"];
                cell.snacks2Lbl.text = [[foodListArray objectAtIndex:1] valueForKey:@"FOOD"];
                cell.snacks3Lbl.text = [[foodListArray objectAtIndex:2] valueForKey:@"FOOD"];
                [snacksMoreArray addObject:@""];
                
            } else if (foodListArray.count > 3) {
                cell.snacksBtn.hidden = NO;
                snacksMoreArray = [NSMutableArray new];
                for (id listDict in foodListArray) {
                    [snacksMoreArray addObject:[listDict valueForKey:@"FOOD"]];
                }
            }
        } else {
                //Data is not available then Declare values with "-"
                //            cell.snacks1Lbl.text = @"-";
                //            cell.snacks2Lbl.text = @"-";
                //            cell.snacks3Lbl.text = @"-";
        }
        
            //MSC344    LUNCH
        if ([[dateDict valueForKey:@"MEALCODE"] isEqualToString:@"MSC344"]) {
            cell.lunchTimeLbl.text = [dateDict valueForKey:@"STARTTIME"];
            NSMutableArray *foodListArray = [dateDict valueForKey:@"FOODLIST"];
            
            if (foodListArray.count == 1) {
                cell.lunch1Lbl.text = [[foodListArray objectAtIndex:0] valueForKey:@"FOOD"];
                    //                cell.lunch2Lbl.text = @"-";
                    //                cell.lunch3Lbl.text = @"-";
                cell.lunch2Lbl.text = @"";
                cell.lunch3Lbl.text = @"";
                [lunchMoreArray addObject:@""];
                
            } else if (foodListArray.count == 2) {
                cell.lunch1Lbl.text = [[foodListArray objectAtIndex:0] valueForKey:@"FOOD"];
                cell.lunch2Lbl.text = [[foodListArray objectAtIndex:1] valueForKey:@"FOOD"];
                    //                cell.lunch3Lbl.text = @"-";
                cell.lunch3Lbl.text = @"";
                [lunchMoreArray addObject:@""];
                
            } else if (foodListArray.count == 3) {
                cell.lunch1Lbl.text = [[foodListArray objectAtIndex:0] valueForKey:@"FOOD"];
                cell.lunch2Lbl.text = [[foodListArray objectAtIndex:1] valueForKey:@"FOOD"];
                cell.lunch3Lbl.text = [[foodListArray objectAtIndex:2] valueForKey:@"FOOD"];
                [lunchMoreArray addObject:@""];
                
            } else if (foodListArray.count > 3) {
                cell.lunchBtn.hidden = NO;
                lunchMoreArray = [NSMutableArray new];
                for (id listDict in foodListArray) {
                    [lunchMoreArray addObject:[listDict valueForKey:@"FOOD"]];
                }
            }
        } else {
                //Data is not available then Declare values with "-"
                //            cell.lunch1Lbl.text = @"-";
                //            cell.lunch2Lbl.text = @"-";
                //            cell.lunch3Lbl.text = @"-";
        }
        
            //MSC345    DINNER
        if ([[dateDict valueForKey:@"MEALCODE"] isEqualToString:@"MSC345"]) {
            cell.dinnerTimeLbl.text = [dateDict valueForKey:@"STARTTIME"];
            NSMutableArray *foodListArray = [dateDict valueForKey:@"FOODLIST"];
            
            if (foodListArray.count == 1) {
                cell.dinner1Lbl.text = [[foodListArray objectAtIndex:0] valueForKey:@"FOOD"];
                    //                cell.dinner2Lbl.text = @"-";
                    //                cell.dinner3Lbl.text = @"-";
                cell.dinner2Lbl.text = @"";
                cell.dinner3Lbl.text = @"";
                [dinnerMoreArray addObject:@""];
            } else if (foodListArray.count == 2) {
                cell.dinner1Lbl.text = [[foodListArray objectAtIndex:0] valueForKey:@"FOOD"];
                cell.dinner2Lbl.text = [[foodListArray objectAtIndex:1] valueForKey:@"FOOD"];
                    //                cell.dinner3Lbl.text = @"-";
                cell.dinner3Lbl.text = @"";
                [dinnerMoreArray addObject:@""];
                
            } else if (foodListArray.count == 3) {
                cell.dinner1Lbl.text = [[foodListArray objectAtIndex:0] valueForKey:@"FOOD"];
                cell.dinner2Lbl.text = [[foodListArray objectAtIndex:1] valueForKey:@"FOOD"];
                cell.dinner3Lbl.text = [[foodListArray objectAtIndex:2] valueForKey:@"FOOD"];
                [dinnerMoreArray addObject:@""];
                
            } else if (foodListArray.count > 3) {
                cell.dinnerBtn.hidden = NO;
                dinnerMoreArray = [NSMutableArray new];
                for (id listDict in foodListArray) {
                    [dinnerMoreArray addObject:[listDict valueForKey:@"FOOD"]];
                }
            }
        } else {
                //Data is not available then Declare values with "-"
                //            cell.dinner1Lbl.text = @"-";
                //            cell.dinner2Lbl.text = @"-";
                //            cell.dinner3Lbl.text = @"-";
        }
            //MSC412    Supplements
        if ([[dateDict valueForKey:@"MEALCODE"] isEqualToString:@"MSC412"]) {
            cell.supplementsTimeLbl.text = [dateDict valueForKey:@"STARTTIME"];
            NSMutableArray *foodListArray = [dateDict valueForKey:@"FOODLIST"];
            
            if (foodListArray.count == 1) {
                cell.supplements1Lbl.text = [[foodListArray objectAtIndex:0] valueForKey:@"FOOD"];
                    //                cell.supplements2Lbl.text = @"-";
                    //                cell.supplements3Lbl.text = @"-";
                cell.supplements2Lbl.text = @"";
                cell.supplements3Lbl.text = @"";
                [supplementsMoreArray addObject:@""];
                
            } else if (foodListArray.count == 2) {
                cell.supplements1Lbl.text = [[foodListArray objectAtIndex:0] valueForKey:@"FOOD"];
                cell.supplements2Lbl.text = [[foodListArray objectAtIndex:1] valueForKey:@"FOOD"];
                    //                cell.supplements3Lbl.text = @"-";
                cell.supplements3Lbl.text = @"";
                [supplementsMoreArray addObject:@""];
                
            } else if (foodListArray.count == 3) {
                cell.supplements1Lbl.text = [[foodListArray objectAtIndex:0] valueForKey:@"FOOD"];
                cell.supplements2Lbl.text = [[foodListArray objectAtIndex:1] valueForKey:@"FOOD"];
                cell.supplements3Lbl.text = [[foodListArray objectAtIndex:2] valueForKey:@"FOOD"];
                [supplementsMoreArray addObject:@""];
                
            } else if (foodListArray.count > 3) {
                cell.supplementsBtn.hidden = NO;
                supplementsMoreArray = [NSMutableArray new];
                for (id listDict in foodListArray) {
                    [supplementsMoreArray addObject:[listDict valueForKey:@"FOOD"]];
                }
            }
        } else {
                //Data is not available then Declare values with "-"
                //            cell.supplements1Lbl.text = @"-";
                //            cell.supplements2Lbl.text = @"-";
                //            cell.supplements3Lbl.text = @"-";
        }
    }
    
    cell.breakfastBtn.tag = indexPath.row;
    cell.snacksBtn.tag = indexPath.row;
    cell.lunchBtn.tag = indexPath.row;
    cell.dinnerBtn.tag = indexPath.row;
    cell.supplementsBtn.tag = indexPath.row;
        //Target for More Details
    [cell.breakfastBtn addTarget:self action:@selector(didClickBreakfastMore:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.snacksBtn addTarget:self action:@selector(didClickSnacksMore:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.lunchBtn addTarget:self action:@selector(didClickLunchMore:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.dinnerBtn addTarget:self action:@selector(didClickDinnerMore:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.supplementsBtn addTarget:self action:@selector(didClickSupplementsMore:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (IS_IPAD) {
        return CGSizeMake(200, 650);
    } else {
        return CGSizeMake(200, 650);
    }
}

-(IBAction)didClickBreakfastMore:(id)sender
{
    [self popOverViewFuction:breakfastMoreArray andSender:sender];
}

-(IBAction)didClickSnacksMore:(id)sender
{
    [self popOverViewFuction:snacksMoreArray andSender:sender];
}

-(IBAction)didClickLunchMore:(id)sender
{
    [self popOverViewFuction:lunchMoreArray andSender:sender];
}

-(IBAction)didClickDinnerMore:(id)sender
{
    [self popOverViewFuction:dinnerMoreArray andSender:sender];
}

-(IBAction)didClickSupplementsMore:(id)sender
{
    [self popOverViewFuction:supplementsMoreArray andSender:sender];
}

- (void)popOverViewFuction:(NSMutableArray *)array andSender:(id)sender
{
    
    PopOverVC *popOverObj = [[PopOverVC alloc] init];
    popOverObj.listArray = array [[sender tag]];
    UIPopoverController *popOver = [[UIPopoverController alloc] initWithContentViewController:popOverObj];
    CGSize size;
    if (IS_IPAD) {
        size = CGSizeMake(200, array.count > 5 ? 200 : array.count*45);
    } else {
        size = CGSizeMake(200, array.count > 5 ? 200 : array.count*45);
    }
    [popOver setPopoverContentSize:size];
    [popOver setBackgroundColor:[UIColor whiteColor]];
    [popOver presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)foodDiaryFetchDetailsPostMethodWebService {
    
        // Get current datetime
    NSDate *currentDateTime = [NSDate date];
    
        // Instantiate a NSDateFormatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
        // Set the dateFormatter format
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    
        // Get the date time in NSString
    NSString *date = [dateFormatter stringFromDate:currentDateTime];
    
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
    [dic setObject:date forKey:@"DATE"];
    NSLog(@"parameters : %@",dic);
    [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response ; %@",responseObject);
        
        if ([[responseObject valueForKey:@"STATUS"] integerValue] == 1) {
            
            
            NSMutableArray *resultArray = [responseObject objectForKey:@"FOODDIARYS"];
            NSMutableArray *filteredArray = [NSMutableArray new];
            for (int i=0; i<resultArray.count; i++) {
                NSArray *filteredData = [resultArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(DATE contains[c] %@)", [[resultArray objectAtIndex:i] valueForKey:@"DATE"]]];
                
                [filteredArray addObject:filteredData];
                    //                NSLog(@"filteredData:%d:%@", i, filteredData);
            }
            
            foodDiaryArray = [NSMutableArray new];
            NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:filteredArray];
            foodDiaryArray = (NSMutableArray *)[orderedSet array];
                //            NSLog(@"arrayWithoutDuplicates:%@", foodDiaryArray);
                //            NSLog(@"count:%lu", (unsigned long)foodDiaryArray.count);
            [self.nutritionCollectionView reloadData];
        }
        
        [AppCommon hideLoading];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed");
        [COMMON webServiceFailureError:error];
        [AppCommon hideLoading];
        
    }];
    
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

