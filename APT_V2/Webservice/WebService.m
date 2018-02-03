//
//  WebService.m
//  UPCA
//
//  Created by Mac on 11/05/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "WebService.h"


static const NSString *ServicePost   = @"POST";
static const NSString *ServiceGet    = @"GET";
static const NSString *ServicePut    = @"PUT";
static const NSString *ServiceDelete = @"DELETE";

static const NSString *ServiceContentJSON = @"application/json";
static const NSString *ServiceContentFORM = @"application/x-www-form-urlencoded; charset=UTF-8";
static NSString       *ServiceMimeType    = @"image/jpeg";


@interface WebService ()
{
    NSString *urlString;
}
@end

@implementation WebService

- (id)init {
    self = [super init];
    if (self) {
        
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/json", @"text/javascript", @"text/plain", @"application/json",@"image/png",nil];
    }
    return self;
}

+ (WebService *)service {
    return [[WebService alloc] init];
}

-(void)getLogin :(NSString *) loginValue:(NSString *)userName :(NSString *)password success:(WebserviceRequestSuccessHandler)success failure:(WebserviceRequestFailureHandler)failure
{
    urlString = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@/%@/%@",loginValue,userName,password]];
    NSLog(@"urlString = %@",urlString);
    
    
    [self sendRequestWithURLString:urlString
                     andParameters:nil
                            method:ServicePost
           completionSucessHandler:success
          completionFailureHandler:failure];
}
-(void)getAssesmentlist :(NSString *)asmtlist :(NSString *)clientCode :(NSString *)moduleCode :(NSString *)createdby success:(WebserviceRequestSuccessHandler)success
         failure:(WebserviceRequestFailureHandler)failure
{
    urlString = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@/%@/%@/%@",asmtlist,clientCode,moduleCode,createdby]];
    NSLog(@"urlString = %@",urlString);
    
    
    [self sendRequestWithURLString:urlString
                     andParameters:nil
                            method:ServiceGet
           completionSucessHandler:success
          completionFailureHandler:failure];
}
-(void)getmetacodelist :(NSString *)codelist :(NSString *)clientCode :(NSString *)rcCode success:(WebserviceRequestSuccessHandler)success
                failure:(WebserviceRequestFailureHandler)failure
{
    urlString = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@/%@/%@",codelist,clientCode,rcCode]];
    NSLog(@"urlString = %@",urlString);
    
    
    [self sendRequestWithURLString:urlString
                     andParameters:nil
                            method:ServiceGet
           completionSucessHandler:success
          completionFailureHandler:failure];
}

-(void)getdatelist :(NSString *)codelist :(NSString *)playercode :(NSString *)date success:(WebserviceRequestSuccessHandler)success
            failure:(WebserviceRequestFailureHandler)failure
{
    urlString = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@/%@/%@",codelist,playercode,date]];
    NSLog(@"urlString = %@",urlString);
    
    
    [self sendRequestWithURLString:urlString
                     andParameters:nil
                            method:ServiceGet
           completionSucessHandler:success
          completionFailureHandler:failure];
}


-(void)submit :(NSString *)codelist :(NSString *)clientCode :(NSString *)usercode :(NSString *)date :(NSString *)playercode :(NSString *)code1 :(NSString *)code2 :(NSString *)code3 :(NSString *)code4 success:(WebserviceRequestSuccessHandler)success
       failure:(WebserviceRequestFailureHandler)failure
{
    urlString = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@/%@/%@/%@/%@/%@/%@/%@/%@",codelist,clientCode,usercode,date,playercode,code1,code2,code3,code4]];
    NSLog(@"urlString = %@",urlString);
    
    
    [self sendRequestWithURLString:urlString
                     andParameters:nil
                            method:ServiceGet
           completionSucessHandler:success
          completionFailureHandler:failure];
}

