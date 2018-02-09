//
//  AddWellnessRatingVC.m
//  APT_V2
//
//  Created by Apple on 07/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "AddWellnessRatingVC.h"

@interface AddWellnessRatingVC ()

@end

@implementation AddWellnessRatingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)sliderDidChange:(RGSColorSlider *)sender{
    //self.colorView.backgroundColor = sender.color;
    
    sender.showPreview = NO;
    
}

- (CGRect)trackRectForBounds:(CGRect)bounds {
    CGRect rect = CGRectMake(0, 0, 100, 30);//change it to any size you want
    return rect;
}

@end
