//
//  ChangePasswordVC.m
//  APT_V2
//
//  Created by Apple on 03/04/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "ChangePasswordVC.h"
#import "AppCommon.h"
#import "AppDelegate.h"

@interface ChangePasswordVC ()

@end

@implementation ChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)didClickCancelBtn:(id)sender
{
    [appDel.frontNavigationController popViewControllerAnimated:YES];
}

-(IBAction)didClickSubmitBtn:(id)sender
{
    [appDel.frontNavigationController popViewControllerAnimated:YES];
}

@end
