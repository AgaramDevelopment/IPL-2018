//
//  SCCollectionViewCell.h
//  APT_V2
//
//  Created by user on 14/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTopIndicator;
@property (weak, nonatomic) IBOutlet UITextField *SCtxt1;
@property (weak, nonatomic) IBOutlet UITextField *SCtxt2;

@property (weak, nonatomic) IBOutlet UILabel *lblBottom;
@property (weak, nonatomic) IBOutlet UIButton *btnDropdown;
@end
