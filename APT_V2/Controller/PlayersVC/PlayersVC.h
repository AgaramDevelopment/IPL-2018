//
//  PlayersVC.h
//  NewSportsProject
//
//  Created by Mac on 27/12/17.
//  Copyright © 2017 agaraminfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface PlayersVC : UIViewController {
    int team1MaxBatsmanCount;
    int team2MaxBatsmanCount;
    int numberOfItems;
    NSMutableArray *BatsmanDetailsArray11;
    NSMutableArray *BatsmanDetailsArray33;
    NSMutableArray *BatsmanDetailsArray22;
    NSMutableArray *BatsmanDetailsArray44;
    NSMutableArray *commonArray;
    NSMutableArray *commonArray1;
    NSMutableArray *commonArray2;
}

@property (strong, nonatomic) IBOutlet UIView *navi_View;
@property (nonatomic,strong) IBOutlet UICollectionView * GridTbl;
@property (strong, nonatomic) IBOutlet UIButton *team1Btn;
@property (strong, nonatomic) IBOutlet UIButton *team2Btn;

@property (nonatomic, assign) NSInteger indexPath;
@property (nonatomic,strong)  NSMutableArray * inningsDetailsArray;
@property (nonatomic,strong)  NSMutableArray * matchDetailss;
@property (nonatomic,strong)  NSMutableArray *BatsmanDetailsArray1;
@property (nonatomic,strong) NSMutableArray *BatsmanDetailsArray2;
@property (nonatomic,strong) NSMutableArray *BatsmanDetailsArray3;
@property (nonatomic,strong) NSMutableArray *BatsmanDetailsArray4;

@property (nonatomic,strong)  NSMutableArray *BowlingDetailsArray1;
@property (nonatomic,strong) NSMutableArray *BowlingDetailsArray2;
@property (nonatomic,strong) NSMutableArray *BowlingDetailsArray3;
@property (nonatomic,strong) NSMutableArray *BowlingDetailsArray4;


@property (nonatomic,strong) NSString *matchcode;
@end
