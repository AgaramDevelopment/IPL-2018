//
//  TestPropertyCollectionViewCell.m
//  APT_V2
//
//  Created by user on 08/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "TestPropertyCollectionViewCell.h"

@implementation TestPropertyCollectionViewCell
@synthesize lblTopIndicator;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setup];
}

-(void)setup
{
//    let view = UIView()
//    view.clipsToBounds = true
//    view.layer.cornerRadius = 10
//    view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:lblTopIndicator.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:lblTopIndicator.frame.size];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = lblTopIndicator.bounds;
    maskLayer.path  = maskPath.CGPath;
    lblTopIndicator.layer.mask = maskLayer;

    
//    lblTopIndicator.clipsToBounds = YES;
//    lblTopIndicator.layer.cornerRadius = 10;
//    lblTopIndicator.layer.maskedCorners = @[lblTopIndicator ma]
}

@end
