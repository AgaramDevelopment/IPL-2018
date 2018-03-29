//
//  BlueButton.m
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/19/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import "FFBlueButton.h"
#import "PlannerVC.h"

@implementation FFBlueButton

#pragma mark - Synthesize

@synthesize event;

#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self setContentVerticalAlignment:UIControlContentVerticalAlignmentTop];
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        
        self.titleLabel.numberOfLines = 3;
        //[self setBackgroundColor:[UIColor colorWithRed:49./255. green:181./255. blue:247./255. alpha:0.5]];
        //[self colorWithHexString:@"FFFFFF"];
        
//        PlannerVC *pp =[[PlannerVC alloc]init];
//        NSMutableArray *sample =[[NSMutableArray alloc]init];
//        sample =[pp arrayWithEvents];
//        
//        UIColor *colors = [self colorWithHexString:_BgColor];
//        [self setBackgroundColor:colors];
        [self.titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
        
       // [self.titleLabel setFont:[UIFont fontWithName:@"Helivetica Neue Bold" size:7]];
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //[self.layer setBorderColor:[UIColor colorWithRed:49./255. green:181./255. blue:247./255. alpha:0.5].CGColor];
        //[self.layer setBorderWidth:1];
        
        
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    }
    return self;
}
-(UIColor*)colorWithHexString:(NSString*)hex
{
    //-----------------------------------------
    // Convert hex string to an integer
    //-----------------------------------------
    unsigned int hexint = 0;
    
    // Create scanner
    NSScanner *scanner = [NSScanner scannerWithString:hex];
    
    // Tell scanner to skip the # character
    [scanner setCharactersToBeSkipped:[NSCharacterSet
                                       characterSetWithCharactersInString:@"#"]];
    [scanner scanHexInt:&hexint];
    
    //-----------------------------------------
    // Create color object, specifying alpha
    //-----------------------------------------
    UIColor *color =
    [UIColor colorWithRed:((CGFloat) ((hexint & 0xFF0000) >> 16))/255
                    green:((CGFloat) ((hexint & 0xFF00) >> 8))/255
                     blue:((CGFloat) (hexint & 0xFF))/255
                    alpha:1.0f];
    
    return color;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