-(void)getupdate :(NSString *)updatelist :(NSString *)usercode :(NSString *)workload :(NSString *)date :(NSString *)playercode :(NSString *)code1 :(NSString *)code2 :(NSString *)code3 :(NSString *)code4 success:(WebserviceRequestSuccessHandler)success
          failure:(WebserviceRequestFailureHandler)failure
{
    urlString = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@/%@/%@/%@/%@/%@/%@/%@/%@",updatelist,usercode,workload,date,playercode,code1,code2,code3,code4]];
    NSLog(@"urlString = %@",urlString);
    
    
    [self sendRequestWithURLString:urlString
                     andParameters:nil
                            method:ServiceGet
           completionSucessHandler:success
          completionFailureHandler:failure];
}
-(void)getremove :(NSString *)removelist :(NSString *)usercode :(NSString *)workload success:(WebserviceRequestSuccessHandler)success
          failure:(WebserviceRequestFailureHandler)failure
{
    urlString = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@/%@/%@",removelist,usercode,workload]];
    NSLog(@"urlString = %@",urlString);
    
    
    [self sendRequestWithURLString:urlString
                     andParameters:nil
                            method:ServiceGet
           completionSucessHandler:success
          completionFailureHandler:failure];
}
#pragma FetchInjury
-(void)getFetchinjuryList:(NSString *)fetchInjury:(NSString*)usercode success:(WebserviceRequestSuccessHandler)success
                  failure:(WebserviceRequestFailureHandler)failure
{
    urlString = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@/%@",fetchInjury,usercode]];
    NSLog(@"urlString = %@",urlString);
    
    
    [self sendRequestWithURLString:urlString
                     andParameters:nil
                            method:ServiceGet
           completionSucessHandler:success
          completionFailureHandler:failure];
}

-(void)getTRLDetails :(NSString *)list :(NSString *)usercode  success:(WebserviceRequestSuccessHandler)success
              failure:(WebserviceRequestFailureHandler)failure
{
    urlString = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@/%@",list,usercode]];
    NSLog(@"urlString = %@",urlString);
    
    
    [self sendRequestWithURLString:urlString
                     andParameters:nil
                            method:ServiceGet
           completionSucessHandler:success
          completionFailureHandler:failure];
}

-(void)getFetchMetadataList:(NSString *)fetchmetadata success:(WebserviceRequestSuccessHandler)success
                    failure:(WebserviceRequestFailureHandler)failure
{
    urlString = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",fetchmetadata]];
    NSLog(@"urlString = %@",urlString);
    
    
    [self sendRequestWithURLString:urlString
                     andParameters:nil
                            method:ServiceGet
           completionSucessHandler:success
          completionFailureHandler:failure];
}

-(void)getFetchGameandTeam :(NSString *)fetchgameandTeam :(NSString *)cliendcode success:(WebserviceRequestSuccessHandler)success
                    failure:(WebserviceRequestFailureHandler)failure
{
    urlString = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@/%@",fetchgameandTeam,cliendcode]];
    NSLog(@"urlString = %@",urlString);
    
    
    [self sendRequestWithURLString:urlString
                     andParameters:nil
                            method:ServiceGet
           completionSucessHandler:success
          completionFailureHandler:failure];
}
-(void)getinjuryDelete :(NSString *)deleteInjury :(NSString *)selectinjurycode :(NSString *)usercode success:(WebserviceRequestSuccessHandler)success failure:(WebserviceRequestFailureHandler)failure
{
    urlString = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@/%@/%@",deleteInjury,selectinjurycode,usercode]];
    NSLog(@"urlString = %@",urlString);
    
    
    [self sendRequestWithURLString:urlString
                     andParameters:nil
                            method:ServiceGet
           completionSucessHandler:success
          completionFailureHandler:failure];
}
-(void)RemoveDtls :(NSString *)list :(NSString *)usercode :(NSString *)playercode:(NSString *)Workcode:(NSString *)dd:(NSString *)metaCode success:(WebserviceRequestSuccessHandler)success
           failure:(WebserviceRequestFailureHandler)failure
{
    urlString = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@/%@/%@/%@/%@/%@",list,usercode,playercode,Workcode,dd,metaCode]];
    NSLog(@"urlString = %@",urlString);
    
    
    [self sendRequestWithURLString:urlString
                     andParameters:nil
                            method:ServiceGet
           completionSucessHandler:success
          completionFailureHandler:failure];
}

-(void)dateTrl :(NSString *)list :(NSString *)date :(NSString *)plycode success:(WebserviceRequestSuccessHandler)success
        failure:(WebserviceRequestFailureHandler)failure
{
    urlString = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@/%@/%@",list,date,plycode]];
    NSLog(@"urlString = %@",urlString);
    
    
    [self sendRequestWithURLString:urlString
                     andParameters:nil
                            method:ServiceGet
           completionSucessHandler:success
          completionFailureHandler:failure];
}

