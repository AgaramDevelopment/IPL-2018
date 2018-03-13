//
//  VideoGalleryVC.m
//  APT_V2
//
//  Created by Apple on 09/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "VideoGalleryVC.h"
#import "Config.h"
#import "AppCommon.h"
#import "HomeScreenStandingsVC.h"
#import "CustomNavigation.h"
#import "SWRevealViewController.h"
#import "VideoGalleryCell.h"
#import "VideoGalleryUploadCell.h"
#import "VideoPlayerViewController.h"
#import "VideoPlayerUploadVC.h"
#import "WebService.h"
#import "SchResStandVC.h"


@interface VideoGalleryVC ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,videoUploadDelegate>
{
    VideoPlayerViewController * videoPlayerVC;
    WebService * objWebService;
    BOOL isCategory;
    VideoPlayerUploadVC * videouploadVC;
}

@property (nonatomic,strong) NSMutableArray * objFirstGalleryArray;
@property (nonatomic,strong) NSMutableArray * objSecondGalleryArray;
@property (nonatomic,strong) NSMutableArray * objCatoryArray;
@property (nonatomic,strong) NSMutableArray * objVideoFilterArray;

@property (nonatomic,strong) NSMutableArray * CommonArray;

@property (nonatomic,strong) IBOutlet UITableView * categoryTbl;
@property (nonatomic,strong) IBOutlet UILabel * catagory_lbl;
@property (nonatomic,strong) IBOutlet UILabel * date_lbl;
@property (nonatomic,strong) IBOutlet UITextField * search_Txt;
@property (nonatomic, strong) NSArray *searchResult;

@property (nonatomic, strong) UIDatePicker * datePicker;
@property (nonatomic,strong) IBOutlet UIView * view_datepicker;


@end

@implementation VideoGalleryVC

@synthesize btnUpload;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    objWebService = [[WebService alloc]init];
    
    
    [self.videoCollectionview1 registerNib:[UINib nibWithNibName:@"VideoGalleryCell" bundle:nil] forCellWithReuseIdentifier:@"cellid"];
    [self.videoCollectionview2 registerNib:[UINib nibWithNibName:@"VideoGalleryUploadCell" bundle:nil] forCellWithReuseIdentifier:@"cellid"];
    self.categoryTbl.layer.borderColor = [UIColor brownColor].CGColor;
    self.categoryTbl.layer.borderWidth = 1.0;
    self.categoryTbl.layer.masksToBounds = YES;
    
    self.categoryTbl.layer.cornerRadius = 10;
    self.categoryTbl.layer.masksToBounds =YES;
    
    self.categoryTbl.hidden= YES;
    self.CancelTextImg.hidden = NO;
    self.clearBtn.hidden = NO;
    [self.view_datepicker setHidden:YES];
    
    [btnUpload setHidden:![AppCommon isCoach]];
    
    [self videoGalleryWebservice];

}

-(void)viewWillAppear:(BOOL)animated
{
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController.panGestureRecognizer setEnabled:YES];
    [revealController.tapGestureRecognizer setEnabled:YES];
}

- (void)showAnimate
{
    self.categoryTbl.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.categoryTbl.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.categoryTbl.alpha = 1;
        self.categoryTbl.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)removeAnimate
{
    [UIView animateWithDuration:.25 animations:^{
        self.categoryTbl.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.categoryTbl.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            // [self.popTblView removeFromSuperview];
            self.categoryTbl.hidden = YES;
        }
    }];
}


