//
//  BattingTableViewCell.h
//  NewSportsProject
//
//  Created by user on 27/12/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BattingTableViewCell : UITableViewCell

#pragma mark Innings cell Properties

@property (weak, nonatomic) IBOutlet UILabel *lblInningsCount;
@property (weak, nonatomic) IBOutlet UILabel *lblRuns_in;
@property (weak, nonatomic) IBOutlet UILabel *lblBalls_in;
@property (weak, nonatomic) IBOutlet UILabel *lblDB_in;
@property (weak, nonatomic) IBOutlet UILabel *lblB_in;
@property (weak, nonatomic) IBOutlet UILabel *lblSR_in;
@property (weak, nonatomic) IBOutlet UILabel *lblOne_in;
@property (weak, nonatomic) IBOutlet UILabel *lblTwo_in;
@property (weak, nonatomic) IBOutlet UILabel *lblThree_in;
@property (weak, nonatomic) IBOutlet UILabel *lblFour_in;
@property (weak, nonatomic) IBOutlet UILabel *lblSix_in;
@property (weak, nonatomic) IBOutlet UIButton *btnRuns;
@property (weak, nonatomic) IBOutlet UIButton *btnBalls;
@property (weak, nonatomic) IBOutlet UIButton *btnOnes;
@property (weak, nonatomic) IBOutlet UIButton *btnTwos;
@property (weak, nonatomic) IBOutlet UIButton *btnThrees;
@property (weak, nonatomic) IBOutlet UIButton *btnFours;
@property (weak, nonatomic) IBOutlet UIButton *btnSixs;

#pragma mark Session Summary cell Properties

@property (weak, nonatomic) IBOutlet UILabel *lblInningsCount_Session;
@property (weak, nonatomic) IBOutlet UILabel *lblSessionCount;
@property (weak, nonatomic) IBOutlet UILabel *lblRuns_Session;
@property (weak, nonatomic) IBOutlet UILabel *lblBalls_Session;
@property (weak, nonatomic) IBOutlet UILabel *lblDB_Session;
@property (weak, nonatomic) IBOutlet UILabel *lblSR_Session;
@property (weak, nonatomic) IBOutlet UILabel *lblOnes_Session;
@property (weak, nonatomic) IBOutlet UILabel *lblTwos_Session;
@property (weak, nonatomic) IBOutlet UILabel *lblThrees_Session;
@property (weak, nonatomic) IBOutlet UILabel *lblFours_Session;
@property (weak, nonatomic) IBOutlet UILabel *lblSixs_Session;

#pragma mark Innings dayWise Header cell Properties

@property (weak, nonatomic) IBOutlet UIButton *btnDay1;
@property (weak, nonatomic) IBOutlet UIButton *btnDay2;
@property (weak, nonatomic) IBOutlet UIButton *btnDay3;
@property (weak, nonatomic) IBOutlet UIButton *btnDay4;
@property (weak, nonatomic) IBOutlet UIButton *btnDay5;



@end
