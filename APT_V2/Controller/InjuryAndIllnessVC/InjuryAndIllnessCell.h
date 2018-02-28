//
//  InjuryAndIllnessCell.h
//  APT_V2
//
//  Created by MAC on 27/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InjuryAndIllnessCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *injuryLbl;
@property (strong, nonatomic) IBOutlet UILabel *injuryDateLbl;
@property (strong, nonatomic) IBOutlet UILabel *injuryErdLbl;

@property (strong, nonatomic) IBOutlet UILabel *illnessLbl;
@property (strong, nonatomic) IBOutlet UILabel *illnessDateLbl;
@property (strong, nonatomic) IBOutlet UILabel *illnessErdLbl;
@end
