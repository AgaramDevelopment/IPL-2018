//
//  ChangePasswordVC.h
//  APT_V2
//
//  Created by Apple on 03/04/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordVC : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *oldPasswordTF;
@property (strong, nonatomic) IBOutlet UITextField *newwPasswordTF;
@property (strong, nonatomic) IBOutlet UITextField *confirmNewPasswordTF;
@property (strong, nonatomic) IBOutlet UIView *navi_View;

@end
