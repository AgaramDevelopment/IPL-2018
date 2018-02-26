//
//  AddParticipantCell.h
//  AlphaProTracker
//
//  Created by Mac on 08/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddParticipantCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel * participationTypeLbl;

@property (nonatomic,strong) IBOutlet UILabel * participantLbl;

@property (nonatomic,strong) IBOutlet UILabel * availableLbl;

@property (nonatomic,strong) IBOutlet UIButton * deleteBtn;

@end
