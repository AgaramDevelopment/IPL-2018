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
#import <MobileCoreServices/MobileCoreServices.h>
#import "CRTableViewCell.h"

@interface VideoPlayerUploadVC () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    WebService * objWebService;
    BOOL isPlayer;
    BOOL isCategory;
    BOOL isShare;
    NSString *imgData,* imgFileName;
     NSMutableArray* mainArray;
    NSMutableArray* chatArray;
    NSString *plyCode;


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
@property (strong, nonatomic)  NSMutableArray *selectedMarks;



@end

@implementation VideoPlayerUploadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    objWebService = [[WebService alloc]init];
    [self FetchvideouploadWebservice];

    // Do any additional setup after loading the view from its nib.
    
//    self.shadowView.layer.cornerRadius = 2.0f;
//    self.shadowView.layer.borderWidth = 1.0f;
//    self.shadowView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.shadowView.layer.masksToBounds = YES;
//
//
//    self.teamView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.teamView.layer.borderWidth = 1.0f;
//    
//    self.playerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.playerView.layer.borderWidth = 1.0f;
//    
//    self.videoDateView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.videoDateView.layer.borderWidth = 1.0f;
//    
//    self.CategoryView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.CategoryView.layer.borderWidth = 1.0f;
//    
//    self.keywordsView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.keywordsView.layer.borderWidth = 1.0f;
//    
//    self.sharetoUserView.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    self.sharetoUserView.layer.borderWidth = 1.0f;
    [self.date_view setHidden:YES];
    self.popTbl.hidden = YES;
    self.selectedMarks = [[NSMutableArray alloc]init];

}

-(void)FetchvideouploadWebservice
{
    NSString *ClientCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    NSString *UserrefCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
    NSString *usercode = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
    
    
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
    self.popTblYposition.constant = self.playerView.frame.origin.y-20;
    self.popTblwidthposition.constant = self.playerView.frame.size.width;
    if(isPlayer== NO)
    {
        self.popTbl.hidden = NO;
        self.commonArray = [[NSMutableArray alloc]init];
        self.commonArray = self.objPlayerArray;
        [self.popTbl reloadData];
        isPlayer = YES;
    }
    else
    {
        self.popTbl.hidden = YES;
        isPlayer = NO;
        isCategory = NO;
        isShare = NO;

    }
}

-(IBAction)didClickCategoryList:(id)sender
{
    self.popTblYposition.constant = self.CategoryView.frame.origin.y;
    self.popTblwidthposition.constant = self.CategoryView.frame.size.width;
    if(isCategory== NO)
    {
        self.popTbl.hidden = NO;
        self.commonArray = [[NSMutableArray alloc]init];
        self.commonArray = self.objCategoryArray;
        [self.popTbl reloadData];
        isCategory = YES;
    }
    else
    {
        self.popTbl.hidden = YES;
        isCategory = NO;
        isPlayer = NO;
        isShare = NO;
        
    }
}

-(IBAction)didClickShareUserList:(id)sender
{
    self.popTblYposition.constant = self.sharetoUserView.frame.origin.y-40;
    self.popTblwidthposition.constant = self.sharetoUserView.frame.size.width;
    if(isShare== NO)
    {
        self.popTbl.hidden = NO;
        self.commonArray = [[NSMutableArray alloc]init];
        self.commonArray = self.sharetouserArray;
        [self.popTbl reloadData];
        isShare = YES;
    }
    else
    {
        self.popTbl.hidden = YES;
        isCategory = NO;
        isPlayer = NO;
        isShare = NO;
        
    }
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
    
    self.datePicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,self.date_view.frame.origin.y-150,self.view.frame.size.width,100)];
    
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
-(IBAction)didClickCameraBtn:(id)sender
{
    NSLog(@"dfmkcv");
    UIImagePickerController *videoPicker = [[UIImagePickerController alloc] init];
    videoPicker.delegate = self; // ensure you set the delegate so when a video is chosen the right method can be called
    
    videoPicker.modalPresentationStyle = UIModalPresentationCurrentContext;
    // This code ensures only videos are shown to the end user
    videoPicker.mediaTypes = @[(NSString*)kUTTypeMovie, (NSString*)kUTTypeAVIMovie, (NSString*)kUTTypeVideo, (NSString*)kUTTypeMPEG4];
    
    videoPicker.videoQuality = UIImagePickerControllerQualityTypeHigh;
    [self presentViewController:videoPicker animated:YES completion:nil];
}
-(IBAction)didClickGalleryBtn:(id)sender
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    
    
