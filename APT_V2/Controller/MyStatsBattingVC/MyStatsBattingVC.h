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

@property (assign, nonatomic) NSIndexPath *selectedRowIndex;
@property (strong, nonatomic) IBOutlet UITableView *batttingTableView;
@property (nonatomic,strong) IBOutlet MyStatsBattingCell * StatsBattingCell;
@property (nonatomic,strong) IBOutlet MyStatsBattingCell * StatsBattingCellIphone;

@end
