//
//  ScoreCardVideoPlayer.m
//  APT_V2
//
//  Created by Apple on 26/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "ScoreCardVideoPlayer.h"
#import "VideoPlayerViewController.h"
#import "WebService.h"
#import "CustomNavigation.h"
#import "Config.h"
#import "AppCommon.h"
#import "BallsInVideosCVC.h"

@interface ScoreCardVideoPlayer () <TappabbleViewDelegate>
{
    NSMutableArray  *videoURLArray;
    int selectedVideo;
    AVPlayerItem* videoItem;
}

@property (strong, nonatomic) IBOutletCollection(TappabbleView) NSArray *tappableViews;
@end

@implementation TappabbleView
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //  [_delegate didTapView:self];
}
@end

@implementation ScoreCardVideoPlayer
@synthesize PlayerCode,VideoValue,Innings,Type;
@synthesize MatchCode;

@synthesize HomeVideoStr,isFromHome;

-(void)didTapView:(TappabbleView *)view
{
    if (view.tag == 1)
    {
        // Play And Pause
        [self playAndPause:nil];
    } else if (view.tag == 2)
    {
        // Previous Frame
        [self previousFrame:nil];
    } else if (view.tag == 3)
    {
        // Next Frame
        [self nextFrame:nil];
    } else if (view.tag == 4)
    {
        // Slow Forward
        [self slowForward:nil];
    } else if (view.tag == 5)
    {
        // Fast Forward
        [self fastForward:nil];
    } else if (view.tag == 6)
    {
        // Previous
        [self previous:nil];
    } else if (view.tag == 7)
    {
        // Next
        [self next:nil];
    } else if (view.tag == 8)
    {
        // Full Screen
        [self fullScreen:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.rootVideoView.hidden = YES;
    self.avPlayerViewController = [AVPlayerViewController new];
    self.avPlayerViewController.showsPlaybackControls = NO;
    selectedVideo = 0;
    
    
    if (isFromHome) {
        [self playHomeVideos:HomeVideoStr];
    }
    else
    {
        [self loadVideoPathsForPlayer:PlayerCode andValue:VideoValue type:Type inningsCount:Innings];
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark UICollectionView Delegates


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return videoURLArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BallsInVideosCVC *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ballsInVideosCVC" forIndexPath:indexPath];
    
    
    cell.ballLbl.layer.masksToBounds = true;
    cell.ballLbl.clipsToBounds = true;
    cell.ballLbl.layer.cornerRadius = cell.ballLbl.frame.size.width/2;
    NSLog(@"cell.ballLbl.layer.cornerRadius:%f", cell.ballLbl.layer.cornerRadius);
    
    
    cell.ballLbl.text = [NSString stringWithFormat:@"%ld",((long)indexPath.row+1)];
    
    if(selectedVideo == indexPath.row){
        
        cell.ballLbl.backgroundColor = [UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
        cell.ballLbl.textColor = [UIColor whiteColor];
        
    }else{
        cell.ballLbl.backgroundColor = [UIColor colorWithRed:(221/255.0f) green:(221/255.0f) blue:(221/255.0f) alpha:1.0f];
        cell.ballLbl.textColor = [UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f];
        
        
    }
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //    if (selectedVideo == (int) indexPath.row) {
    //        return;
    //    }
    selectedVideo = (int) indexPath.row;
    [self playNextVideo:selectedVideo];
    
}


-(void)playHomeVideos:(NSString *)sampleURL
{
//    dispatch_async(dispatch_get_main_queue(), ^{
        self.rootVideoView.hidden = NO;
//        [self.ballsColView reloadData];
        
        //Video Player
//        NSMutableDictionary *playerVdo =  [videoURLArray objectAtIndex:selectedVideo];
//        NSString *url = [playerVdo valueForKey:@"VIDEOFILE"];
        
        
        NSURL *videoURL = [NSURL URLWithString:[sampleURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
        
        [self.avPlayer seekToTime:CMTimeMake(0, 1)];
        [self.avPlayer pause];
        self.avPlayer = [AVPlayer playerWithURL:videoURL];
        
        self.avPlayerViewController.player = self.avPlayer;
        self.avPlayerViewController.view.frame = _videoView.bounds;
        [_videoView addSubview:self.avPlayerViewController.view];
        
        [self playAndPause:@""];
//    });

}


#pragma mark Video player methods


//GETSCORECARDVIDEOSFILEPATH/' + BatsmanCode + '/' + $scope.MatchCode + '/' + $scope.DefaultInn + '/' + value + '/' + batorbowl

-(void)loadVideoPathsForPlayer:(NSString *)batsmanCode andValue:(NSString *) value type:(NSString *) batOrBowl inningsCount:(NSString *)innno
{
    
    [AppCommon showLoading];
    WebService *objWebservice = [[WebService alloc]init];
    
    
    [objWebservice GetVideoPathFile :GetVideoFilePath  :batsmanCode :MatchCode : innno :value : batOrBowl success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSLog(@"responseObject=%@",responseObject);
        if(responseObject >0)
        {
            
            NSMutableDictionary *dic1 = [[NSMutableDictionary alloc]init];
            [dic1 setDictionary:responseObject];
            
            videoURLArray= [[NSMutableArray alloc] init];
            videoURLArray =  [dic1 valueForKey:@"lstScoreCardVideoFilePathValuesRuns"];
            
            if(videoURLArray.count >0){
                selectedVideo = 0;
                //                self.rootVideoView.hidden = NO;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.rootVideoView.hidden = NO;
                    [self.ballsColView reloadData];
                    
                    //Video Player
                    NSMutableDictionary *playerVdo =  [videoURLArray objectAtIndex:selectedVideo];
                    NSString *url = [playerVdo valueForKey:@"VIDEOFILE"];
                    
                    
                    
                    NSURL *videoURL = [NSURL URLWithString:url];
                    
                    [self.avPlayer seekToTime:CMTimeMake(0, 1)];
                    [self.avPlayer pause];
                    self.avPlayer = [AVPlayer playerWithURL:videoURL];
                    
                    self.avPlayerViewController.player = self.avPlayer;
                    self.avPlayerViewController.view.frame = _videoView.bounds;
                    [_videoView addSubview:self.avPlayerViewController.view];
                    
                    [self playAndPause:@""];
                });
                
                
                
                
                //                [self.avPlayerViewController.view removeFromSuperview];
                //                self.avPlayer = NULL;
                
                
                
                
                //                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:_avPlayerViewController.player ];
                
                
                //                self.avPlayerViewController = [AVPlayerViewController new];
                
                //                [self.videoView addSubview:self.customView];
                //                [self.videoView addSubview:self.progressView];
                //                [self.avPlayer play];
                
                //                self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
                
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.rootVideoView.hidden = YES;
                    [self.avPlayer seekToTime:CMTimeMake(0, 1)];
                    [self.avPlayer pause];
                    //    [self.avPlayerViewController.view removeFromSuperview];
                    //    self.avPlayer = NULL;
                    
                    //    _rootVideoView.hidden = YES;
                    [self dismissViewControllerAnimated:YES completion:nil];
                });
            }
            //[self setDataDictInTableView: dic1];
            
        }
        
        [AppCommon hideLoading];
        self.view.userInteractionEnabled = true;
    } failure:^(AFHTTPRequestOperation *operation, id error) {
        //NSLog(@"failed");
        [COMMON webServiceFailureError:error];
        self.view.userInteractionEnabled = true;
    }];
}

-(void)itemDidFinishPlaying:(NSNotification *) notification {
    
    if((selectedVideo+1)<videoURLArray.count){
        selectedVideo = selectedVideo +1;
        
        [self.ballsColView reloadData];
        
        NSMutableDictionary *playerVdo =  [videoURLArray objectAtIndex:selectedVideo];
        NSString *url = [playerVdo valueForKey:@"VIDEOFILE"];
        
        
        
        NSURL *videoURL = [NSURL URLWithString:url];
        
        [self.avPlayer seekToTime:CMTimeMake(0, 1)];
        [self.avPlayer pause];
        //        [self.avPlayerViewController.view removeFromSuperview];
        //        self.avPlayer = NULL;
        
        
        self.avPlayer = [AVPlayer playerWithURL:videoURL];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:_avPlayer];
        
        
        //        self.avPlayerViewController.player = self.avPlayer;
        //        self.avPlayerViewController.view.frame = _videoView.bounds;
        //        [_videoView addSubview:self.avPlayerViewController.view];
        
        //        [self.avPlayer play];
    }
    
}


