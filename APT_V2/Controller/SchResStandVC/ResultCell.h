//
//  ResultCell.h
//  APT_V2
//
//  Created by Apple on 06/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIView *shadowview;
@property (strong, nonatomic) IBOutlet UILabel *competitionNamelbl;
@property (strong, nonatomic) IBOutlet UILabel *datelbl;
@property (strong, nonatomic) IBOutlet UILabel *teamAlbl;
@property (strong, nonatomic) IBOutlet UILabel *teamBlbl;
@property (strong, nonatomic) IBOutlet UILabel *resultlbl;

@property (strong, nonatomic) IBOutlet UIImageView *teamAlogo;
@property (strong, nonatomic) IBOutlet UIImageView *teamBlogo;
@end
