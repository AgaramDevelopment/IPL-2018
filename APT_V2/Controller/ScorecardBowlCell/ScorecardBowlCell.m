//
//  ScorecardBowlCell.m
//  NewSportsProject
//
//  Created by Mac on 13/12/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "ScorecardBowlCell.h"

@interface ScorecardBowlCell ()

@end

@implementation ScorecardBowlCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //self.cellHeight.constant = 100;
    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    
    if(selected)
    {
        [self setBackgroundColor:[UIColor lightGrayColor]];
    }
    else
    {
        [self setBackgroundColor:[UIColor whiteColor]];
    }
}


@end
