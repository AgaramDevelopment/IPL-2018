//
//  TeamHeadToHead.h
//  APT_V2
//
//  Created by Apple on 28/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamHeadToHead : UIViewController

@property (strong, nonatomic) IBOutlet UIView *headerView;

@property (nonatomic, strong) IBOutlet UITableView *Poptable;

@property (nonatomic, strong) IBOutlet UIView *team1View;
@property (nonatomic, strong) IBOutlet UIView *team2View;
@property (nonatomic, strong) IBOutlet UIView *groundView;

@property (nonatomic, strong) IBOutlet UILabel *team1lbl;
@property (nonatomic, strong) IBOutlet UILabel *team2lbl;
@property (nonatomic, strong) IBOutlet UILabel *groundlbl;


@property (nonatomic, strong) IBOutlet UIButton *firstInn;
@property (nonatomic, strong) IBOutlet UIButton *secondInn;
@property (nonatomic, strong) IBOutlet UIButton *team1win;
@property (nonatomic, strong) IBOutlet UIButton *team2win;
@property (nonatomic, strong) IBOutlet UIButton *spell1Inn;
@property (nonatomic, strong) IBOutlet UIButton *spell2Inn;
@property (nonatomic, strong) IBOutlet UIButton *spell3Inn;

@end
