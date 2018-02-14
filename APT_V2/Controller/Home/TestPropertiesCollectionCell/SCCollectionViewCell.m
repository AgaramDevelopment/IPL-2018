//
//  SCCollectionViewCell.m
//  APT_V2
//
//  Created by user on 14/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "SCCollectionViewCell.h"

@implementation SCCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setup];
}

-(void)setup
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_lblTopIndicator.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:_lblTopIndicator.frame.size];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _lblTopIndicator.frame;
    maskLayer.path  = maskPath.CGPath;
    self.lblTopIndicator.layer.mask = maskLayer;
    
    CALayer* layer = [CALayer layer];
    layer.borderColor = [UIColor lightGrayColor].CGColor;
    layer.borderWidth = 0.3;
    self.SCtxt1.layer.mask = layer;
    self.SCtxt2.layer.mask = layer;

    
}


@end
