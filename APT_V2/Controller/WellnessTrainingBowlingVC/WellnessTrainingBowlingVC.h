//
//  WellnessTrainingBowlingVC.h
//  APT_V2
//
//  Created by Apple on 07/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Charts;


@interface WellnessTrainingBowlingVC : UIViewController

@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *commonView;
@property (strong, nonatomic) IBOutlet UIView *trainingview;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll;

@property (strong, nonatomic) IBOutlet UIView *bowlingLoadView;

@property (strong, nonatomic) IBOutlet UILabel *bodyWeightlbl;
@property (strong, nonatomic) IBOutlet UILabel *sleepHrlbl;
@property (strong, nonatomic) IBOutlet UILabel *ratinglbl;

@property (strong, nonatomic) IBOutlet UILabel *sleeplbl;
@property (strong, nonatomic) IBOutlet UILabel *fatiquelbl;
@property (strong, nonatomic) IBOutlet UILabel *musclelbl;
@property (strong, nonatomic) IBOutlet UILabel *stresslbl;



@property (strong, nonatomic) IBOutlet UIView *SleepColorView;
@property (strong, nonatomic) IBOutlet UIView *FatiqueColorView;
@property (strong, nonatomic) IBOutlet UIView *MuscleColorView;
@property (strong, nonatomic) IBOutlet UIView *StressColorView;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topviewHeight;

-(BOOL)setHeight;

@end