- (IBAction)closeVideo:(id)sender {
    
    
    [self.avPlayer seekToTime:CMTimeMake(0, 1)];
    [self.avPlayer pause];
    //    [self.avPlayerViewController.view removeFromSuperview];
    //    self.avPlayer = NULL;
    
    //    _rootVideoView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void) playNextVideo:(int) nextVideo {
    
    self.progressView.progress = 0;
    selectedVideo = nextVideo;
    
    NSMutableDictionary *playerVdo =  [videoURLArray objectAtIndex:selectedVideo];
    NSString *url = [playerVdo valueForKey:@"VIDEOFILE"];
    
    
    
    NSURL *videoURL = [NSURL URLWithString:url];
    
    [self.avPlayer seekToTime:CMTimeMake(0, 1)];
    [self.avPlayer pause];
    //    [self.avPlayerViewController.view removeFromSuperview];
    //    self.avPlayer = NULL;
    
    
    //    self.avPlayer = [AVPlayer playerWithURL:videoURL];
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:_avPlayerViewController.player ];
    
    //    self.avPlayerViewController.player = self.avPlayer;
    //    self.avPlayerViewController.view.frame = _videoView.bounds;
    //    [_videoView addSubview:self.avPlayerViewController.view];
    //    [self.videoView addSubview:self.customView];
    
    videoItem = [AVPlayerItem playerItemWithURL:videoURL];
    [self.avPlayer replaceCurrentItemWithPlayerItem:videoItem];
    //    [self.avPlayer play];
    //    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(setUpProgressView:) userInfo:nil repeats:YES];
    [self playAndPause:@""];
    [self.ballsColView reloadData];
}


