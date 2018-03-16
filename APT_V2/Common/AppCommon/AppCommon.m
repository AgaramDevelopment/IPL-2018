//
//  AppCommon.m
//  AlphaProTracker
//
//  Created by Mac on 21/08/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "AppCommon.h"
#import "Header.h"

@implementation AppCommon
AppCommon *sharedCommon = nil;

+ (AppCommon *)common {
    
    if (!sharedCommon) {
        
        sharedCommon = [[self alloc] init];
    }
    return sharedCommon;
}

- (id)init {
    
    return self;
}

#pragma mark Reachable

-(BOOL) isInternetReachable
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus != NotReachable) {
        NSLog(@"Data Connected");
        return YES;
    }
    else {
        [self reachabilityNotReachableAlert];
        return NO;
    }
}

-(void)reachabilityNotReachableAlert{
    [AppCommon hideLoading];
    [AppCommon showAlertWithMessage:@"It appears that you have lost network connectivity. Please check your network settings!"];
}

-(void)webServiceFailureError:(NSError *)error
{
    [AppCommon hideLoading];
    [AppCommon showAlertWithMessage:error.localizedDescription];
}

-(void)getIPLCompetetion
{
    if(![COMMON isInternetReachable])
        return;

    
//    [AppCommon showLoading];
    
    WebService* objWebservice = [[WebService alloc]init];
    [objWebservice getIPLCompeteionCodesuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(responseObject >0)
        {
            appDel.ArrayCompetition = [NSMutableArray new];
            appDel.ArrayCompetition = responseObject;
            
//            NSSet* set = [NSSet setValue:responseObject forKey:@"CompetitionName"];
//            NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:responseObject];
//            NSArray *arrayWithoutDuplicates = [orderedSet array];

            
            NSString* Competetioncode = [[appDel.ArrayCompetition firstObject] valueForKey:@"CompetitionCode"];
            NSString* CompetetionName = [[appDel.ArrayCompetition firstObject] valueForKey:@"CompetitionName"];
            NSLog(@"IPL COMPETETION %@ ",responseObject);
            [[NSUserDefaults standardUserDefaults] setValue:CompetetionName forKey:@"SelectedCompetitionName"];
            [[NSUserDefaults standardUserDefaults] setValue:Competetioncode forKey:@"SelectedCompetitionCode"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            


        }
//        [AppCommon hideLoading];
    } failure:^(AFHTTPRequestOperation *operation, id error) {
        NSLog(@"failed");
        [COMMON webServiceFailureError:error];
    }];

}

+(NSString *)getCurrentCompetitionCode
{
   return [[NSUserDefaults standardUserDefaults] stringForKey:@"SelectedCompetitionCode"];
}

+(NSString *)getCurrentCompetitionName
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"SelectedCompetitionName"];
}

+(NSString *)getCurrentTeamCode
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"SelectedTeamCode"];
}

+(NSString *)getCurrentTeamName
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"SelectedTeamName"];
}

-(void)getIPLteams
{
    if(![COMMON isInternetReachable])
        return;

    
//    [AppCommon showLoading];
    
    WebService* objWebservice = [[WebService alloc]init];
    [objWebservice getIPLTeamCodessuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(responseObject >0)
        {
//            NSOrderedSet *orderedSet = [NSOrderedSet orderedSetWithArray:responseObject];
//            NSArray *arrayWithoutDuplicates = [orderedSet array];

            
            appDel.ArrayMainTeams = [NSMutableArray new];
            appDel.ArrayMainTeams = responseObject;
            
//            appDel.ArrayCompetition = [NSMutableArray new];
//            appDel.ArrayCompetition = responseObject;

            NSLog(@"IPL TEAMS %@ ",responseObject);
            NSString* Teamcode = [[appDel.ArrayTeam firstObject] valueForKey:@"TeamCode"];
            NSString* TeamName = [[appDel.ArrayTeam firstObject] valueForKey:@"TeamName"];
            
            [[NSUserDefaults standardUserDefaults] setValue:TeamName forKey:@"SelectedTeamName"];
            [[NSUserDefaults standardUserDefaults] setValue:Teamcode forKey:@"SelectedTeamCode"];
            
//            NSLog(@"IPL COMPETETION %@ ",responseObject);
//            NSString* Competetioncode = [[appDel.ArrayTeam objectAtIndex:9] valueForKey:@"CompetitionCode"];
//            NSString* CompetetionName = [[appDel.ArrayTeam objectAtIndex:9] valueForKey:@"CompetitionName"];
//
//            [[NSUserDefaults standardUserDefaults] setValue:CompetetionName forKey:@"SelectedCompetitionName"];
//            [[NSUserDefaults standardUserDefaults] setValue:Competetioncode forKey:@"SelectedCompetitionCode"];
//            [[NSUserDefaults standardUserDefaults] synchronize];

            
        }
//        [AppCommon hideLoading];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self getIPLCompetetion];
        });

    } failure:^(AFHTTPRequestOperation *operation, id error) {
//        [AppCommon hideLoading];
        NSLog(@"failed");
        [COMMON webServiceFailureError:error];

    }];
    
}


