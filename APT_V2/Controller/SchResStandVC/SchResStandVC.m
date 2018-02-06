//
//  SchResStandVC.m
//  APT_V2
//
//  Created by Apple on 06/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "SchResStandVC.h"
#import "Config.h"
#import "AppCommon.h"
#import "HomeScreenStandingsVC.h"


@interface SchResStandVC ()
{
    HomeScreenStandingsVC *StandsVC;
}

@property (strong, nonatomic)  NSMutableArray *commonArray;

@end

@implementation SchResStandVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self.scheduleCollectionView registerNib:[UINib nibWithNibName:@"ScheduleCell" bundle:nil] forCellWithReuseIdentifier:@"cellid"];
    [self.resultCollectionView registerNib:[UINib nibWithNibName:@"ResultCell" bundle:nil] forCellWithReuseIdentifier:@"cellno"];
    
    
    StandsVC = [[HomeScreenStandingsVC alloc] initWithNibName:@"HomeScreenStandingsVC" bundle:nil];
    StandsVC.view.frame = CGRectMake(0, self.resultView.frame.origin.y+220, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.commonView addSubview:StandsVC.view];
    
   
     //self.scroll.contentSize = CGSizeMake(self.scroll.frame.size.width, self.commonView.frame.size.height);
    
    self.scroll.contentSize =  self.commonView.frame.size;

    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //return self.commonArray.count;
    
    return 5;
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
            return CGSizeMake(224, 135);
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
            return CGSizeMake(224, 135);
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

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(10, 10, 10, 10);
//}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
    if(collectionView==self.scheduleCollectionView)
    {
    
        ScheduleCell* cell = [self.scheduleCollectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    
        cell.layer.borderWidth=0.5f;
        cell.layer.borderColor=[UIColor blackColor].CGColor;
        
        cell.contentView.layer.shadowColor = [UIColor blackColor].CGColor;
        cell.contentView.layer.shadowOffset = CGSizeMake(1, 1);
        cell.contentView.layer.shadowOpacity = 2.0;
        cell.contentView.layer.shadowRadius = 6.0;
    
    return cell;
    }
    if(collectionView==self.resultCollectionView)
    {
        
       ResultCell* cell = [self.resultCollectionView dequeueReusableCellWithReuseIdentifier:@"cellno" forIndexPath:indexPath];
        
        cell.layer.borderWidth=0.5f;
        cell.layer.borderColor=[UIColor blackColor].CGColor;
        cell.contentView.layer.shadowColor = [UIColor blackColor].CGColor;
        cell.contentView.layer.shadowOffset = CGSizeMake(1, 1);
        cell.contentView.layer.shadowOpacity = 2.0;
        cell.contentView.layer.shadowRadius = 6.0;
        return cell;
      }

    return nil;
}

@end
