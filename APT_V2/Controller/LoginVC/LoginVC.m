//
//  LoginVC.m
//  AlphaProTracker
//
//  Created by Lexicon on 22/08/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "LoginVC.h"
#import "Header.h"

@interface LoginVC ()
{
    
}
@property (weak,nonatomic)  IBOutlet UIView *commonview;
@property (weak,nonatomic)  IBOutlet UIView *usernameview;
@property (weak,nonatomic)  IBOutlet UIView *passwordview;

@property (weak,nonatomic)  IBOutlet UITextField *userTxt;
@property (weak,nonatomic) IBOutlet UITextField * passwordTxt;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * commonViewHeight;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * usernameyposition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * paswordyposition;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * signBtnyposition;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint * liftsidewidth;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint * rightsidewidth;

@end



@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    if(!IS_IPHONE_DEVICE)
    {
        self.commonViewHeight.constant =self.view.frame.size.height/2;
        self.liftsidewidth.constant    =self.view.frame.size.width/7;
        self.rightsidewidth.constant  =self.view.frame.size.width/7;
        self.usernameyposition.constant =self.commonview.frame.size.height/4;
        self.paswordyposition.constant  =self.usernameview.frame.origin.y+5;
        self.signBtnyposition.constant  =self.passwordview.frame.origin.y-30;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)didClickSubmitBtnAction:(id)sender
{
    
    [self validation];
    
    //    objpalyer.selectPlayerimg = [[NSUserDefaults standardUserDefaults]stringForKey:@"PhotoPath"];
}
-(void)validation
{
    if([self.userTxt.text isEqualToString:@""] || self.userTxt.text==nil)
    {
        [AppCommon showAlertWithMessage:@"Please Enter UserName"];
    }
    else if ([self.passwordTxt.text isEqualToString:@""] || self.passwordTxt.text==nil)
    {
        [AppCommon showAlertWithMessage:@"Please Enter Password"];
    }
    else
    {
        [self LoginWebservice:self.userTxt.text:self.passwordTxt.text];
    }
}

-(void)LoginWebservice :(NSString *) username :(NSString *) password
{
    if(![COMMON isInternetReachable])
        return;
    
    [AppCommon showLoading];
    //        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",LoginKey]];
    NSString *URLString =  URL_FOR_RESOURCE(LoginKey);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.requestSerializer = requestSerializer;
    
    
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    if(username)   [dic    setObject:username     forKey:@"username"];
    if(password)   [dic    setObject:password     forKey:@"password"];
    
    NSLog(@"parameters : %@",dic);
    [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response ; %@",responseObject);
        
        if([[responseObject valueForKey:@"Status"] isEqualToString:@"PSUCCESS"] && [responseObject valueForKey:@"Status"] != NULL)
        {
            NSDictionary * objRole =[responseObject valueForKey:@"Roles"];
            
            NSString * objRoleCode =[[objRole valueForKey:@"Rolecode"] objectAtIndex:0];
            
            NSString * objRoleName =[[objRole valueForKey:@"RoleName"] objectAtIndex:0];
            [[NSUserDefaults standardUserDefaults] setObject:[responseObject valueForKey:@"UserCode"] forKey:@"UserCode"];
            [[NSUserDefaults standardUserDefaults] setObject:[responseObject valueForKey:@"ClientCode"] forKey:@"ClientCode"];
            [[NSUserDefaults standardUserDefaults] setObject:[responseObject valueForKey:@"Userreferencecode"] forKey:@"Userreferencecode"];
            
            [[NSUserDefaults standardUserDefaults] setObject:[responseObject valueForKey:@"Username"] forKey:@"UserName"];
            [[NSUserDefaults standardUserDefaults] setObject:[responseObject valueForKey:@"AssociationCode"]  forKey:@"AssociationCode"];
            
            [[NSUserDefaults standardUserDefaults] setObject:[responseObject valueForKey:@"PhotoPath"] forKey:@"PhotoPath"];
            [[NSUserDefaults standardUserDefaults] setObject:objRoleName forKey:@"RoleName"];
            
            [[NSUserDefaults standardUserDefaults] setObject:objRoleCode forKey:@"RoleCode"];
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            //                ViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"frontViewController"];
            ViewController* vc = [ViewController new];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else{
            [AppCommon showAlertWithMessage:@"Invalid Login"];
        }
        
        [AppCommon hideLoading];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed");
        [COMMON webServiceFailureError:error];
        [AppCommon hideLoading];
        
    }];
    
}

- (IBAction)switchAction:(id)sender {
    
    self.passwordTxt.secureTextEntry= ![sender isOn];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view resignFirstResponder];
    [_passwordTxt resignFirstResponder];
    [_userTxt resignFirstResponder];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField.returnKeyType == UIReturnKeyNext && _userTxt.isFirstResponder)
    {
        [_userTxt resignFirstResponder];
        [_passwordTxt becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    
    return YES;
}
@end

