//
//  MCTeamCompVC.h
//  APT_V2
//
//  Created by apple on 14/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCTeamCompVC : UIViewController
@property (strong, nonatomic) IBOutlet UICollectionView *teamCompCollectionView;
@property (strong, nonatomic) IBOutlet UIView *headerView;


@property (strong, nonatomic) IBOutlet UICollectionView *BowlerCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *BatsmenCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *AllrounderCollectionView;


@end
