//
//  AssesmentTableViewCell.h
//  APT_V2
//
//  Created by user on 05/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssesmentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblAssTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnAssTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerBottomConstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *btnHeader1;
@property (weak, nonatomic) IBOutlet UIView *subviews;

@end
