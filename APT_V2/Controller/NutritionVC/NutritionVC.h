//
//  NutritionVC.h
//  APT_V2
//
//  Created by MAC on 21/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NutritionVC : UIViewController
@property (strong, nonatomic) IBOutlet UICollectionView *nutritionCollectionView;
@property (strong, nonatomic) IBOutlet UIView *navi_View;
@property (nonatomic,strong) UIPopoverController *popOver;
@property (strong, nonatomic) IBOutlet UIViewController *popView;

@end
