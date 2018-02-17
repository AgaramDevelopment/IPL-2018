//
//  TeamMembersVC.h
//  APT_V2
//
//  Created by MAC on 12/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamMembersVC : UIViewController

@property (strong, nonatomic) IBOutlet UICollectionView *playesTable;
@property (strong, nonatomic) IBOutlet UILabel *TeamName;
@property (strong, nonatomic)  NSString *teamCode;

@end
