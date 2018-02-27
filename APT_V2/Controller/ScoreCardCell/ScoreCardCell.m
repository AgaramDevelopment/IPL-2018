//
//  ScoreCardCell.m
//  NewSportsProject
//
//  Created by Mac on 01/12/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "ScoreCardCell.h"
@interface ScoreCardCell ()<UIScrollViewDelegate>



@end

@implementation ScoreCardCell
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
