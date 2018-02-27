//
//  PlannerListVC.h
//  AlphaProTracker
//
//  Created by Mac on 14/09/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlannerCell.h"

@interface PlannerListVC : UIViewController

@property (nonatomic,strong) IBOutlet PlannerCell * objPlannercell;

@property (nonatomic,strong) IBOutlet UITableView * PlannerListTbl;

@property (nonatomic,strong) NSMutableArray * objPlannerArray;

@property (strong, nonatomic) IBOutlet UIView *navi_View;
@end
