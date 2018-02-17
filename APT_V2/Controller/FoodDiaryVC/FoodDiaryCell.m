//
//  FoodDiaryCell.m
//  APT_V2
//
//  Created by MAC on 17/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "FoodDiaryCell.h"

@implementation FoodDiaryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //Adds a shadow to contentView
    self.contentView.layer.masksToBounds = NO;
    self.contentView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.contentView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.contentView.layer.shadowRadius = 5;
    self.contentView.layer.shadowOpacity = 0.8f;
}

@end
