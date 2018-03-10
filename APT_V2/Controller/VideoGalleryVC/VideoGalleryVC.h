//
//  VideoGalleryVC.h
//  APT_V2
//
//  Created by Apple on 09/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoGalleryVC : UIViewController

@property (strong, nonatomic) IBOutlet UICollectionView *videoCollectionview1;
@property (strong, nonatomic) IBOutlet UICollectionView *videoCollectionview2;
@property (nonatomic,strong) IBOutlet UIView * headerView;

@property (nonatomic,strong) IBOutlet UIButton * clearBtn;
@property (nonatomic,strong) IBOutlet UIImageView * CancelTextImg;

@property (weak, nonatomic) IBOutlet UIButton *btnUpload;

@end
