//
//  ViewController.h
//  APT_V2
//
//  Created by user on 02/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tblAssesments;
//@property (weak, nonatomic) IBOutlet LineTextField *txtModule;
//@property (weak, nonatomic) IBOutlet LineTextField *txtTitle;
@property (strong, nonatomic) IBOutlet UITableView *tblDropDown;
@property (weak, nonatomic) IBOutlet LineTextField *txtModule;
@property (weak, nonatomic) IBOutlet LineTextField *txtTitle;
- (IBAction)actionOpenDate:(id)sender;

@property (strong, nonatomic) IBOutlet UIViewController *popupVC;
@property (weak, nonatomic) IBOutlet UILabel *lblAssessmentName;
@property (weak, nonatomic) IBOutlet UICollectionView *assCollection;
@property (weak, nonatomic) IBOutlet UILabel *lblRangeValue;
@property (weak, nonatomic) IBOutlet UILabel *lblRangeName;
@property (weak, nonatomic) IBOutlet UILabel *lblUnitValue;
@property (weak, nonatomic) IBOutlet UIButton *btnIgnore;
@property (weak, nonatomic) IBOutlet UITextField *txtRemarks;
@property (weak, nonatomic) IBOutlet UIView *Shadowview;

- (IBAction)actionAssessmentSave:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblNOData;

@end


