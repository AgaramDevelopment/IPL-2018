//
//  PlayersCell.h
//  NewSportsProject
//
//  Created by MAC on 27/12/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayersCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *playerImage;
@property (strong, nonatomic) IBOutlet UILabel *firstInningsScoreLbl;
@property (strong, nonatomic) IBOutlet UILabel *secondInningsScoreLbl;
@property (strong, nonatomic) IBOutlet UILabel *playerNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *verticalLineLabel;
@property (strong, nonatomic) IBOutlet UILabel *inningsScoreLbl;

@end
