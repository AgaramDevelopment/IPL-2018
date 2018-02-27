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
#import "MCTeamPlayersCompCell.h"

@interface MCTeamCompVC ()

@end

@implementation MCTeamCompVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    
    [self.teamCompCollectionView registerNib:[UINib nibWithNibName:@"MCTeamCompCVC" bundle:nil] forCellWithReuseIdentifier:@"mcTeamCompCVC"];
    
    [self.BowlerCollectionView registerNib:[UINib nibWithNibName:@"MCTeamPlayersCompCell" bundle:nil] forCellWithReuseIdentifier:@"CompCell"];
    [self.BatsmenCollectionView
     registerNib:[UINib nibWithNibName:@"MCTeamPlayersCompCell" bundle:nil] forCellWithReuseIdentifier:@"CompCell"];
    [self.AllrounderCollectionView registerNib:[UINib nibWithNibName:@"MCTeamPlayersCompCell" bundle:nil] forCellWithReuseIdentifier:@"CompCell"];

    
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
        return 10;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(IS_IPHONE_DEVICE)
    {
        if(!IS_IPHONE5)
        {
            return CGSizeMake(50, 50);
        }
        else
        {
            if(collectionView == self.teamCompCollectionView)
            {
                return CGSizeMake(404, 825);
            }
            else
            {
                return CGSizeMake(200, 130);
            }
        }
    }
    else
    {
        //return CGSizeMake(160, 140);
        
        if(collectionView == self.teamCompCollectionView)
        {
            return CGSizeMake(404, 825);
        }
        else
        {
            return CGSizeMake(200, 130);
        }
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if(!IS_IPHONE_DEVICE)
    {
        return UIEdgeInsetsMake(10, 20, 10, 20); // top, left, bottom, right
    }
    else{
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if(collectionView == self.teamCompCollectionView){
        
        
        
        MCTeamCompCVC * cell = [self.teamCompCollectionView dequeueReusableCellWithReuseIdentifier:@"mcTeamCompCVC" forIndexPath:indexPath];
        
        
        
        return cell;
        
    }
    
    else if(collectionView == self.BowlerCollectionView){
        
        
        
        MCTeamPlayersCompCell * cell = [self.BowlerCollectionView dequeueReusableCellWithReuseIdentifier:@"CompCell" forIndexPath:indexPath];
        
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
    
    else if(collectionView == self.BatsmenCollectionView){
        
        
        
        MCTeamPlayersCompCell * cell = [self.BatsmenCollectionView dequeueReusableCellWithReuseIdentifier:@"CompCell" forIndexPath:indexPath];
        
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
    else if(collectionView == self.AllrounderCollectionView){
        
        
        
        MCTeamPlayersCompCell * cell = [self.AllrounderCollectionView dequeueReusableCellWithReuseIdentifier:@"CompCell" forIndexPath:indexPath];
        
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


@end

