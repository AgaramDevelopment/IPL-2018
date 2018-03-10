//
//  TabHomeVC.m
//  APT_V2
//
//  Created by Apple on 06/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "TabHomeVC.h"
#import "Config.h"
#import "AppCommon.h"
#import "TabHomeCell.h"
#import "SchResStandVC.h"
#import "CustomNavigation.h"
#import "SWRevealViewController.h"
#import "WellnessTrainingBowlingVC.h"
#import "VideoGalleryVC.h"
#import "HomeScreenStandingsVC.h"
#import "SwipeView.h"
#import "MyStatsBattingVC.h"

@interface TabHomeVC ()
{
    SchResStandVC *objSch;
    WellnessTrainingBowlingVC * objWell;
    VideoGalleryVC * objVideo;
    HomeScreenStandingsVC *StandsVC;
    MyStatsBattingVC *objStats;
}

@end

@implementation TabHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customnavigationmethod];
    
    [self.Titlecollview registerNib:[UINib nibWithNibName:@"TabHomeCell" bundle:nil] forCellWithReuseIdentifier:@"cellid"];
}
-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    //    [self.view addSubview:objCustomNavigation.view];
    //    objCustomNavigation.tittle_lbl.text=@"";
    
    //UIView* view= self.navigation_view.subviews.firstObject;
    [self.navi_View addSubview:objCustomNavigation.view];
    
    objCustomNavigation.btn_back.hidden =YES;
    objCustomNavigation.menu_btn.hidden =NO;
    //        [objCustomNavigation.btn_back addTarget:self action:@selector(didClickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.menu_btn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    //        [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [self.Titlecollview selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionBottom];
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController.panGestureRecognizer setEnabled:YES];
    [revealController.tapGestureRecognizer setEnabled:YES];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    //return self.commonArray.count;
    
    return 2;
}
#pragma mar - UICollectionViewFlowDelegateLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat widthF = self.Titlecollview.superview.frame.size.width/2;
    if(IS_IPHONE_DEVICE)
    {
        if(!IS_IPHONE5)
        {
            return CGSizeMake(widthF, 50);
        }
        else
        {
                return CGSizeMake(widthF, 30);
        }
    }
    else
    {
        //CGFloat widthF = self.Titlecollview.frame.size.width/2;
            return CGSizeMake(widthF, 50);
    }
}
#pragma mark collection view cell paddings
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if(!IS_IPHONE_DEVICE)
    {
        return UIEdgeInsetsMake(20, 0, 30, 20); // top, left, bottom, right
    }
    else{
        return UIEdgeInsetsMake(10, 0, 0, 10);
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
    
    
        
        TabHomeCell* cell = [self.Titlecollview dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
        //cell.contentView.backgroundColor = [UIColor whiteColor];
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
    [cell setSelectedBackgroundView:bgColorView];
    
    if(indexPath.row==0)
    {
        cell.Title.text = @"FIXTURES/RESULTS/VIDEOS";
        [cell setTag:indexPath.row];
        
    }
    if(indexPath.row==1)
    {
        cell.Title.text = @"MYSTATS";
        [cell setTag:indexPath.row];
    }


        return cell;
    
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    TabHomeCell* cell = [self.Titlecollview dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
    [cell setSelectedBackgroundView:bgColorView];

    if(indexPath.row == 0)
    {
        [self.swipeView scrollToItemAtIndex:0 duration:0];
        
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
        [self.Titlecollview selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
        
    }
    if(indexPath.row == 1)
    {
        
        [self.swipeView scrollToItemAtIndex:1 duration:0];
        
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:0];
        [self.Titlecollview selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    }

}



- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    //return the total number of items in the carousel
    return 2;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
//    UILabel *label = nil;

    //create new view if no view is available for recycling
//    if (view == nil)
//    {
        view = [[UIView alloc] initWithFrame:self.swipeView.bounds];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        if(index == 0)
        {
            objSch = [[SchResStandVC alloc] initWithNibName:@"SchResStandVC" bundle:nil];
            objSch.view.frame = CGRectMake(0, 0, self.swipeView.bounds.size.width, self.swipeView.bounds.size.height);
            [view addSubview:objSch.view];
   
        }
         else if(index == 1)
        {
            objStats = [[MyStatsBattingVC alloc] initWithNibName:@"MyStatsBattingVC" bundle:nil];
            objStats.view.frame = CGRectMake(0, -75, self.swipeView.bounds.size.width, self.swipeView.bounds.size.height);
            [view addSubview:objStats.view];
        }


    return view;
}

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    return self.swipeView.bounds.size;
}

- (void)swipeViewDidScroll:(SwipeView *)swipeView
{

    if(self.swipeView.currentItemIndex == 0)
    {
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
        [self.Titlecollview selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    }
    if(self.swipeView.currentItemIndex == 1)
    {
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:0];
        [self.Titlecollview selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    }

}
- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
   // self.page_control.currentPage = self.swipeView.currentItemIndex;
}







@end
