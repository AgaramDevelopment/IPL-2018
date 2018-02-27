//
//  TeamOverviewVC.h
//  APT_V2
//
//  Created by MAC on 28/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamOverviewVC : UIViewController {
    NSMutableArray *teamArray;
}
@property (strong, nonatomic) IBOutlet UIView *navigationView;
@property (strong, nonatomic) IBOutlet UITextField *selectTeamTF;
@property (strong, nonatomic) IBOutlet UICollectionView *teamCollectionView;
@property (strong, nonatomic) IBOutlet UIView *selectTeamView;

@end
