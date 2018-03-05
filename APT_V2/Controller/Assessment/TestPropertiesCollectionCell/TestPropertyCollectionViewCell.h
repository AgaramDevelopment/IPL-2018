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
@property (weak, nonatomic) IBOutlet customTextField *txtField;
@property (weak, nonatomic) IBOutlet UILabel *lblBottom;
@property (weak, nonatomic) IBOutlet UIView *SC_view;
@property (weak, nonatomic) IBOutlet customTextField *txtDropDown;
@property (weak, nonatomic) IBOutlet customTextField *txt1_SC;
@property (weak, nonatomic) IBOutlet customTextField *txt2_SC;

@end
