//
//  MCTossAndResultsVC.h
//  APT_V2
//
//  Created by apple on 07/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PieChartView.h"
@interface MCTossAndResultsVC : UIViewController
@property (strong, nonatomic) IBOutlet UIView *headderView;
@property (strong, nonatomic) IBOutlet UICollectionView *resultCollectionView;

- (IBAction)actionTossResults:(id)sender;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *btnToss;
- (IBAction)actionUpdateToss:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *tossView;
- (IBAction)actionTossWonAndLost:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblHomeMatch;
@property (weak, nonatomic) IBOutlet UILabel *lblAwayMatch;

@property (weak, nonatomic) IBOutlet UILabel *lblMatchWon1;
@property (weak, nonatomic) IBOutlet UILabel *lblMatchLost1;
@property (weak, nonatomic) IBOutlet UILabel *lblMatchWon2;
@property (weak, nonatomic) IBOutlet UILabel *lblMatchLost2;
@property (weak, nonatomic) IBOutlet UILabel *lbl2ndCenter;
@property (weak, nonatomic) IBOutlet UILabel *lbl1stCenter;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tossResultsSegment;

@end