-(void)videoGalleryWebservice
{
    // [AppCommon showLoading ];
    
    NSString *ClientCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    NSString *UserrefCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
    NSString *usercode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
    
    
    if(![COMMON isInternetReachable])
        return;
    
    //[AppCommon showLoading];
    //        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",LoginKey]];
    NSString *URLString =  URL_FOR_RESOURCE(GalleryVideo);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.requestSerializer = requestSerializer;
    
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if(ClientCode)   [dic    setObject:ClientCode     forKey:@"clientCode"];
    if(UserrefCode)   [dic    setObject:UserrefCode     forKey:@"Userreferencecode"];
    if(usercode)   [dic    setObject:usercode     forKey:@"Usercode"];
    
    
    NSLog(@"parameters : %@",dic);
    [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response ; %@",responseObject);
        
        if(responseObject >0)
        {
            self.objFirstGalleryArray =[[NSMutableArray alloc]init];
            self.objSecondGalleryArray = [[NSMutableArray alloc]init];
            self.objCatoryArray = [[NSMutableArray alloc]init];
            self.objVideoFilterArray = [[NSMutableArray alloc]init];
            self.objFirstGalleryArray =[responseObject valueForKey:@"Firstlist"];
            self.objSecondGalleryArray =[responseObject valueForKey:@"Secondlist"];
            self.objCatoryArray = [responseObject valueForKey:@"Thirdlist"];
            
            self.CommonArray = [[NSMutableArray alloc]init];
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setValue:@"ALL" forKey:@"CategoryName"];
            [self.CommonArray addObject:dic];
            
            for(int i=0;i<self.objCatoryArray.count;i++)
            {
                [self.CommonArray addObject:[self.objCatoryArray objectAtIndex:i]];
            }
            
            self.objVideoFilterArray =  self.objSecondGalleryArray;
            
            [self.videoCollectionview1 reloadData];
            [self.videoCollectionview2 reloadData];
            
            
            
            
        }
        
        
        
        [AppCommon hideLoading];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed");
        [COMMON webServiceFailureError:error];
        [AppCommon hideLoading];
        
    }];
}


