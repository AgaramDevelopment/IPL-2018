//
//  VideoGalleryCell.h
//  APT_V2
//
//  Created by Apple on 09/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoGalleryCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIView *shadowview;
@property (nonatomic,strong) IBOutlet UILabel * batting_lbl;
@property (nonatomic,strong) IBOutlet UILabel * playername_lbl;
@property (nonatomic,strong) IBOutlet UILabel * date_lbl;
@end
