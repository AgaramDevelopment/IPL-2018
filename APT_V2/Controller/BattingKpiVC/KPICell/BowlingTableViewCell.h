//
//  BowlingTableViewCell.h
//  NewSportsProject
//
//  Created by user on 01/01/18.
//  Copyright © 2018 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BowlingTableViewCell : UITableViewCell
#pragma mark Innings cell Properties

@property (weak, nonatomic) IBOutlet UILabel *lblInningsCount;
@property (weak, nonatomic) IBOutlet UILabel *lblRW_in;
@property (weak, nonatomic) IBOutlet UILabel *lblRuns_in;
@property (weak, nonatomic) IBOutlet UILabel *lblWkts_in;
@property (weak, nonatomic) IBOutlet UILabel *lblOvers_in;
@property (weak, nonatomic) IBOutlet UILabel *lblMaidens_in;
@property (weak, nonatomic) IBOutlet UILabel *lblEco_in;
@property (weak, nonatomic) IBOutlet UILabel *lblSR_in;
@property (weak, nonatomic) IBOutlet UILabel *lblAvg_in;
@property (weak, nonatomic) IBOutlet UILabel *lblFours_in;
@property (weak, nonatomic) IBOutlet UILabel *lblSixs_in;
@property (weak, nonatomic) IBOutlet UILabel *lblWide_in;
@property (weak, nonatomic) IBOutlet UILabel *lblNB_in;
@property (weak, nonatomic) IBOutlet UIButton *btnRuns;
@property (weak, nonatomic) IBOutlet UIButton *btnWkts;
@property (weak, nonatomic) IBOutlet UIButton *btnOvers;
@property (weak, nonatomic) IBOutlet UIButton *btnFours;
@property (weak, nonatomic) IBOutlet UIButton *btnSixs;
@property (weak, nonatomic) IBOutlet UIButton *btnWides;
@property (weak, nonatomic) IBOutlet UIButton *btnNB;

#pragma mark Session Summary cell Properties

@property (weak, nonatomic) IBOutlet UILabel *lblInningsCount_Session;
@property (weak, nonatomic) IBOutlet UILabel *lblSessionCount;
@property (weak, nonatomic) IBOutlet UILabel *lblRW_Session;
@property (weak, nonatomic) IBOutlet UILabel *lblOvers_Session;
@property (weak, nonatomic) IBOutlet UILabel *lblMaiden_Session;
@property (weak, nonatomic) IBOutlet UILabel *lblSR_Session;
@property (weak, nonatomic) IBOutlet UILabel *lblEco_Session;
@property (weak, nonatomic) IBOutlet UILabel *lblAvg_Session;
@property (weak, nonatomic) IBOutlet UILabel *lblFours_Session;
@property (weak, nonatomic) IBOutlet UILabel *lblSixs_Session;
@property (weak, nonatomic) IBOutlet UILabel *lblWD_Session;
@property (weak, nonatomic) IBOutlet UILabel *lblNB_Session;

#pragma mark Innings dayWise Header cell Properties

@property (weak, nonatomic) IBOutlet UIButton *btnDay1;
@property (weak, nonatomic) IBOutlet UIButton *btnDay2;
@property (weak, nonatomic) IBOutlet UIButton *btnDay3;
@property (weak, nonatomic) IBOutlet UIButton *btnDay4;
@property (weak, nonatomic) IBOutlet UIButton *btnDay5;
@end