#pragma mark - get usercode,clientcode,usereferencecode

+(NSString *)GetUsercode
{
    NSString * usercode = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
    return usercode;
}

+(NSString *)GetUserName
{
    NSString * userName = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserName"];
    return userName;
}

+(NSString *) GetClientCode
{
    NSString * clientcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    return clientcode;
}
+(NSString *) GetuserReference
{
    NSString * userreference =  [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
    return userreference;
}

+(NSString *)GetUserRoleName
{
    NSString * userreference =  [[NSUserDefaults standardUserDefaults]stringForKey:@"RoleName"];
    return userreference;
}

+(NSString *)GetUserRoleCode
{
    NSString * userreference =  [[NSUserDefaults standardUserDefaults]stringForKey:@"RoleCode"];
    return userreference;
}

+(BOOL)isCoach
{
   //  ROL0000002 player code
    
    return ([[AppCommon GetUserRoleCode] isEqualToString:@"ROL0000003"]);
}

#pragma mark - Get Height of Control

- (CGSize)getControlHeight:(NSString *)string withFontName:(NSString *)fontName ofSize:(NSInteger)size withSize:(CGSize)LabelWidth {
    CGSize maxSize = LabelWidth;
    CGSize dataHeight;
    
    UIFont *font = [UIFont fontWithName:fontName size:size];
    //    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //    paragraphStyle.paragraphSpacing = 50 * font.lineHeight;
    NSString *version = [[UIDevice currentDevice] systemVersion];
    
    if ([version floatValue]>=7.0) {
        CGRect textRect = [string boundingRectWithSize:maxSize
                                               options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading
                                            attributes:@{NSFontAttributeName:font}
                                               context:nil];
        
        
        dataHeight = CGSizeMake(textRect.size.width , textRect.size.height+20);
        
    }
    
    return CGSizeMake(dataHeight.width, dataHeight.height);
}


+(NSString *)getFileType:(NSString *)filePath
{
    NSString* fileExtension = [[filePath pathExtension]lowercaseString];
    if ([fileExtension isEqualToString:@"png"] || [fileExtension isEqualToString:@"jpeg"] || [fileExtension isEqualToString:@"jpg"] ) {
        return @"img";
    }
    else if([fileExtension isEqualToString:@"pdf"]){
        return @"pdf";
    }
    return @"video";
}

+(void)showAlertWithMessage:(NSString *)message
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:APP_NAME message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* action = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [appDel.window.rootViewController presentViewController:alert animated:YES completion:nil];
}

+(void)showLoading
{
//    if (appDel.window.subviews containsObject:) {
//
//    }
    NSLog(@"%@ ",appDel.window.subviews);
    
//    [MBProgressHUD showHUDAddedTo:appDel.window animated:YES];
//    [MBProgressHUD]
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:appDel.window animated:YES];
    [hud setMode:MBProgressHUDModeIndeterminate];
    hud.label.text = @"Please wait";
    [hud setBackgroundColor:[UIColor clearColor]];
    
}

+(void)hideLoading
{
//    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:appDel.window animated:YES];
//    });
    
}

+(UIColor*)colorWithHexString:(NSString*)hex
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

+ (NSString *)syncId
{
    return @"Sync";
}

+(void)getTeamAndPlayerCode
{
    NSString *URLString =  URL_FOR_RESOURCE(@"FETCH_IPLPLAYERS");
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.requestSerializer = requestSerializer;
    
    [manager GET:URLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"response ; %@",responseObject);
        
        if(responseObject >0)
        {
            /*
             {
             "TeamCode": "TEA0000008",
             "PlayerCode": "PYC0000277",
             "PlayerName": "AAKASH CHOPRA"
             },
             
             */
            
            appDel.ArrayIPL_teamplayers = [NSMutableArray new];
            appDel.ArrayIPL_teamplayers = responseObject;
        }
        
        
        [AppCommon hideLoading];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failed");
        [COMMON webServiceFailureError:error];
        [AppCommon hideLoading];
        
    }];
    
}

+(NSString *)checkNull:(NSString *)_value
{
    if ([_value isEqual:[NSNull null]] || _value == nil || [_value isEqual:@"<null>"]) {
        _value=@"";
    }
    return _value;
}

-(void)getCorrespondingTeamName:(NSString *)competetionName
{
    
    
    if (![[NSUserDefaults standardUserDefaults] stringForKey:@"SelectedCompetitionName"]) {
        NSLog(@"Please select Competetion");
    }
    
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"CompetitionName == %@", competetionName];
    NSArray* result = [appDel.ArrayMainTeams filteredArrayUsingPredicate:resultPredicate];
    if (result.count > 0) {
        appDel.ArrayTeam = [NSMutableArray new];
        [appDel.ArrayTeam addObjectsFromArray:result];
    }
    else
    {
        NSString* msg = [NSString stringWithFormat:@"NO Teams Founds in %@",competetionName];
        [AppCommon showAlertWithMessage:msg];
        return ;
    }
    
}

@end

