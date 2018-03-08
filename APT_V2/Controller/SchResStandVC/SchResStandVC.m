//
//  SchResStandVC.m
//  APT_V2
//
//  Created by Apple on 06/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "SchResStandVC.h"
#import "Config.h"
#import "HomeScreenStandingsVC.h"
#import "CustomNavigation.h"
#import "SWRevealViewController.h"
#import "WebService.h"
#import "AppCommon.h"
#import "VideoGalleryVC.h"
#import "ScoreCardVC.h"
#import "VideoPlayerViewController.h"
#import "HomeScreenStandingsVC.h"
#import "TabbarVC.h"


@interface SchResStandVC ()
{
    VideoGalleryVC *objVideo;
    NSString *displayMatchCode;
    VideoPlayerViewController * videoPlayerVC;
    HomeScreenStandingsVC *objStands;
    TabbarVC *objtab;
    SWRevealViewController *revealController;
    NSMutableArray *objarray;
    
    //AppDelegate *objAppDel;
}

@property (strong, nonatomic)  NSMutableArray *commonArray;
@property (strong, nonatomic)  NSMutableArray *commonArray2;

@end

@implementation SchResStandVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //[self customnavigationmethod];

    //[self.scheduleCollectionView registerNib:[UINib nibWithNibName:@"ScheduleCell" bundle:nil] forCellWithReuseIdentifier:@"cellid"];
    [self.resultCollectionView registerNib:[UINib nibWithNibName:@"ResultCell" bundle:nil] forCellWithReuseIdentifier:@"cellno"];
    [self.scheduleCollectionView registerNib:[UINib nibWithNibName:@"ResultCell" bundle:nil] forCellWithReuseIdentifier:@"cellno"];
    

    
    objVideo = [[VideoGalleryVC alloc] initWithNibName:@"VideoGalleryVC" bundle:nil];
    objVideo.view.frame = CGRectMake(0, 0, self.videoView.bounds.size.width, self.videoView.bounds.size.height);
    [self.videoView addSubview:objVideo.view];
    
    
    objStands = [[HomeScreenStandingsVC alloc] initWithNibName:@"HomeScreenStandingsVC" bundle:nil];
    objStands.view.frame = CGRectMake(0, 0, self.standingsView.bounds.size.width, self.standingsView.bounds.size.height);
    [self.standingsView addSubview:objStands.view];
    
   
     //self.scroll.contentSize = CGSizeMake(self.scroll.frame.size.width, self.commonView.frame.size.height);
    
    self.scroll.contentSize =  self.commonView.frame.size;
    
    [self ScheduleWebservice];
    [self FixturesWebservice];

}



-(void)ScheduleWebservice
{
 
    if([COMMON isInternetReachable])
    {
        [AppCommon showLoading];
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",ScheduleKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        NSString *ClientCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
        NSString *UserrefCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
        NSString *playerCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
        
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(ClientCode)   [dic    setObject:ClientCode     forKey:@"ClientCode"];
        if(UserrefCode)   [dic    setObject:UserrefCode     forKey:@"UserrefCode"];
        if(playerCode)   [dic    setObject:playerCode     forKey:@"PlayerCode"];
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                NSMutableArray *scheduleArray = [responseObject valueForKey:@"EventDetails"];
                NSMutableArray *resultArray = [responseObject valueForKey:@"ResultsValues"];
                
                self.commonArray = scheduleArray;
                self.commonArray2 = resultArray;
                
                
                //[self.scheduleCollectionView reloadData];
                [self.resultCollectionView reloadData];
            }
            
            [AppCommon hideLoading];
            [self.view setUserInteractionEnabled:YES];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed");
             [AppCommon hideLoading];
            [COMMON webServiceFailureError:error];
            [self.view setUserInteractionEnabled:YES];
            
        }];
    }
    
}





- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //return self.commonArray.count;
    
     if(collectionView == self.scheduleCollectionView)
     {
         return objarray.count;
     }
    else
    {
    return self.commonArray2.count;
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
            if(collectionView == self.scheduleCollectionView)
            {
            return CGSizeMake(310, 182);
            }
            else
            {
                return CGSizeMake(310, 182);
            }
        }
    }
    else
    {
        //return CGSizeMake(160, 140);
        
        if(collectionView == self.scheduleCollectionView)
        {
            return CGSizeMake(310, 182);
        }
        else
        {
            return CGSizeMake(310, 182);
        }
    }
}
#pragma mark collection view cell paddings
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if(!IS_IPHONE_DEVICE)
    {
        return UIEdgeInsetsMake(20, 20, 30, 20); // top, left, bottom, right
    }
    else{
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if(!IS_IPHONE_DEVICE)
    {
        return 20.0;
    }
    else{
        return 10.0;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if(!IS_IPHONE_DEVICE)
    {
        return 23.0;
    }
    else{
        return 10.0;
    }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
    if(collectionView==self.scheduleCollectionView)
    {
    
        ResultCell* cell = [self.scheduleCollectionView dequeueReusableCellWithReuseIdentifier:@"cellno" forIndexPath:indexPath];
        
        
        
//        cell.eventNamelbl.text = [[self.commonArray valueForKey:@"EventName"] objectAtIndex:indexPath.row];
//        NSString *starttime = [[self.commonArray valueForKey:@"EventStartTime"] objectAtIndex:indexPath.row];
//        NSString *endtime = [[self.commonArray valueForKey:@"EventEndTime"] objectAtIndex:indexPath.row];
//       // cell.timelbl.text = [NSString stringWithFormat:@"%@ to %@",starttime,endtime];
//        cell.venuelbl.text = [[self.commonArray valueForKey:@"EventVenue"] objectAtIndex:indexPath.row];
//
//
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"HH:mm:ss"];
//        NSDate *date  = [dateFormatter dateFromString:starttime];
//        // Convert to new Date Format
//        [dateFormatter setDateFormat:@"hh:mm a"];
//        NSString *newtime1 = [dateFormatter stringFromDate:date];
//
//        NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
//        [dateFormatter2 setDateFormat:@"HH:mm:ss"];
//        NSDate *date2  = [dateFormatter2 dateFromString:endtime];
//        // Convert to new Date Format
//        [dateFormatter2 setDateFormat:@"hh:mm a"];
//        NSString *newtime2 = [dateFormatter2 stringFromDate:date2];
//
//        cell.timelbl.text = [NSString stringWithFormat:@"%@ to %@",newtime1,newtime2];
        
        
        cell.datelbl.text = [[objarray valueForKey:@"date"] objectAtIndex:indexPath.row];
       // cell.resultlbl.text = [[objarray valueForKey:@"time"] objectAtIndex:indexPath.row];
        cell.resultlbl.text = [[objarray valueForKey:@"ground"] objectAtIndex:indexPath.row];
        cell.FirstInnScorelbl.text = [[objarray valueForKey:@"team1"] objectAtIndex:indexPath.row];
        cell.SecondInnScorelbl.text = [[objarray valueForKey:@"team2"] objectAtIndex:indexPath.row];
        cell.competitionNamelbl.text = [[objarray valueForKey:@"CompetitionName"] objectAtIndex:indexPath.row];
        
        cell.teamAlogo.image = [UIImage imageNamed:@"no-image"];
        cell.teamBlogo.image = [UIImage imageNamed:@"no-image"];
        
//        NSString * imgStr1 = ([[objarray objectAtIndex:indexPath.row] valueForKey:@"team1Img"]==[NSNull null])?@"":[[objarray objectAtIndex:indexPath.row] valueForKey:@"team1Img"];
//        NSString *teamAString = [NSString stringWithFormat:@"%@%@",IMAGE_URL,imgStr1];
//
//        NSString * imgStr2 = ([[objarray objectAtIndex:indexPath.row] valueForKey:@"team2Img"]==[NSNull null])?@"":[[objarray objectAtIndex:indexPath.row] valueForKey:@"team2Img"];
//        NSString *teamBString = [NSString stringWithFormat:@"%@%@",IMAGE_URL,imgStr2];
//
//        [self downloadImageWithURL:[NSURL URLWithString:teamAString] completionBlock:^(BOOL succeeded, UIImage *image) {
//            if (succeeded) {
//                // change the image in the cell
//                cell.teamAlogo.image = image;
//
//                // cache the image for use later (when scrolling up)
//                cell.teamAlogo.image = image;
//            }
//            else
//            {
//                cell.teamAlogo.image = [UIImage imageNamed:@"no-image"];
//            }
//        }];
//
//
//        [self downloadImageWithURL:[NSURL URLWithString:teamBString] completionBlock:^(BOOL succeeded, UIImage *image) {
//            if (succeeded) {
//                // change the image in the cell
//                cell.teamBlogo.image = image;
//
//                // cache the image for use later (when scrolling up)
//                cell.teamBlogo.image = image;
//            }
//            else
//            {
//                cell.teamBlogo.image = [UIImage imageNamed:@"no-image"];
//            }
//        }];
        
        
//        NSString *key = [[objarray valueForKey:@"team1"] objectAtIndex:indexPath.row];
//
//        if([ key isEqualToString:@"India"])
//        {
//            cell.team1Img.image = [UIImage imageNamed:@"Indialogo"];
//            cell.team2Img.image = [UIImage imageNamed:@"Srilankalogo"];
//
//        }
//        else
//        {
//            cell.team1Img.image = [UIImage imageNamed:@"Srilankalogo"];
//            cell.team2Img.image = [UIImage imageNamed:@"Indialogo"];
//        }


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
    
    return cell;
    }
    if(collectionView==self.resultCollectionView)
    {
        
       ResultCell* cell = [self.resultCollectionView dequeueReusableCellWithReuseIdentifier:@"cellno" forIndexPath:indexPath];
        
        
        cell.competitionNamelbl.text = [[self.commonArray2 valueForKey:@"COMPETITIONNAME"]objectAtIndex:indexPath.row];
        cell.datelbl.text = [[self.commonArray2 valueForKey:@"DateTime"]objectAtIndex:indexPath.row];
        //cell.teamAlbl.text = [[self.commonArray2 valueForKey:@"TeamA"]objectAtIndex:indexPath.row];
        //cell.teamBlbl.text = [[self.commonArray2 valueForKey:@"TeamB"]objectAtIndex:indexPath.row];
        cell.resultlbl.text = [[self.commonArray2 valueForKey:@"MATCHRESULTORRUNSREQURED"]objectAtIndex:indexPath.row];
        
        
        
        NSString *first = [self checkNull:[[self.commonArray2 valueForKey:@"FIRSTINNINGSSCORE"]objectAtIndex:indexPath.row]];
            NSLog(@"%ld",(long)indexPath.row);
          cell.FirstInnScorelbl.text = first;
       
        
        NSString *second = [self checkNull:[[self.commonArray2 valueForKey:@"SECONDINNINGSSCORE"]objectAtIndex:indexPath.row]];
            NSLog(@"%ld",(long)indexPath.row);
        cell.SecondInnScorelbl.text = second;
       
        
        NSString *third = [self checkNull:[[self.commonArray2 valueForKey:@"THIRDINNINGSSCORE"]objectAtIndex:indexPath.row]];
            NSLog(@"%ld",(long)indexPath.row);
        cell.ThirdInnScorelbl.text = third;
        
        
        NSString *fourth = [self checkNull:[[self.commonArray2 valueForKey:@"FOURTHINNINGSSCORE"]objectAtIndex:indexPath.row]];
            NSLog(@"%ld",(long)indexPath.row);
        cell.FouthInnScorelbl.text = fourth;
        
        
        NSString * imgStr1 = ([[self.commonArray2 objectAtIndex:indexPath.row] valueForKey:@"TeamALogo"]==[NSNull null])?@"":[[self.commonArray2 objectAtIndex:indexPath.row] valueForKey:@"TeamALogo"];
        NSString *teamAString = [NSString stringWithFormat:@"%@%@",IMAGE_URL,imgStr1];
        
        NSString * imgStr2 = ([[self.commonArray2 objectAtIndex:indexPath.row] valueForKey:@"TeamBLogo"]==[NSNull null])?@"":[[self.commonArray2 objectAtIndex:indexPath.row] valueForKey:@"TeamBLogo"];
        NSString *teamBString = [NSString stringWithFormat:@"%@%@",IMAGE_URL,imgStr2];
        
        [self downloadImageWithURL:[NSURL URLWithString:teamAString] completionBlock:^(BOOL succeeded, UIImage *image) {
            if (succeeded) {
                // change the image in the cell
                cell.teamAlogo.image = image;
                
                // cache the image for use later (when scrolling up)
                cell.teamAlogo.image = image;
            }
            else
            {
                cell.teamAlogo.image = [UIImage imageNamed:@"no-image"];
            }
        }];
        
        
        [self downloadImageWithURL:[NSURL URLWithString:teamBString] completionBlock:^(BOOL succeeded, UIImage *image) {
            if (succeeded) {
                // change the image in the cell
                cell.teamBlogo.image = image;
                
                // cache the image for use later (when scrolling up)
                cell.teamBlogo.image = image;
            }
            else
            {
                cell.teamBlogo.image = [UIImage imageNamed:@"no-image"];
            }
        }];
        
        
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
        return cell;
      }

    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(collectionView == self.resultCollectionView)
    {
        displayMatchCode = [[self.commonArray2 valueForKey:@"MATCHCODE"] objectAtIndex:indexPath.row];
        NSMutableArray *scoreArray = [[NSMutableArray alloc]init];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        
        NSString *ground = [[self.commonArray2 valueForKey:@"Ground"]objectAtIndex:indexPath.row];
        NSString *place = [[self.commonArray2 valueForKey:@"GroundCode"]objectAtIndex:indexPath.row];
        
        [dic setValue:[NSString stringWithFormat:@"%@,%@",ground,place] forKey:@"ground"];
        [dic setValue:[[self.commonArray2 valueForKey:@"TeamA"] objectAtIndex:indexPath.row] forKey:@"team1"];
        [dic setValue:[[self.commonArray2 valueForKey:@"TeamB"]objectAtIndex:indexPath.row] forKey:@"team2"];
        [dic setValue:[[self.commonArray2 valueForKey:@"FIRSTINNINGSSCORE"]objectAtIndex:indexPath.row] forKey:@"Inn1Score"];
        [dic setValue:[[self.commonArray2 valueForKey:@"SECONDINNINGSSCORE"]objectAtIndex:indexPath.row] forKey:@"Inn2Score"];
        [dic setValue:[[self.commonArray2 valueForKey:@"THIRDINNINGSSCORE"]objectAtIndex:indexPath.row] forKey:@"Inn3Score"];
        [dic setValue:[[self.commonArray2 valueForKey:@"FOURTHINNINGSSCORE"]objectAtIndex:indexPath.row] forKey:@"Inn4Score"];
        [dic setValue:[[self.commonArray2 valueForKey:@"MATCHRESULTORRUNSREQURED"]objectAtIndex:indexPath.row] forKey:@"result"];
        [dic setValue:[[self.commonArray2 valueForKey:@"COMPETITIONNAME"]objectAtIndex:indexPath.row] forKey:@"Competition"];
        [dic setValue:[[self.commonArray2 valueForKey:@"TeamALogo"]objectAtIndex:indexPath.row] forKey:@"TeamALogo"];
        [dic setValue:[[self.commonArray2 valueForKey:@"TeamBLogo"]objectAtIndex:indexPath.row] forKey:@"TeamBLogo"];
        
        [scoreArray addObject:dic];
        

        
        
        
        
        
        
                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                       objtab = (TabbarVC *)[storyboard instantiateViewControllerWithIdentifier:@"TabbarVC"];
                        appDel.Currentmatchcode = displayMatchCode;
                        appDel.Scorearray = scoreArray;
                        //objtab.backkey = @"yes";
                        //[self.navigationController pushViewController:objFix animated:YES];
                        [appDel.frontNavigationController pushViewController:objtab animated:YES];
        
        
    }
    
}

