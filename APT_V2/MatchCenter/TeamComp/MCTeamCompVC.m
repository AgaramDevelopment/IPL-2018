//
//  MCTeamCompVC.m
//  APT_V2
//
//  Created by apple on 14/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "MCTeamCompVC.h"
#import "MCTeamCompCVC.h"
#import "CustomNavigation.h"
#import "SWRevealViewController.h"

@interface MCTeamCompVC ()

@end

@implementation MCTeamCompVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    
    [self.teamCompCollectionView registerNib:[UINib nibWithNibName:@"MCTeamCompCVC" bundle:nil] forCellWithReuseIdentifier:@"mcTeamCompCVC"];
    
    
    
}

-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.headerView addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"Team Comp";
    objCustomNavigation.btn_back.hidden = YES;
    objCustomNavigation.home_btn.hidden = YES;
    objCustomNavigation.menu_btn.hidden =NO;
    
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    
    [objCustomNavigation.menu_btn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if(collectionView == self.teamCompCollectionView){
        return 3;
    }else{
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if(collectionView == self.teamCompCollectionView){
        
        
        
        MCTeamCompCVC * cell = [self.teamCompCollectionView dequeueReusableCellWithReuseIdentifier:@"mcTeamCompCVC" forIndexPath:indexPath];
        
        
        
        return cell;
        
    }
    return nil;
    
}


@end

