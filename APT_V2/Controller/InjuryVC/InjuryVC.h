//
//  InjuryVC.h
//  APT_V2
//
//  Created by Mac on 05/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
@interface InjuryVC : UIViewController


@property (nonatomic,strong) IBOutlet UILabel * gameLbl;
@property (nonatomic,strong) IBOutlet UILabel * TeamLbl;
@property (nonatomic,strong) IBOutlet UILabel * playerLbl;
@property (nonatomic,strong) IBOutlet UILabel * injurytypeLbl;
@property (nonatomic,strong) IBOutlet UILabel * injuryCauseLbl;
@property (nonatomic,strong) IBOutlet UILabel * assessmentLbl;
@property (nonatomic,strong) IBOutlet UILabel * onSetLbl;
@property (nonatomic,strong) IBOutlet UITextField * injuryNameTxt;
@property (nonatomic,strong) IBOutlet UITextField * cheifcomplientTxt;
@property (nonatomic,strong) IBOutlet UILabel * xrayLbl;
@property (nonatomic,strong) IBOutlet UILabel * CTScanLbl;
@property (nonatomic,strong) IBOutlet UILabel * MRILbl;
@property (nonatomic,strong) IBOutlet UILabel * BloodTestLbl;
@property (nonatomic,strong) IBOutlet UILabel * expectedLbl;
@property (nonatomic,strong) IBOutlet UIButton * updateBtn;
@property (nonatomic,strong) IBOutlet UIButton * deleteBtn;
@property (nonatomic,strong) IBOutlet UIButton * saveBtn;

@property (nonatomic,strong) IBOutlet UIButton * traumaticBtn;

@property (nonatomic,strong) IBOutlet UIButton * delayedBtn;

@property (nonatomic,strong) IBOutlet UIButton * TrainingBtn;

@property (nonatomic,strong) IBOutlet UIButton * CompetitionBtn;

@property (nonatomic,strong) IBOutlet UIButton * headerBtn;

@property (nonatomic,strong) IBOutlet UIButton * upperBtn;

@property (nonatomic,strong) IBOutlet UIButton * lowerBtn;

@property (nonatomic,strong) IBOutlet UIButton * anteriorBtn;

@property (nonatomic,strong) IBOutlet UIButton * posteriorBtn;

@property (nonatomic,strong) IBOutlet UIButton * medicalBtn;

@property (nonatomic,strong) IBOutlet UIButton * lateralBtn;

@property (nonatomic,strong) IBOutlet UIButton * rightBtn;

@property (nonatomic,strong) IBOutlet UIButton * leftBtn;

@property (nonatomic,strong) IBOutlet UIButton * expertYesBtn;

@property (nonatomic,strong) IBOutlet UIButton * expertNoBtn;

@property (nonatomic,strong) IBOutlet UILabel * occurancelbl;

@property (nonatomic,strong) IBOutlet UIButton * occurranceBtn;

@property (nonatomic,strong) IBOutlet UIView * locationselectview;

@property (nonatomic,strong) IBOutlet UILabel * locationlbl;

@end
