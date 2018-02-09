//
//  AssesmentTableViewCell.m
//  APT_V2
//
//  Created by user on 05/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "AssesmentTableViewCell.h"

@implementation AssesmentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self shadow];

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)shadow
{
    /*
     // *** Set masks bounds to NO to display shadow visible ***
     self.avatarImageView.layer.masksToBounds = NO;
     // *** Set light gray color as shown in sample ***
     self.avatarImageView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
     // *** *** Use following to add Shadow top, left ***
     self.avatarImageView.layer.shadowOffset = CGSizeMake(-5.0f, -5.0f);
     
     // *** Use following to add Shadow bottom, right ***
     //self.avatarImageView.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
     
     // *** Use following to add Shadow top, left, bottom, right ***
     // avatarImageView.layer.shadowOffset = CGSizeZero;
     // avatarImageView.layer.shadowRadius = 5.0f;
     
     // *** Set shadowOpacity to full (1) ***
     self.avatarImageView.layer.shadowOpacity = 1.0f;
     */
    
    self.Shadowview.layer.masksToBounds = NO;
    self.Shadowview.layer.shadowColor = [UIColor blackColor].CGColor;
    self.Shadowview.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.Shadowview.layer.shadowRadius = 2.0f;
    self.Shadowview.layer.shadowOpacity = 0.7f;

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

//-(void)headerOpen
//{
//    UILayoutGuide* margin = subviews.layoutMarginsGuide;
//
//    [subviews.leadingAnchor constraintEqualToAnchor:margin.leadingAnchor].active = true;
//    [subviews.trailingAnchor constraintEqualToAnchor:margin.trailingAnchor].active = true;
//    [subviews.topAnchor constraintEqualToAnchor:margin.topAnchor].active = true;
//    [subviews.bottomAnchor constraintEqualToAnchor:margin.bottomAnchor].active = true;
//
//
//}

@end
