//
//  VideoPlayerUploadVC.m
//  APT_V2
//
//  Created by Apple on 09/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "VideoPlayerUploadVC.h"
#import "Config.h"
#import "AppCommon.h"
#import "WebService.h"

@interface VideoPlayerUploadVC ()
{
    WebService * objWebService;
}
@property (nonatomic,strong) NSMutableArray * objPlayerArray;
@property (nonatomic,strong) NSMutableArray * objCategoryArray;
@property (nonatomic,strong) NSMutableArray * sharetouserArray;
@property (nonatomic,strong) NSMutableArray * commonArray;
@property (nonatomic,strong) IBOutlet UITableView * popTbl;
@property (nonatomic,strong) IBOutlet UIView * date_view;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * popTblYposition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * popTblwidthposition;
@property (nonatomic, strong) UIDatePicker * datePicker;

@end

@implementation VideoPlayerUploadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    objWebService = [[WebService alloc]init];
    // Do any additional setup after loading the view from its nib.
    
    self.shadowView.layer.cornerRadius = 2.0f;
    self.shadowView.layer.borderWidth = 1.0f;
    self.shadowView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.shadowView.layer.masksToBounds = YES;

//    self.shadowView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
//    self.shadowView.layer.shadowOffset = CGSizeMake(5, 5.0f);
//    self.shadowView.layer.shadowRadius = 2.0f;
//    self.shadowView.layer.shadowOpacity = 1.0f;
//    self.shadowView.layer.masksToBounds = NO;
//    self.shadowView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.shadowView.bounds cornerRadius:self.shadowView.layer.cornerRadius].CGPath;
    
    self.teamView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.teamView.layer.borderWidth = 1.0f;
    
    self.playerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.playerView.layer.borderWidth = 1.0f;
    
    self.videoDateView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.videoDateView.layer.borderWidth = 1.0f;
    
    self.CategoryView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.CategoryView.layer.borderWidth = 1.0f;
    
    self.keywordsView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.keywordsView.layer.borderWidth = 1.0f;
    
    self.sharetoUserView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.sharetoUserView.layer.borderWidth = 1.0f;
    [self.date_view setHidden:YES];

}

-(void)FetchvideouploadWebservice
{
    NSString *ClientCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    NSString *UserrefCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
    NSString *usercode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
    
    
    if(![COMMON isInternetReachable])
        return;
    
    [AppCommon showLoading];
    //        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",LoginKey]];
    NSString *URLString =  URL_FOR_RESOURCE(FetchVideoUpload);
    
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
            self.objPlayerArray =[[NSMutableArray alloc]init];
            self.objCategoryArray = [[NSMutableArray alloc]init];
            self.sharetouserArray = [[NSMutableArray alloc]init];
            self.objPlayerArray =[responseObject valueForKey:@"lstVideoUploadPlayer"];
            self.objCategoryArray =[responseObject valueForKey:@"lstVideoUploadCategory"];
            self.sharetouserArray = [responseObject valueForKey:@"lstVideoUploadUser"];
            
        }
        
        
        [AppCommon hideLoading];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed");
        [COMMON webServiceFailureError:error];
        [AppCommon hideLoading];
        
    }];
}

-(IBAction)didClickPlayerList:(id)sender
{
    
}

-(IBAction)didClickCategoryList:(id)sender
{
    
}

-(IBAction)didClickShareUserList:(id)sender
{
    
}

-(IBAction)didClickDatePicker:(id)sender
{
    [self DisplaydatePicker];
}

# pragma Date Picker

-(void)DisplaydatePicker
{
    if(self.datePicker!= nil)
    {
        [self.datePicker removeFromSuperview];
        
    }
    self.date_view.hidden=NO;
    //isStartDate =YES;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //   2016-06-25 12:00:00
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    
    self.datePicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,self.date_view.frame.origin.y-200,self.view.frame.size.width,100)];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [self.datePicker setLocale:locale];
    
    // [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    [self.datePicker reloadInputViews];
    [self.date_view addSubview:self.datePicker];
    
}

-(IBAction)showSelecteddate:(id)sender{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    // NSDate *matchdate = [NSDate date];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSString * actualDate = [dateFormat stringFromDate:self.datePicker.date];
    
    self.date_lbl.text = actualDate;
    
    [self.date_view setHidden:YES];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.commonArray count];    //count number of row from counting array hear cataGorry is An Array
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
    
    cell.textLabel.text = [[self.commonArray valueForKey:@"CategoryName"] objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //self.catagory_lbl.text = [[self.commonArray valueForKey:@"CategoryName"] objectAtIndex:indexPath.row];
    
    
}

@end
