//
//  CustomNavigation.m
//  AlphaProTracker
//
//  Created by Mac on 22/08/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import "CustomNavigation.h"

@interface CustomNavigation ()

@end

@implementation CustomNavigation

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.view.frame))];
    self.common_view.backgroundColor = DEFAULT_COLOR_BLUE;
    self.btn_back.hidden =YES;
    self.menu_btn.hidden =YES;
    self.cartBtn.hidden=YES;
    self.ticketBtn.hidden=YES;
}

- (BOOL)shouldAutorotate {
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
