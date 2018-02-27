//
//  IllnessTracker.h
//  APT_V2
//
//  Created by MAC on 26/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IllnessTracker : UIViewController
@property (strong, nonatomic) IBOutlet UIView *navigationView;
@property (strong, nonatomic) IBOutlet UITextField *expectedDateTF;
@property (strong, nonatomic) IBOutlet UITextField *onsetDateTF;
@property (strong, nonatomic) IBOutlet UITextField *illnessNameTF;
@property (strong, nonatomic) IBOutlet UITextField *chiefCompliantTF;
@property (strong, nonatomic) IBOutlet UITextField *affectSystemTF;
@property (strong, nonatomic) IBOutlet UITextField *mainSymptomTF;
@property (strong, nonatomic) IBOutlet UITextField *causeOfIllnessTF;
@property (strong, nonatomic) IBOutlet UIButton *expertYesBtn;
@property (strong, nonatomic) IBOutlet UIButton *expertNoBtn;
@property (strong, nonatomic) IBOutlet UIView *affectSystemView;
@property (strong, nonatomic) IBOutlet UIView *mainSymptomView;
@property (strong, nonatomic) IBOutlet UIView *causeIllnessView;
@property (strong, nonatomic) IBOutlet UIView *filePopView;
@property (strong, nonatomic) IBOutlet UIButton *affectSystemBtn;
@property (strong, nonatomic) IBOutlet UIButton *mainSymptomBtn;
@property (strong, nonatomic) IBOutlet UIButton *causeBtn;




@end
