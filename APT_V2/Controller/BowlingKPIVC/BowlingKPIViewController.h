//
//  BowlingKPIViewController.h
//  NewSportsProject
//
//  Created by user on 01/01/18.
//  Copyright © 2018 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface BowlingKPIViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *navi_View;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayerName;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayerDesignation;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayerRole;
@property (weak, nonatomic) IBOutlet UIImageView *imgviewPlayer;
@property (weak, nonatomic) IBOutlet UIButton *lblTeam1;
@property (weak, nonatomic) IBOutlet UIButton *lblTeam2;
@property (weak, nonatomic) IBOutlet UILabel *lblTest1;
@property (weak, nonatomic) IBOutlet UILabel *lblTest2;
@property (weak, nonatomic) IBOutlet UITableView *tblBowling;
@property (weak, nonatomic) IBOutlet UILabel *lblSeparator;

@property (strong,readwrite) NSString* SelectedMatchCode;
@property (strong,readwrite) NSString* SelectedTeamCode;
@property (strong,readwrite) NSString* SelectedPlayerCode;
@property (strong,readwrite) NSString* ScreenTitle;

@property (strong, nonatomic) IBOutlet UIView *videoView;
@property (strong, nonatomic) IBOutlet UIView *rootVideoView;
@property (strong, nonatomic) IBOutlet UICollectionView *ballsColView;
@property (strong,nonatomic) AVPlayerViewController *avPlayerViewController;
@property (strong,nonatomic) AVPlayer *avPlayer;

@end
