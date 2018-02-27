//
//  SessionPartCell.h
//  NewSportsProject
//
//  Created by Mac on 28/12/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SessionPartCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel * playerA;
@property (nonatomic,strong) IBOutlet UILabel * playerB;
@property (nonatomic,strong) IBOutlet UILabel * runs;

@property (nonatomic,strong) IBOutlet UIProgressView * pr1;
@property (nonatomic,strong) IBOutlet UIProgressView * pr2;



@end
