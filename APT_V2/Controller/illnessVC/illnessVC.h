//
//  illnessVC.h
//  APT_V2
//
//  Created by MAC on 09/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface illnessVC : UIViewController
{
    NSMutableArray *illnessArray;
}

@property (strong, nonatomic) IBOutlet UIView *headerView;

@property (strong, nonatomic) IBOutlet UITableView *illnessTableView;
@property (weak, nonatomic) IBOutlet UIView *navBarView;

@end
