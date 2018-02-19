//
//  TeamMembersVC.m
//  APT_V2
//
//  Created by MAC on 12/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "TeamMembersVC.h"
#import "CustomNavigation.h"
#import "SWRevealViewController.h"
#import "AppCommon.h"
#import "Config.h"
#import "WebService.h"
#import "TeamMemebersCell.h"

@interface TeamMembersVC ()

@property (strong, nonatomic)  NSMutableArray *PlayersArray;
@end

@implementation TeamMembersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
      [self.playesTable registerNib:[UINib nibWithNibName:@"TeamMemebersCell" bundle:nil] forCellWithReuseIdentifier:@"cellid"];
    [self TeamsWebservice];
    self.TeamNamelbl.text = _teamname;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //return self.commonArray.count;
    
    return _PlayersArray.count;
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
                return CGSizeMake(130, 178);
        }
    }
    else
    {
        
            return CGSizeMake(310, 182);
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
    
    
        
        TeamMemebersCell* cell = [self.playesTable dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    
    
    NSString *playername = [self checkNull:[[self.PlayersArray valueForKey:@"AthleteName"]objectAtIndex:indexPath.row]];
    NSLog(@"%ld",(long)indexPath.row);
    
    cell.playernamelbl.text = playername;
    
    NSString *bowlingStyle = [self checkNull:[[self.PlayersArray valueForKey:@"BowlingStyle"]objectAtIndex:indexPath.row]];
    NSLog(@"%ld",(long)indexPath.row);
    cell.BowlingStylelbl.text = bowlingStyle;
    
    NSString *battingStyle = [self checkNull:[[self.PlayersArray valueForKey:@"BattingStyle"]objectAtIndex:indexPath.row]];
    NSLog(@"%ld",(long)indexPath.row);
    cell.BattingStylelbl.text = battingStyle;
    
    NSString *age = [self checkNull:[[self.PlayersArray valueForKey:@"Age"]objectAtIndex:indexPath.row]];
    NSLog(@"%ld",(long)indexPath.row);
    cell.agelbl.text = age ;
    
    
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


-(NSString *)checkNull:(NSString *)_value
{
    if ([_value isEqual:[NSNull null]] || _value == nil || [_value isEqual:@"<null>"]) {
        _value=@"";
    }
    return _value;
}

-(void)TeamsWebservice
{
    
    if([COMMON isInternetReachable])
    {
        [AppCommon showLoading];
        
        NSString *URLString =  [URL_FOR_RESOURCE(@"") stringByAppendingString:[NSString stringWithFormat:@"%@",playersKey]];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        manager.requestSerializer = requestSerializer;
        
        
        NSString *ClientCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
        NSString *UserrefCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
        
        
        
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if(ClientCode)   [dic    setObject:ClientCode     forKey:@"Clientcode"];
        if(UserrefCode)   [dic    setObject:UserrefCode     forKey:@"Userreferencecode"];
        if(self.teamCode)   [dic    setObject:self.teamCode     forKey:@"Teamcode"];
        
        
        NSLog(@"parameters : %@",dic);
        [manager POST:URLString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"response ; %@",responseObject);
            
            if(responseObject >0)
            {
                self.PlayersArray = [[NSMutableArray alloc]init];
                self.PlayersArray = responseObject;
                [self.playesTable reloadData];
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

- (IBAction)backBtnAction:(id)sender
{
    [self.view removeFromSuperview];
}



@end
