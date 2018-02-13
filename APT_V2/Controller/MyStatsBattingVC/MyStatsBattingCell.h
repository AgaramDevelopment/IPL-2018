//
//  MyStatsBattingCell.h
//  APT_V2
//
//  Created by MAC on 07/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyStatsBattingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *scoreView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scoreViewHeight;

//OverAll Reference Properties
@property (strong, nonatomic) IBOutlet UILabel *overallMatchesLbl;
@property (strong, nonatomic) IBOutlet UILabel *overallInningsLbl;
@property (strong, nonatomic) IBOutlet UILabel *overallNOLbl;
@property (strong, nonatomic) IBOutlet UILabel *overallRunsLbl;
@property (strong, nonatomic) IBOutlet UILabel *overallBallsLbl;
@property (strong, nonatomic) IBOutlet UILabel *overallAvgLbl;
@property (strong, nonatomic) IBOutlet UILabel *overallSRLbl;
@property (strong, nonatomic) IBOutlet UILabel *overallHundredsLbl;
@property (strong, nonatomic) IBOutlet UILabel *overallFiftiesLbl;
@property (strong, nonatomic) IBOutlet UILabel *overallThirtiesLbl;
@property (strong, nonatomic) IBOutlet UILabel *overallFoursLbl;
@property (strong, nonatomic) IBOutlet UILabel *overallSixsLbl;
@property (strong, nonatomic) IBOutlet UILabel *overallBDYPercentLbl;
@property (strong, nonatomic) IBOutlet UILabel *overallDotPercentLbl;
@property (strong, nonatomic) IBOutlet UILabel *overallHSLbl;

//Recent Match Reference Properties


@property (weak, nonatomic) IBOutlet UILabel *teamNameiPhoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *teamNameiPadLbl;
@property (weak, nonatomic) IBOutlet UIImageView *teamiPhoneImage;
@property (weak, nonatomic) IBOutlet UIImageView *teamiPadImage;
@property (weak, nonatomic) IBOutlet UILabel *teamRunsiPhoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *teamRunsiPadLbl;
@property (weak, nonatomic) IBOutlet UILabel *teamBallsiPhoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *teamBallsiPadLbl;
@property (weak, nonatomic) IBOutlet UILabel *matchDateiPhoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *matchDateiPadLbl;
@property (weak, nonatomic) IBOutlet UILabel *groundNameiPhoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *groundNameiPadLbl;



@property (weak, nonatomic) IBOutlet UILabel *matchSRiPhoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *matchSRiPadLbl;
@property (weak, nonatomic) IBOutlet UILabel *matchDotiPhoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *matchDotiPadLbl;
@property (weak, nonatomic) IBOutlet UILabel *matchBDYiPhoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *matchBDYiPadLbl;
@property (weak, nonatomic) IBOutlet UILabel *matchFoursiPhoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *matchFoursiPadLbl;

@property (weak, nonatomic) IBOutlet UILabel *matchSixsiPhoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *matchSixsiPadLbl;
@property (weak, nonatomic) IBOutlet UILabel *matchBDYFqiPhoneLbl;
@property (weak, nonatomic) IBOutlet UILabel *matchBDYFqiPadLbl;


@end