//    UIAlertController* alert =[UIAlertController alertControllerWithTitle:APP_NAME message:@"Choose Your Attachment" preferredStyle:UIAlertControllerStyleActionSheet];
//    UIAlertAction* CameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        imagePickerController.sourceType =  UIImagePickerControllerSourceTypeCamera;
//        imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
//        
//        [self presentViewController:imagePickerController animated:YES completion:nil];
//        
        
  //  }];
//    UIAlertAction* GalleryAction = [UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:YES completion:nil];
        
        
//    }];
//    UIAlertAction* CancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//
    
    
}
#pragma mark UIImagePickerController Delegates


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info

{
    
    NSLog(@"info[UIImagePickerControllerMediaType] %@",info[UIImagePickerControllerMediaType]);
    UIImage* image;
    NSData* imgDatas;
    if([info[UIImagePickerControllerMediaType] isEqualToString:@"public.image"])
    {
        
        NSString* str = info[@"UIImagePickerControllerImageURL"];
        
        imgDatas = [[NSData alloc] initWithContentsOfFile:str];
        imgFileName = [[info valueForKey:@"UIImagePickerControllerImageURL"] lastPathComponent];
        
    }
    else
    {
        NSURL* url = (NSURL *)[info valueForKey:UIImagePickerControllerMediaURL];
        imgDatas = [[NSData alloc] initWithContentsOfURL:url];
        
        
        imgFileName = [[info valueForKey:@"UIImagePickerControllerMediaURL"] lastPathComponent];
        
        image = info[UIImagePickerControllerOriginalImage];
    }
    
    
    imgData = [imgDatas base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    if (!imgFileName) {
        
        imgFileName = [self getFileName];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        _ImgViewBottomConst.constant = _imgView.frame.size.height;
        [_imgView updateConstraintsIfNeeded];
        _currentlySelectedImage.image = image;
        
    }];
    
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    self.view.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height-50);

    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

-(NSString *)getFileName
{
    
    /*
     EEEE, MMM d, yyyy
     */
    
    NSString* filename;
    NSDateFormatter* df = [NSDateFormatter new];
    [df setDateFormat:@"EEEE_MMM_d_yyyy_HH_mm_ss"];
    
    filename = [df stringFromDate:[NSDate date]];
    filename=[filename stringByAppendingPathExtension:@"png"];
    NSLog(@"file name %@ ",filename);
    
    return filename;
}
- (void)showAnimate
{
    self.popTbl.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.popTbl.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.popTbl.alpha = 1;
        self.popTbl.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)removeAnimate
{
    [UIView animateWithDuration:.25 animations:^{
        self.popTbl.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.popTbl.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            // [self.popTblView removeFromSuperview];
            self.popTbl.hidden = YES;
        }
    }];
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
    if(isShare == YES)
    {
        
            
            static NSString *CRTableViewCellIdentifier = @"cellIdentifier";
            CRTableViewCell *cell = (CRTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CRTableViewCellIdentifier];
            
            if (cell == nil) {
                cell = [[CRTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CRTableViewCellIdentifier];
            }
            
            plyCode = [self.commonArray objectAtIndex:indexPath.row];
            NSString *text = [[self.commonArray valueForKey:@"sharedUserName"] objectAtIndex:[indexPath row]];
            cell.isSelected = [self.selectedMarks containsObject:plyCode] ? YES : NO;
            cell.textLabel.text = text;
            return cell;
        

    }
    else{
    static NSString *MyIdentifier = @"CategoryCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
    }
    NSString * selectStr;
    if(isPlayer)
    {
        selectStr = [[self.commonArray valueForKey:@"PlayerName"] objectAtIndex:indexPath.row];
    }
    else if (isCategory)
    {
        selectStr = [[self.commonArray valueForKey:@"CategoryName"] objectAtIndex:indexPath.row];

    }
    else if (isShare)
    {
        selectStr = [[self.commonArray valueForKey:@"sharedUserName"] objectAtIndex:indexPath.row];

    }
    cell.textLabel.text = selectStr;
    return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(isPlayer == YES)
    {
        self.player_lbl.text = [[self.commonArray valueForKey:@"PlayerName"] objectAtIndex:indexPath.row];
        isPlayer = NO;
    }
    else if (isCategory == YES)
    {
        self.category_lbl.text = [[self.commonArray valueForKey:@"CategoryName"] objectAtIndex:indexPath.row];
        isCategory = NO;
    }
    if(isShare == YES)
    {
        
        plyCode = [self.commonArray objectAtIndex:indexPath.row];
        if ([self.selectedMarks containsObject:plyCode])// Is selected?
            [self.selectedMarks removeObject:plyCode];
        else
            [self.selectedMarks addObject:plyCode];
        
        static NSString *CRTableViewCellIdentifier = @"cellIdentifier";
        
        CRTableViewCell *cell = (CRTableViewCell *)[self.popTbl dequeueReusableCellWithIdentifier:CRTableViewCellIdentifier];
        cell.isSelected = [self.selectedMarks containsObject:plyCode] ? YES : NO;
        
        
        
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        int a = self.selectedMarks.count;
        if(a == 0)
        {
            //NSString *b = [NSString stringWithFormat:@"%d", a];
            self.shareuser_lbl.text = @"";
        }
        if(a == 1)
        {
            //NSString *b = [NSString stringWithFormat:@"%d", a];
            self.shareuser_lbl.text = [NSString stringWithFormat:@"%d item selected", a];
        }
        else
        {
            self.shareuser_lbl.text = [NSString stringWithFormat:@"%d items selected", a];
        }
        isShare = NO;
    }
    
    self.popTbl.hidden = YES;
    //self.catagory_lbl.text = [[self.commonArray valueForKey:@"CategoryName"] objectAtIndex:indexPath.row];
    
    
}

