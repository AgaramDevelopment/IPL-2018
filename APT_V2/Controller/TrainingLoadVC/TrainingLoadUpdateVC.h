//
//  TrainingLoadUpdateVC.h
//  APT_V2
//
//  Created by MAC on 05/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrainingLoadUpdateVC : UIViewController
{
    NSMutableArray *sessionArray;
    NSMutableArray *activityArray;
    NSMutableArray *valueArray;
}
@property (strong, nonatomic) IBOutlet UIButton *sessionBtn;
@property (strong, nonatomic) IBOutlet UIView *countview;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *countViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *countViewWidth;
@property (strong, nonatomic) IBOutlet UIView *todayMainView;

    //Donar Charts
@property (strong, nonatomic) IBOutlet NSMutableArray *markers;

@end
