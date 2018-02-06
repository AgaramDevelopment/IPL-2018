//
//  TrainingLoadVC.m
//  APT_V2
//
//  Created by MAC on 05/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "TrainingLoadVC.h"
#import "Config.h"

@interface TrainingLoadVC ()

@end

@implementation TrainingLoadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (IS_IPAD) {
        self.yesterdayViewWidth.constant = 100;
        self.yesterdayViewHeight.constant = 100;
        
        self.todayViewWidth.constant = 100;
        self.todayViewHeight.constant = 100;
    } else {
        self.yesterdayViewWidth.constant = 70;
        self.yesterdayViewHeight.constant = 70;
        
        self.todayViewWidth.constant = 70;
        self.todayViewHeight.constant = 70;
    }
    self.yesterdayView.layer.cornerRadius = self.yesterdayViewWidth.constant/2;
    self.yesterdayView.layer.borderWidth = 1;
    self.yesterdayView.layer.borderColor =[UIColor whiteColor].CGColor;
    self.yesterdayView.clipsToBounds = true;
    
    self.todayView.layer.cornerRadius = self.todayViewWidth.constant/2;
    self.todayView.layer.borderWidth = 1;
    self.todayView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.todayView.clipsToBounds = true;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
