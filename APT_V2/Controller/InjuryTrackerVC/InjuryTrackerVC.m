//
//  InjuryTrackerVC.m
//  APT_V2
//
//  Created by MAC on 23/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "InjuryTrackerVC.h"
#import "CustomNavigation.h"

@interface InjuryTrackerVC ()

@end

@implementation InjuryTrackerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customnavigationmethod];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)customnavigationmethod
{
    CustomNavigation *objCustomNavigation=[CustomNavigation new];
    [self.navi_View addSubview:objCustomNavigation.view];
        //    objCustomNavigation.tittle_lbl.text=@"";
    objCustomNavigation.btn_back.hidden =NO;
    objCustomNavigation.menu_btn.hidden =YES;
    [objCustomNavigation.btn_back addTarget:self action:@selector(actionBack) forControlEvents:UIControlEventTouchUpInside];
}

-(void)actionBack
{
    [appDel.frontNavigationController popViewControllerAnimated:YES];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"BACK"];
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
