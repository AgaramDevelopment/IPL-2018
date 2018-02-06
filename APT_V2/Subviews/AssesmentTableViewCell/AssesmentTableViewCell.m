//
//  AssesmentTableViewCell.m
//  APT_V2
//
//  Created by user on 05/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "AssesmentTableViewCell.h"

@implementation AssesmentTableViewCell
@synthesize subviews;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/*
 
 NSLayoutConstraint(item: subview,
 attribute: .Leading,
 relatedBy: .Equal,
 toItem: view,
 attribute: .LeadingMargin,
 multiplier: 1.0,
 constant: 0.0).active = true
 
 NSLayoutConstraint(item: subview,
 attribute: .Trailing,
 relatedBy: .Equal,
 toItem: view,
 attribute: .TrailingMargin,
 multiplier: 1.0,
 constant: 0.0).active = true
 
 let margins = view.layoutMarginsGuide
 subview.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
 subview.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
 
 myLabel.widthAnchor.constraintEqualToConstant(50.0).active = true

 */

-(void)headerOpen
{
    UILayoutGuide* margin = subviews.layoutMarginsGuide;
    
    [subviews.leadingAnchor constraintEqualToAnchor:margin.leadingAnchor].active = true;
    [subviews.trailingAnchor constraintEqualToAnchor:margin.trailingAnchor].active = true;
    [subviews.topAnchor constraintEqualToAnchor:margin.topAnchor].active = true;
    [subviews.bottomAnchor constraintEqualToAnchor:margin.bottomAnchor].active = true;
    
    
}

@end
