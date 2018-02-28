//
//  TeamOverviewCell.m
//  APT_V2
//
//  Created by MAC on 28/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "TeamOverviewCell.h"

@implementation TeamOverviewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.availableLbl.layer.cornerRadius =2.5;
    self.availableLbl.layer.masksToBounds=YES;
}

@end
