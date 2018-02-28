//
//  TeamOverviewVC.m
//  APT_V2
//
//  Created by MAC on 28/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "TeamOverviewVC.h"
#import "Header.h"
#import "TeamOverviewCell.h"

@interface TeamOverviewVC ()

@end

@implementation TeamOverviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customnavigationmethod];
    
    [self.teamCollectionView registerNib:[UINib nibWithNibName:@"TeamOverviewCell" bundle:nil] forCellWithReuseIdentifier:@"teamOverviewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self.navigationView addSubview:objCustomNavigation.view];
    
    objCustomNavigation.btn_back.hidden =YES;
    objCustomNavigation.menu_btn.hidden =NO;
        //        [objCustomNavigation.btn_back addTarget:self action:@selector(didClickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.menu_btn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
        //        [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NutritionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"teamOverviewCell" forIndexPath:indexPath];

/*
        //Target for More Details
    [cell.breakfastBtn addTarget:self action:@selector(didClickBreakfastMore:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.snacksBtn addTarget:self action:@selector(didClickSnacksMore:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.lunchBtn addTarget:self action:@selector(didClickLunchMore:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.dinnerBtn addTarget:self action:@selector(didClickDinnerMore:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.supplementsBtn addTarget:self action:@selector(didClickSupplementsMore:) forControlEvents:UIControlEventTouchUpInside];
    */
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (IS_IPAD) {
        return CGSizeMake(250, 415);
    } else {
        return CGSizeMake(250, 415);
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