- (IBAction)UploadVideoAction:(id)sender {
    
    [self callVideoUploadMethod];
    [self.view layoutIfNeeded];
    //videouploadVC.commonView.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height);
    
}
-(void)callVideoUploadMethod
{
    if(videouploadVC != nil)
    {
        [videouploadVC.view removeFromSuperview];
    }
    videouploadVC = [[VideoPlayerUploadVC alloc] initWithNibName:@"VideoPlayerUploadVC" bundle:nil];
    
    [self.view addSubview:videouploadVC.view];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //return self.commonArray.count;
    if(collectionView==self.videoCollectionview1)
    {
        return self.objFirstGalleryArray.count;
    }
    else
    {
        return self.objVideoFilterArray.count;
    }
}
#pragma mar - UICollectionViewFlowDelegateLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(IS_IPHONE_DEVICE)
    {
        if(!IS_IPHONE5)
        {
            return CGSizeMake(50, 50);
        }
        else
        {
            if(collectionView == self.videoCollectionview1)
            {
                return CGSizeMake(224, 135);
            }
            else
            {
                return CGSizeMake(120, 180);
            }
        }
    }
    else
    {
        //return CGSizeMake(160, 140);

        if(collectionView == self.videoCollectionview1)
        {
            return CGSizeMake(224, 135);
        }
        else
        {
            return CGSizeMake(150, 220);
        }
    }
    
    //return UICollectionViewFlowLayoutAutomaticSize;
}
#pragma mark collection view cell paddings
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    if(!IS_IPHONE_DEVICE)
//    {
//        return UIEdgeInsetsMake(15, 15, 25, 15); // top, left, bottom, right
//    }
//    else{
//        return UIEdgeInsetsMake(10, 10, 10, 10);
//    }
    
    return UIEdgeInsetsMake(10, 10, 10, 10);

}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    if(!IS_IPHONE_DEVICE)
//    {
//        return 10.0;
//    }
//    else{
//        return 10.0;
//    }
    
    return 10.0;

}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    if(!IS_IPHONE_DEVICE)
//    {
//        return 23.0;
//    }
//    else{
//        return 10.0;
//    }
    
    return 10.0;

}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(collectionView==self.videoCollectionview1)
    {
        
        VideoGalleryCell* cell = [self.videoCollectionview1 dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
        
        cell.contentView.layer.cornerRadius = 2.0f;
        cell.contentView.layer.borderWidth = 1.0f;
        cell.contentView.layer.borderColor = [UIColor clearColor].CGColor;
        cell.contentView.layer.masksToBounds = YES;
        
        cell.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        cell.layer.shadowOffset = CGSizeMake(0, 2.0f);
        cell.layer.shadowRadius = 2.0f;
        cell.layer.shadowOpacity = 1.0f;
        cell.layer.masksToBounds = NO;
        cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
        NSString * videoDetailStr = [[self.objFirstGalleryArray valueForKey:@"videoName"] objectAtIndex:indexPath.row];
        NSArray *component3 = [videoDetailStr componentsSeparatedByString:@" "];
        
        cell.playername_lbl.text =  [NSString stringWithFormat:@"%@",component3[0]];
        cell.batting_lbl.text =  [NSString stringWithFormat:@"%@",component3[1]];
        cell.date_lbl.text =  [NSString stringWithFormat:@"%@",component3[2]];
        return cell;
    }
    if(collectionView==self.videoCollectionview2)
    {
        VideoGalleryUploadCell* cell = [self.videoCollectionview2 dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
        
        cell.contentView.layer.cornerRadius = 2.0f;
        cell.contentView.layer.borderWidth = 1.0f;
        cell.contentView.layer.borderColor = [UIColor clearColor].CGColor;
        cell.contentView.layer.masksToBounds = YES;
        
        cell.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        cell.layer.shadowOffset = CGSizeMake(0, 2.0f);
        cell.layer.shadowRadius = 2.0f;
        cell.layer.shadowOpacity = 1.0f;
        cell.layer.masksToBounds = NO;
        cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
        NSString * videoDetailStr = [[self.objVideoFilterArray valueForKey:@"videoName"] objectAtIndex:indexPath.row];
        NSArray *component3 = [videoDetailStr componentsSeparatedByString:@" "];
        
//        cell.playername_lbl.text =  [NSString stringWithFormat:@"%@",component3[0]];
        cell.batting_lbl.text =  [NSString stringWithFormat:@"%@",component3[1]];
//        cell.date_lbl.text =  [NSString stringWithFormat:@"%@",component3[2]];
        
        return cell;
    }
    
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * selectvideoStr;
    if (videoPlayerVC != nil) {
        
    }
    
    if(collectionView == self.videoCollectionview1)
    {
        selectvideoStr = [[self.objFirstGalleryArray valueForKey:@"videoFile"]objectAtIndex:indexPath.row];
    }
    else if(collectionView == self.videoCollectionview2)
    {
        selectvideoStr = [[self.objVideoFilterArray valueForKey:@"videoFile"]objectAtIndex:indexPath.row];
    }
    
    //    NSString * url = [NSString stringWithFormat:@"%@%@",Video_URL,selectvideoStr];
    //
    //    NSURL *videoURL = [NSURL URLWithString:url];
    //    AVPlayer *player = [AVPlayer playerWithURL:videoURL];
    //
    //    // create a player view controller
    //    AVPlayerViewController *controller = [[AVPlayerViewController alloc] init];
    //    [self presentViewController:controller animated:YES completion:nil];
    //    controller.player = player;
    //    [player play];
    
    videoPlayerVC = [[VideoPlayerViewController alloc] initWithNibName:@"VideoPlayerViewController" bundle:nil];
    videoPlayerVC.objSelectVideoLink = selectvideoStr;
    //    videoPlayerVC.view.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height);
    
    SchResStandVC *obj = [[SchResStandVC alloc] initWithNibName:@"SchResStandVC" bundle:nil];
    [appDel.frontNavigationController presentViewController:videoPlayerVC animated:YES completion:nil];
    
    
    //    [self.view addSubview:videoPlayerVC.view];
    
}

-(IBAction)didClickcategoryPopView:(id)sender
{
    if(isCategory == NO)
    {
        self.categoryTbl.hidden = NO;
        isCategory = YES;
        [self showAnimate];
        [self.categoryTbl reloadData];
    }
    else
    {
        self.categoryTbl.hidden = YES;
        isCategory = NO;
        [self removeAnimate];
    }
    
}

-(IBAction)didClickDatePicker:(id)sender
{
    [self DisplaydatePicker];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.CommonArray count];    //count number of row from counting array hear cataGorry is An Array
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"CategoryCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
    }
    
    // Here we use the provided setImageWithURL: method to load the web image
    // Ensure you use a placeholder image otherwise cells will be initialized with no image
    
    cell.textLabel.text = [[self.CommonArray valueForKey:@"CategoryName"] objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0)
    {
        self.catagory_lbl.text = [[self.CommonArray valueForKey:@"CategoryName"] objectAtIndex:indexPath.row];
        self.objVideoFilterArray =  self.objSecondGalleryArray;
    }
    else
    {
        
        self.catagory_lbl.text = [[self.CommonArray valueForKey:@"CategoryName"] objectAtIndex:indexPath.row];
        NSString * selectCategoryCode = [[self.CommonArray valueForKey:@"categoryCode"] objectAtIndex:indexPath.row];
        self.objVideoFilterArray =[[NSMutableArray alloc]init];
        for(NSDictionary * objDic in self.objSecondGalleryArray)
        {
            NSString * objStr = [objDic valueForKey:@"categoryCode"];
            if([objStr isEqualToString:selectCategoryCode])
            {
                [self.objVideoFilterArray addObject:objDic];
            }
        }
    }
    [self.videoCollectionview2 reloadData];
    [self removeAnimate];
    isCategory = NO;
    
}
#pragma mark - Search delegate methods

