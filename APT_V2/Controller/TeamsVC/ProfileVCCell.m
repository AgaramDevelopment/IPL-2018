//
//  ProfileVCCell.m
//  AlphaProTracker
//
//  Created by Lexicon on 04/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "ProfileVCCell.h"

@interface ProfileVCCell ()

@end

@implementation ProfileVCCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cellview.layer.borderWidth=1.0f;
    self.cellview.layer.borderColor=[UIColor colorWithRed:(255/255.0f) green:(255/255.0f) blue:(255/255.0f) alpha:0.5f].CGColor;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
