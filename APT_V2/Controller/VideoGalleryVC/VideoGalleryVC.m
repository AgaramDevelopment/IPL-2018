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

@interface VideoGalleryVC ()

@end

@implementation VideoGalleryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.videoCollectionview1 registerNib:[UINib nibWithNibName:@"VideoGalleryCell" bundle:nil] forCellWithReuseIdentifier:@"cellid"];
    [self.videoCollectionview2 registerNib:[UINib nibWithNibName:@"VideoGalleryUploadCell" bundle:nil] forCellWithReuseIdentifier:@"cellid"];
}
- (IBAction)UploadVideoAction:(id)sender {
    
    VideoPlayerUploadVC * videouploadVC = [[VideoPlayerUploadVC alloc] initWithNibName:@"VideoPlayerUploadVC" bundle:nil];
    videouploadVC.view.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height);
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
    return 5;
    }
    else
    {
        return 10;
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
                return CGSizeMake(100, 100);
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
        
        return cell;
    }
    
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    
    VideoPlayerViewController * videoPlayerVC = [[VideoPlayerViewController alloc] initWithNibName:@"VideoPlayerViewController" bundle:nil];
    videoPlayerVC.view.frame = CGRectMake(0,10, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:videoPlayerVC.view];

}
@end
