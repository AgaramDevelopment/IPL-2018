//
//  DropDownTableViewController.h
//  APT_V2
//
//  Created by user on 05/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDownTableViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tblDropDown;

@property (strong,nonatomic)NSMutableArray* array;
@end
