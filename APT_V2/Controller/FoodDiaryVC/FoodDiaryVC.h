//
//  FoodDiaryVC.h
//  APT_V2
//
//  Created by MAC on 17/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodDiaryCell.h"

@interface FoodDiaryVC : UIViewController
@property (strong, nonatomic) IBOutlet UICollectionView *foodDiaryCollectionView;
@property (strong, nonatomic) IBOutlet UIButton *addBtn;

@end
