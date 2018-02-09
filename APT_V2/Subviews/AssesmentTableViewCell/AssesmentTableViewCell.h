//
//  AssesmentTableViewCell.h
//  APT_V2
//
//  Created by user on 05/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssesmentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnAssTitle;

@property (weak, nonatomic) IBOutlet UIImageView *imgCheck;
@property (weak, nonatomic) IBOutlet UIButton *btnImgCheck;
@property (weak, nonatomic) IBOutlet UILabel *lblTestName;
@property (weak, nonatomic) IBOutlet UILabel *lblInference;
@property (weak, nonatomic) IBOutlet UILabel *lblInjured;
@property (weak, nonatomic) IBOutlet UIView *Shadowview;
@end
