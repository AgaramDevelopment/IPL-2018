//
//  MyStatsBattingVC.h
//  APT_V2
//
//  Created by MAC on 06/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyStatsBattingCell.h"
@interface MyStatsBattingVC : UIViewController
{
    NSMutableArray *overAllArray;
    NSMutableArray *recentMatchesArray;
    NSMutableArray *matchDetailsArray;
}

@property (assign, nonatomic) NSIndexPath *selectedRowIndex;
@property (strong, nonatomic) IBOutlet UITableView *batttingTableView;
@property (nonatomic,strong) IBOutlet MyStatsBattingCell * StatsBattingCell;
@property (nonatomic,strong) IBOutlet MyStatsBattingCell * StatsBattingCellIphone;
@property (strong, nonatomic) IBOutlet UIView *navigationView;
@property (strong, nonatomic) IBOutlet UIButton *battingBtn;
@property (strong, nonatomic) IBOutlet UIButton *bowlingBtn;


@property (nonatomic,strong) NSString *selectRuns;
    //wagon
@property (nonatomic,strong) NSMutableArray * wagonWheelDrawData;
    //pitch
@property (nonatomic,strong) NSMutableArray * pitchData;

@end