- (void) displayContentController: (UIViewController*) content;
{
    [self addChildViewController:content];                 // 1
    content.view.bounds = self.view.bounds;                 //2
    [self.view addSubview:content.view];
    [content didMoveToParentViewController:self];          // 3
}

-(NSString *)checkNull:(NSString *)_value
{
    if ([_value isEqual:[NSNull null]] || _value == nil || [_value isEqual:@"<null>"]) {
        _value=@"";
    }
    return _value;
}

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}


-(void)FixturesWebservice
{
    //[COMMON loadingIcon:self.view];
    if([COMMON isInternetReachable])
    {
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",FixturesKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        NSString *competition = @"";
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(competition)   [dic    setObject:competition     forKey:@"Competitioncode"];
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                objarray = [[NSMutableArray alloc]init];
                NSMutableArray * fixArr = [[NSMutableArray alloc]init];
                fixArr = [responseObject valueForKey:@"lstFixturesGridValues"];
                if(fixArr.count >0)
                {
                    //self.competitionLbl.text = [[fixArr valueForKey:@"COMPETITIONNAME"] objectAtIndex:0];
                    
                    NSMutableArray * sepArray = [[NSMutableArray alloc]init];
                    
                    for(int i=0;i<fixArr.count;i++)
                    {
                        
                        sepArray = [fixArr objectAtIndex:i];
                        
                        NSString *dttime = [sepArray valueForKey:@"DateTime"];
                        
                        NSArray *components = [dttime componentsSeparatedByString:@" "];
                        NSString *day = components[0];
                        NSString *monthyear = components[1];
                        NSString *time = components[2];
                        NSString *local = components[3];
                        
                        NSString *realdate = [NSString stringWithFormat:@"%@ %@",day,monthyear];
                        NSString *realtime = [NSString stringWithFormat:@"%@ %@",time,local];
                        
                        NSString *ground = [sepArray valueForKey:@"Ground"];
                        NSString *place = [sepArray valueForKey:@"GroundCode"];
                        NSString *realGroundname = [NSString stringWithFormat:@"%@,%@",ground,place];
                        
                        NSString *team1 = [sepArray valueForKey:@"TeamA"];
                        NSString *team2 = [sepArray valueForKey:@"TeamB"];
                        NSString *team1Image = [sepArray valueForKey:@"TeamALogo"];
                        NSString *team2Image = [sepArray valueForKey:@"TeamBLogo"];
                        NSString *CompetitionName = [sepArray valueForKey:@"COMPETITIONNAME"];
                        
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                        
                        [dic setValue:realdate forKey:@"date"];
                        [dic setValue:realtime forKey:@"time"];
                        [dic setValue:realGroundname forKey:@"ground"];
                        // [dic setValue:realdate forKey:@"date"];
                        [dic setValue:team1 forKey:@"team1"];
                        [dic setValue:team2 forKey:@"team2"];
                        [dic setValue:team1Image forKey:@"team1Img"];
                        [dic setValue:team2Image forKey:@"team2Img"];
                        [dic setValue:CompetitionName forKey:@"CompetitionName"];
                        
                        [objarray addObject:dic];
                        
                        
                    }
                    
                    [self.scheduleCollectionView reloadData];
//                    popArray = [[NSMutableArray alloc]init];
//                    popArray = [responseObject valueForKey:@"lstCompetitionVal"];
                    
                    //[self.ListTbl reloadData];
                    
                }
            }
            
            
          
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"failed");
            
        }];
    }
    
}

@end