- (IBAction)playAndPause:(id)sender {
    
    if (self.avPlayer.rate == 0) {
        //        [self.avPlayer setRate:1.0];
        [self.avPlayer play];
        UIImage *pause = [UIImage imageNamed:@"pause"];
        [self.playAndPauseBtn setImage:pause forState:UIControlStateNormal];
        
        //        CMTime totalDuration = self.avPlayer.currentItem.duration;
        //        CMTime currentTime = self.avPlayer.currentItem.currentTime;
        
        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(setUpProgressView:) userInfo:nil repeats:YES];
        
    } else {
        //        self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
        [self.avPlayer pause];
        UIImage *play = [UIImage imageNamed:@"play"];
        [self.playAndPauseBtn setImage:play forState:UIControlStateNormal];
    }
}
- (IBAction)previousFrame:(id)sender {
    [self.avPlayer.currentItem stepByCount:-5];
    UIImage *play = [UIImage imageNamed:@"play"];
    [self.playAndPauseBtn setImage:play forState:UIControlStateNormal];
}
- (IBAction)nextFrame:(id)sender {
    [self.avPlayer.currentItem stepByCount:5];
    UIImage *play = [UIImage imageNamed:@"play"];
    [self.playAndPauseBtn setImage:play forState:UIControlStateNormal];
}
- (IBAction)slowForward:(id)sender {
    //0.0 to 1.0 Slow Forward
    /*
     if (self.avPlayer.rate >= 0.0 && self.avPlayer.rate <= 1.0) {
     [self.avPlayer setRate:self.avPlayer.rate - 0.2];
     
     UIImage *pause = [UIImage imageNamed:@"pause"];
     [self.playAndPauseBtn setImage:pause forState:UIControlStateNormal];
     }
     */
    [self.avPlayer setRate: 0.5];
}
- (IBAction)fastForward:(id)sender {
    //1.0 to 2.0 Fast Forward
    //-1.0 means reversly playing
    /*
     if (self.avPlayer.rate >= 1.0 && self.avPlayer.rate <= 2.0) {
     [self.avPlayer setRate:self.avPlayer.rate + 0.2];
     UIImage *pause = [UIImage imageNamed:@"pause"];
     [self.playAndPauseBtn setImage:pause forState:UIControlStateNormal];
     }
     */
    [self.avPlayer setRate: 1.5];
}
- (IBAction)previous:(id)sender {
    if (selectedVideo == 0) {
        return;
    }
    [self playNextVideo:--selectedVideo];
}
- (IBAction)next:(id)sender {
    if (selectedVideo == videoURLArray.count-1) {
        return;
    }
    [self playNextVideo:++selectedVideo];
}
- (IBAction)fullScreen:(id)sender {
    //    CGSize temp  = self.vidoeWithCollection.frame.size ;
    //    //    CGSizeEqualToSize(CGSizeZero, mySize)
    //    if ( CGSizeEqualToSize(temp, normalSize)) {
    //        self.vidoeWithCollection.frame = self.view.frame;
    //        self.avPlayerViewController.view.frame = self.view.frame;
    //        self.customView.frame = CGRectMake(0, self.videoView.frame.size.height-self.customView.frame.size.height, self.customView.frame.size.width, self.customView.frame.size.height);
    //        self.ballsColView.frame = CGRectMake(0, CGRectGetMaxY(self.customView.frame)+self.ballsColView.frame.size.height, self.ballsColView.frame.size.width, self.ballsColView.frame.size.height);
    //    } else {
    //        self.vidoeWithCollection.frame = CGRectMake(30, self.view.frame.size.height-self.view.frame.size.height, self.view.frame.size.width-60, 536);
    //        self.avPlayerViewController.view.frame = CGRectMake(30, 40, self.vidoeWithCollection.frame.size.width-60, 400);
    //    }
}
- (IBAction)volume:(id)sender {
    //0.0 to 1.0 Silenect to Maximum Volume
    self.avPlayer.volume = self.sliderVolume.value;
    NSLog(@"Volume:%f", self.avPlayer.volume);
}

- (void) setUpProgressView:(NSTimer *)timer
{
    float totalDuration = CMTimeGetSeconds(self.avPlayer.currentItem.duration);
    float currentTime = CMTimeGetSeconds(self.avPlayer.currentItem.currentTime);
    NSLog(@"totalDuration:%f", totalDuration);
    NSLog(@"currentTime:%f", currentTime);
    float progressValue = currentTime/totalDuration;
    self.progressView.progress = progressValue;
    
    if (currentTime ==  totalDuration) {
        [self.myTimer invalidate];
        self.myTimer = nil;
        self.progressView.progress = 0;
        UIImage *play = [UIImage imageNamed:@"play"];
        [self.playAndPauseBtn setImage:play forState:UIControlStateNormal];
    }
}

@end

