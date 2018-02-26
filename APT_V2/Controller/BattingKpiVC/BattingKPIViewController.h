//
//  BattingKPIViewController.h
//  NewSportsProject
//
//  Created by user on 27/12/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>


@interface BattingKPIViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *navi_View;
@property (weak, nonatomic) IBOutlet UIButton *btnCountry1;
@property (weak, nonatomic) IBOutlet UIButton *btnCountry2;
@property (weak, nonatomic) IBOutlet UILabel *lblSelectedCountry;
@property (weak, nonatomic) IBOutlet UIImageView *imgviewPlayer;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayerName;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayerDesignation;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayerSpeciality;
@property (weak, nonatomic) IBOutlet UITableView *tblBattingKPI;
@property (weak, nonatomic) IBOutlet UILabel *lbl1st_Inn_Runs;
@property (weak, nonatomic) IBOutlet UILabel *lbl1st_inn_Balls;
@property (weak, nonatomic) IBOutlet UILabel *lbl2nd_inn_Runs;
@property (weak, nonatomic) IBOutlet UILabel *lbl2nd_inn_Balls;
@property (weak, nonatomic) IBOutlet UILabel *lblSeparator;

@property (strong, nonatomic) IBOutlet UIView *videoView;
@property (strong, nonatomic) IBOutlet UIView *rootVideoView;
@property (strong, nonatomic) IBOutlet UICollectionView *ballsColView;
@property (strong,nonatomic) AVPlayerViewController *avPlayerViewController;
@property (strong,nonatomic) AVPlayer *avPlayer;
/*
 {MATCHCODE}/{TEAMCODE}/{PLAYERCODE}
 */
@property (strong,readwrite) NSString* SelectedMatchCode;
@property (strong,readwrite) NSString* SelectedTeamCode;
@property (strong,readwrite) NSString* SelectedPlayerCode;
@property (strong,readwrite) NSString* ScreenTitle;




@end
