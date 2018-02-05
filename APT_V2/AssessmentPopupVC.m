//
//  AssessmentPopupVC.m
//  APT_V2
//
//  Created by MAC on 03/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "AssessmentPopupVC.h"

@interface AssessmentPopupVC ()

@end

@implementation AssessmentPopupVC

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    
        //Adds a shadow to contentView
    self.contentView.layer.masksToBounds = NO;
    self.contentView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.contentView.layer.shadowOffset = CGSizeMake(5.0f, -5.0f);
    self.contentView.layer.shadowRadius = 5;
    self.contentView.layer.shadowOpacity = 0.8f;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
