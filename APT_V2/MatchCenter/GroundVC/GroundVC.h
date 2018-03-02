//
//  GroundVC.h
//  APT_V2
//
//  Created by Apple on 27/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PieChartView.h"
#import "BowlTypeCell.h"
@import Charts;

@interface GroundVC : UIViewController


@property (strong, nonatomic) IBOutlet UIButton *ColorView;
@property (strong, nonatomic) IBOutlet UICollectionView *resultCollectionView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *rootView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *contentView;

@property (strong, nonatomic) IBOutlet UIView *barchart;


@property (strong, nonatomic) IBOutlet UITableView *BowlTypeTbl;

@property (nonatomic,strong) IBOutlet BowlTypeCell *objCell;
@end