-(void)sendReplyMessageWebService
{
    
    if(![COMMON isInternetReachable])
        return;
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    
    
//    [dic setObject:_txtview.text forKey:@"newmessage"];
//    [dic setObject:imgData forKey:@"newmessagephoto"];
//    [dic setObject:imgFileName  forKey:@"fileName"];
//
//
//    if([AppCommon GetClientCode])
//    {
//        [dic setObject:[AppCommon GetClientCode] forKey:@"Clientcode"];
//    }
//    else
//    {
//        [AppCommon showAlertWithMessage:@"Client code missing in loadMessage API"];
//        return;
//    }
//
//    if([AppCommon GetUsercode])
//    {
//        [dic setObject:[AppCommon GetUsercode] forKey:@"UserCode"];
//    }
//    else
//    {
//        [AppCommon showAlertWithMessage:@"UserCode missing in loadMessage API"];
//        return;
//    }
//    if(self.CommID)
//    {
//        [dic setObject:_CommID forKey:@"commId"];
//    }
//    else
//    {
//        [AppCommon showAlertWithMessage:@"commId missing in loadMessage API"];
//        return;
//    }
    
    
    [AppCommon showLoading];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString * url = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",SendMessageKey]];
    
    NSLog(@"USED API URL %@",url);
    NSLog(@"USED PARAMS %@ ",dic);
    NSURL *filePath = [NSURL fileURLWithPath:@"file://path/to/image.png"];
    
    [manager POST:url parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:filePath name:@"image" error:nil];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@", responseObject);
        [self resetImageData];
        
        mainArray = [NSMutableArray new];
        mainArray = responseObject;
        chatArray = [NSMutableArray new];
        chatArray = [mainArray valueForKey:@"lstallmessages"];
        dispatch_async(dispatch_get_main_queue(), ^{
            _ImgViewBottomConst.constant = -_imgView.frame.size.height;
            [_imgView updateConstraintsIfNeeded];
            _currentlySelectedImage.image = nil;
            
            if (chatArray.count == 0) {
                return ;
            }
            
           // [self.tblChatList insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:chatArray.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
            
            //[self.tblChatList scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:chatArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
        });
        
        [AppCommon hideLoading];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [AppCommon hideLoading];
        [self resetImageData];
        NSLog(@"SEND MESSAGE ERROR %@ ",error.description);
        //[COMMON webServiceFailureError];
    }];
    
    
}
-(void)resetImageData
{
    imgData = @"";
    imgFileName = @"";
    dispatch_async(dispatch_get_main_queue(), ^{
       // _txtview.text = @"";
    });
    
}
@end
