//
//  TrainingLoadVC.h
//  APT_V2
//
//  Created by MAC on 05/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrainingLoadVC : UIViewController
@property (strong, nonatomic) IBOutlet UIView *yesterdayView;
@property (strong, nonatomic) IBOutlet UIView *todayView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *yesterdayViewWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *yesterdayViewHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *todayViewWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *todayViewHeight;

@property (strong, nonatomic) IBOutlet UIView *yesterdayMainView;
@property (strong, nonatomic) IBOutlet UIView *todayMainView;

//Donar Charts
@property (strong, nonatomic) IBOutlet NSMutableArray *markers;
@end