- (void)filterContentForSearchText:(NSString*)searchText
{
    
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"videoName CONTAINS[c] %@", searchText];
    _searchResult = [self.objSecondGalleryArray filteredArrayUsingPredicate:resultPredicate];
    
    NSLog(@"searchResult:%@", _searchResult);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // Update the UI
        if (_searchResult.count == 0) {
            self.objVideoFilterArray = [self.searchResult copy];
            [self.videoCollectionview2 reloadData];
            
        } else {
            
            self.objVideoFilterArray =[[NSMutableArray alloc]init];
            self.objVideoFilterArray = [self.searchResult copy];
            [self.videoCollectionview2 reloadData];
            
        }
    });
    
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //self.playerTbl.hidden = NO;
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //self.playerTbl.hidden = NO;
    NSLog(@"%@",textField);
    NSString *searchString = [NSString stringWithFormat:@"%@%@",textField.text, string];
    
    if (self.search_Txt.text.length!=1)
    {
        [self filterContentForSearchText:searchString];
    }
    else
    {
        self.objVideoFilterArray = [[NSMutableArray alloc]init];
        self.objVideoFilterArray =  self.objSecondGalleryArray;
        [self.videoCollectionview2 reloadData];
    }
    
    //[self filterContentForSearchText:searchString];
    dispatch_async(dispatch_get_main_queue(), ^{
        // Update the UI
        //[self.videoCollectionview2 reloadData];
    });
    return YES;
}

-(void)textFieldDidChange :(UITextField *) textField
{
    if (textField.text.length == 0) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.videoCollectionview2 reloadData];
        });
    }
    else {
        
        [self filterContentForSearchText:textField.text];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    //self.videoCollectionview2.hidden = NO;
    
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.videoCollectionview2 reloadData];
    });
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField;
{
    
    [textField resignFirstResponder];
}

# pragma Date Picker

-(void)DisplaydatePicker
{
    if(self.datePicker!= nil)
    {
        [self.datePicker removeFromSuperview];
        
    }
    self.view_datepicker.hidden=NO;
    //isStartDate =YES;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //   2016-06-25 12:00:00
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    
    self.datePicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,self.view_datepicker.frame.origin.y-200,self.view.frame.size.width,100)];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [self.datePicker setLocale:locale];
    
    // [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    [self.datePicker reloadInputViews];
    [self.view_datepicker addSubview:self.datePicker];
    
}

-(IBAction)showSelecteddate:(id)sender{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    // NSDate *matchdate = [NSDate date];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSString * actualDate = [dateFormat stringFromDate:self.datePicker.date];
    
    self.date_lbl.text = actualDate;
    
    if( ![self.date_lbl.text isEqualToString:@""])
    {
        self.CancelTextImg.hidden = NO;
        self.clearBtn.hidden = NO;
    }
    
    [self.view_datepicker setHidden:YES];
    
    self.objVideoFilterArray =[[NSMutableArray alloc]init];
    for(NSDictionary * objDic in self.objSecondGalleryArray)
    {
        NSString * objStr = [objDic valueForKey:@"videoName"];
        NSArray *component3 = [objStr componentsSeparatedByString:@" "];
        
        NSString * filterStr =  [NSString stringWithFormat:@"%@",component3[2]];
        if([filterStr isEqualToString:actualDate])
        {
            [self.objVideoFilterArray addObject:objDic];
        }
    }
    [self.videoCollectionview2 reloadData];
    
}

- (IBAction)ClearTextAction:(id)sender
{
    self.date_lbl.text = @"";
    self.CancelTextImg.hidden = YES;
    self.clearBtn.hidden = YES;
    
    self.objVideoFilterArray = [[NSMutableArray alloc]init];
    self.objVideoFilterArray =  self.objSecondGalleryArray;
    [self.videoCollectionview2 reloadData];
    
}



@end
