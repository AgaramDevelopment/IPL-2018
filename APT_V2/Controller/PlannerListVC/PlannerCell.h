//
//  PlannerCell.h
//  AlphaProTracker
//
//  Created by Mac on 14/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlannerCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel * objEventName_lbl;

@property (nonatomic,strong) IBOutlet UILabel * objStartTime_lbl;
@property (nonatomic,strong) IBOutlet UILabel * objendTime_lbl;

@end
