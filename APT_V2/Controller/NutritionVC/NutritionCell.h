//
//  NutritionCell.h
//  APT_V2
//
//  Created by MAC on 21/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NutritionCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *breakfastTimeLbl;
@property (strong, nonatomic) IBOutlet UILabel *breakfast1Lbl;
@property (strong, nonatomic) IBOutlet UILabel *breakfast2Lbl;
@property (strong, nonatomic) IBOutlet UILabel *breakfast3Lbl;
@property (strong, nonatomic) IBOutlet UIButton *breakfastBtn;

@property (strong, nonatomic) IBOutlet UILabel *snacksTimeLbl;
@property (strong, nonatomic) IBOutlet UILabel *snacks1Lbl;
@property (strong, nonatomic) IBOutlet UILabel *snacks2Lbl;
@property (strong, nonatomic) IBOutlet UILabel *snacks3Lbl;
@property (strong, nonatomic) IBOutlet UIButton *snacksBtn;

@property (strong, nonatomic) IBOutlet UILabel *lunchTimeLbl;
@property (strong, nonatomic) IBOutlet UILabel *lunch1Lbl;
@property (strong, nonatomic) IBOutlet UILabel *lunch2Lbl;
@property (strong, nonatomic) IBOutlet UILabel *lunch3Lbl;
@property (strong, nonatomic) IBOutlet UIButton *lunchBtn;

@property (strong, nonatomic) IBOutlet UILabel *dinnerTimeLbl;
@property (strong, nonatomic) IBOutlet UILabel *dinner1Lbl;
@property (strong, nonatomic) IBOutlet UILabel *dinner2Lbl;
@property (strong, nonatomic) IBOutlet UILabel *dinner3Lbl;
@property (strong, nonatomic) IBOutlet UIButton *dinnerBtn;

@property (strong, nonatomic) IBOutlet UILabel *supplementsTimeLbl;
@property (strong, nonatomic) IBOutlet UILabel *supplements1Lbl;
@property (strong, nonatomic) IBOutlet UILabel *supplements2Lbl;
@property (strong, nonatomic) IBOutlet UILabel *supplements3Lbl;
@property (strong, nonatomic) IBOutlet UIButton *supplementsBtn;

@end
