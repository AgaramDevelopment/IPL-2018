//
//  VideoPlayerViewController.h
//  NewSportsProject
//
//  Created by user on 04/01/18.
//  Copyright © 2018 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface VideoPlayerViewController : UIViewController

@property (nonatomic,strong) NSString * objSelectVideoLink;


@property (strong, nonatomic) IBOutlet UIView *videoView;
@property (strong, nonatomic) IBOutlet UIView *rootVideoView;
@property (strong, nonatomic) IBOutlet UICollectionView *ballsColView;
@property (strong,nonatomic) AVPlayerViewController *avPlayerViewController;
@property (strong,nonatomic) AVPlayer *avPlayer;

@property (strong,readwrite) NSString* MatchCode;
@property (strong,readwrite) NSString* TeamCode;
@property (strong,readwrite) NSString* PlayerCode;
@property (strong,readwrite) NSString* VideoValue;
@property (strong,readwrite) NSString* Innings;
@property (strong,readwrite) NSString* Type;

@property (strong, nonatomic) IBOutlet UISlider *sliderVolume;
@property (strong, nonatomic) IBOutlet UIView *vidoeWithCollection;
@property (strong, nonatomic) IBOutlet UIView *customView;
@property (strong, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic, strong) NSTimer *myTimer;
@property (strong, nonatomic) IBOutlet UIButton *playAndPauseBtn;

- (IBAction)closeVideo:(id)sender;
- (IBAction)closeBtn:(id)sender;

@end
