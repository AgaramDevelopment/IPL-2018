//
//  TestPropertyCollectionViewCell.h
//  APT_V2
//
//  Created by user on 08/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface TestPropertyCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTopIndicator;
@property (weak, nonatomic) IBOutlet UITextField *txtField;
@property (weak, nonatomic) IBOutlet UILabel *lblBottom;
@property (weak, nonatomic) IBOutlet UIView *SC_view;
@property (weak, nonatomic) IBOutlet UIButton *btnDropDown;
@property (weak, nonatomic) IBOutlet UITextField *txtDropDown;
@property (weak, nonatomic) IBOutlet UITextField *txt1_SC;
@property (weak, nonatomic) IBOutlet UITextField *txt2_SC;

@end
