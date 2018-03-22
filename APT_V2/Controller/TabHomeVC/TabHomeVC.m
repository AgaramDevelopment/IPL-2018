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
#import "TeamMembersVC.h"

@interface TabHomeVC ()
{
    SchResStandVC *objSch;
    WellnessTrainingBowlingVC * objWell;
    VideoGalleryVC * objVideo;
    HomeScreenStandingsVC *StandsVC;
    MyStatsBattingVC *objStats;
    NSIndexPath* selectedIndex;
    TeamMembersVC* objPlayersVC;
    NSArray* titleArray;
}

@end

@implementation TabHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customnavigationmethod];
    
    [self.Titlecollview registerNib:[UINib nibWithNibName:@"TabHomeCell" bundle:nil] forCellWithReuseIdentifier:@"cellid"];
    
    objSch = [[SchResStandVC alloc] initWithNibName:@"SchResStandVC" bundle:nil];
    objStats = [[MyStatsBattingVC alloc] initWithNibName:@"MyStatsBattingVC" bundle:nil];
    objPlayersVC = [TeamMembersVC new];
    selectedIndex = [NSIndexPath indexPathForItem:0 inSection:0];
    
    
    titleArray = @[@"Home",([AppCommon isCoach] ? @"My Teams" : @"My Stats")];
    

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
//    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
//    [self.Titlecollview selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionBottom];
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController.panGestureRecognizer setEnabled:YES];
    [revealController.tapGestureRecognizer setEnabled:YES];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.Titlecollview reloadData];
    });

    
}

-(void)viewDidAppear:(BOOL)animated
{
    
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
    CGFloat HeightF = self.Titlecollview.superview.frame.size.height;
    
    return CGSizeMake(widthF, HeightF);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TabHomeCell* cell = [self.Titlecollview dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    cell.Title.text = titleArray[indexPath.row];
    [cell setTag:indexPath.row];
    
    if (indexPath == selectedIndex) {
        cell.selectedLineView.backgroundColor = [UIColor colorWithRed:(37/255.0f) green:(176/255.0f) blue:(240/255.0f) alpha:1.0f];
    }
    else {
        cell.selectedLineView.backgroundColor = [UIColor clearColor];
    }
    
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [self.swipeView scrollToItemAtIndex:indexPath.item duration:0.2];
}



- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return titleArray.count;
}

//- (void)swipeViewDidScroll:(__unused SwipeView *)swipeView {}
- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
        view = [[UIView alloc] initWithFrame:self.swipeView.bounds];
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        if(index == 0)
        {
            objSch.view.frame = CGRectMake(0, 0, self.swipeView.bounds.size.width, self.swipeView.bounds.size.height);
            [view addSubview:objSch.view];
   
        }
    
         else if(index == 1)
        {
            if ([AppCommon isCoach]) {
                objPlayersVC.view.frame = CGRectMake(0, -65, self.swipeView.bounds.size.width, self.swipeView.bounds.size.height+65);
                [view addSubview:objPlayersVC.view];
            }
            else
            {
                objStats.view.frame = CGRectMake(0, -75, self.swipeView.bounds.size.width, self.swipeView.bounds.size.height+75);
                [view addSubview:objStats.view];
            }
        }

    return view;
}

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    return self.swipeView.bounds.size;
}

- (void)swipeViewDidScroll:(SwipeView *)swipeView
{
    selectedIndex = [NSIndexPath indexPathForItem:swipeView.currentItemIndex inSection:0];
    [self.Titlecollview reloadData];
}

- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView
{
   // self.page_control.currentPage = self.swipeView.currentItemIndex;
}







@end
