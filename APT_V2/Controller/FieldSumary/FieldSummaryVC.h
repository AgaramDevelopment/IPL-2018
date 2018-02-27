//
//  FieldSummaryVC.h
//  NewSportsProject
//
//  Created by apple on 27/12/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FieldSummaryTVC.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface FieldSummaryVC : UIViewController
{
    //BOOL  isTest;
}

@property (strong, nonatomic) IBOutlet UIView *navi_View;
@property (strong, nonatomic) IBOutlet UIView *videoView;
@property (strong, nonatomic) IBOutlet UIView *rootVideoView;
@property (strong, nonatomic) IBOutlet UICollectionView *ballsColView;

@property (strong, nonatomic) IBOutlet FieldSummaryHeading *headdingTVC;
@property (strong, nonatomic) IBOutlet FieldSummaryDroppedCatches *dropCatchTVC;
@property (strong, nonatomic) IBOutlet FieldSummaryTVC *filedingSumTVC;
@property (strong, nonatomic) IBOutlet FieldSummarySubTVC *fieldingSumSubTVC;

@property (strong, nonatomic) IBOutlet UIView *testInnsView;
@property (strong, nonatomic) IBOutlet UIView *odiInnsView;

@property (strong, nonatomic) IBOutlet UIButton *testInn1Btn;
@property (strong, nonatomic) IBOutlet UIButton *testInn2Btn;
@property (strong, nonatomic) IBOutlet UIButton *testInn3Btn;
@property (strong, nonatomic) IBOutlet UIButton *testInn4Btn;
@property (strong, nonatomic) IBOutlet UIButton *odiInn1Btn;
@property (strong, nonatomic) IBOutlet UIButton *odiInn2Btn;
@property (strong, nonatomic) IBOutlet UITableView *tblView;

@property (nonatomic,strong)  NSString * matchcode;
@property (nonatomic,strong)  NSString * matchHeadding;
@property (nonatomic, assign) BOOL isTest;

@property (strong,nonatomic) AVPlayerViewController *avPlayerViewController;
@property (strong,nonatomic) AVPlayer *avPlayer;

//NSString *matchHeadding = @"India VS Srilanka 2nd Test - Eden Gardens";
//bool isTest = true;
@end