-(void)AddActivityDetails :(NSString *)list :(NSString *)usercode :(NSString *)date :(NSString *)plycode :(NSString *)code1  :(NSString *)code2 :(NSString *)time :(NSString *)balls success:(WebserviceRequestSuccessHandler)success
                   failure:(WebserviceRequestFailureHandler)failure
{
    urlString = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@/%@/%@/%@/%@/%@/%@/%@",list,usercode,date,plycode,code1,code2,time,balls]];
    NSLog(@"urlString = %@",urlString);
    
    
    [self sendRequestWithURLString:urlString
                     andParameters:nil
                            method:ServiceGet
           completionSucessHandler:success
          completionFailureHandler:failure];
}

-(void)FilterReport :(NSString *)list :(NSString *)value1 :(NSString *)usercode :(NSString *)value2  success:(WebserviceRequestSuccessHandler)success
             failure:(WebserviceRequestFailureHandler)failure
{
    urlString = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@/%@/%@/%@",list,value1,usercode,value2]];
    NSLog(@"urlString = %@",urlString);
    
    
    [self sendRequestWithURLString:urlString
                     andParameters:nil
                            method:ServiceGet
           completionSucessHandler:success
          completionFailureHandler:failure];
}
-(void)SecFilterReport :(NSString *)list :(NSString *)usercode  success:(WebserviceRequestSuccessHandler)success
                failure:(WebserviceRequestFailureHandler)failure
{
    urlString = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@/%@",list,usercode]];
    NSLog(@"urlString = %@",urlString);
    
    
    [self sendRequestWithURLString:urlString
                     andParameters:nil
                            method:ServiceGet
           completionSucessHandler:success
          completionFailureHandler:failure];
}

-(void)getGraphsDetails :(NSString *)list :(NSString *)clientcode :(NSString *)strDate :(NSString *)enddate :(NSString *)playerCode :(NSString *)Axcode1 :(NSString *)Axcode2  success:(WebserviceRequestSuccessHandler)success
                 failure:(WebserviceRequestFailureHandler)failure
{
    urlString = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@/%@/%@/%@/%@/%@/%@",list,clientcode,strDate,enddate,playerCode,Axcode1,Axcode2]];
    NSLog(@"urlString = %@",urlString);
    
    
    [self sendRequestWithURLString:urlString
                     andParameters:nil
                            method:ServiceGet
           completionSucessHandler:success
          completionFailureHandler:failure];
}

-(void)GetPlayers:(NSString *)list :(NSString *)clientcode   success:(WebserviceRequestSuccessHandler)success
                 failure:(WebserviceRequestFailureHandler)failure
{
    urlString = [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@/%@",list,clientcode]];
    NSLog(@"urlString = %@",urlString);
    
    
    [self sendRequestWithURLString:urlString
                     andParameters:nil
                            method:ServiceGet
           completionSucessHandler:success
          completionFailureHandler:failure];
}


#pragma mark - Helpers

- (void)sendRequestWithURLString:(NSString *)url
                   andParameters:(NSDictionary *)parameters
                          method:(const NSString *)method
         completionSucessHandler:(WebserviceRequestSuccessHandler)sucesshandler
        completionFailureHandler:(WebserviceRequestFailureHandler)failurehandler
{
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    if (method == ServiceGet)
    {
        [self GET:url parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseDict)
         {
             if (sucesshandler){
                 //if([responseDict objectForKey:@"error"]){
                // }
                 sucesshandler(operation,responseDict);
             }
         }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             if (failurehandler){
                 NSLog(@"response ");
                 failurehandler(operation, error);
             }
         }];
    }
    else
    {
        [self POST:url parameters:parameters
           success:^(AFHTTPRequestOperation *operation, id responseDict)
         {
             if (sucesshandler){
                 //if([responseDict objectForKey:@"error"]){
                 //}
                 sucesshandler(operation,responseDict);
             }
         }
           failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             if (failurehandler) failurehandler(operation,error);
         }];
    }
}

-(void)cancelRequest
{
    [self.operationQueue cancelAllOperations];
}


@end
