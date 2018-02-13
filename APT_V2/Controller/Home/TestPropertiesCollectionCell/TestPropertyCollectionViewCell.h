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
@property (weak, nonatomic) IBOutlet LineTextField *txtField;
@property (weak, nonatomic) IBOutlet UILabel *lblBottom;

@end
