//
//  BattingOverBlockView.h
//  APT_V2
//
//  Created by apple on 26/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BattingOverBlockView : UIView <UICollectionViewDelegate,UICollectionViewDataSource>
{
    BOOL isCompe;
    BOOL isTeam;
}

@property (strong, nonatomic) IBOutlet UICollectionView *pp1CollectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *pp2CollectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *pp3CollectionView;


@property (strong, nonatomic) IBOutlet UITableView *PopTableView;

@property (strong, nonatomic) IBOutlet UIView *competView;
@property (strong, nonatomic) IBOutlet UIView *teamView;
@property (nonatomic, strong) IBOutlet UILabel *lblCompetetion;
@property (nonatomic, strong) IBOutlet UILabel *teamlbl;

@property (nonatomic, strong)IBOutlet  NSLayoutConstraint *tableWidth;
@property (nonatomic, strong)IBOutlet  NSLayoutConstraint *tableXposition;
@property (nonatomic, strong)IBOutlet  NSLayoutConstraint *tableYposition;
-(void) loadPowerPlayDetails ;


//powerplay1
@property (strong, nonatomic) IBOutlet UIProgressView *runsPrgs1;
@property (strong, nonatomic) IBOutlet UIProgressView *runratePrgs1;
@property (strong, nonatomic) IBOutlet UIProgressView *dbPerPrgs1;
@property (strong, nonatomic) IBOutlet UIProgressView *WktsPrgs1;
@property (strong, nonatomic) IBOutlet UIProgressView *srPrgs1;
@property (strong, nonatomic) IBOutlet UIProgressView *avgPrgs1;
@property (strong, nonatomic) IBOutlet UIProgressView *bdryPerPrgs1;

@property (strong, nonatomic) IBOutlet UILabel *runslbl1;
@property (strong, nonatomic) IBOutlet UILabel *runratelbl1;
@property (strong, nonatomic) IBOutlet UILabel *dbPerlbl1;
@property (strong, nonatomic) IBOutlet UILabel *wktslbl1;
@property (strong, nonatomic) IBOutlet UILabel *srlbl1;
@property (strong, nonatomic) IBOutlet UILabel *avglbl1;
@property (strong, nonatomic) IBOutlet UILabel *bdryPerlbl1;


//powerplay2
@property (strong, nonatomic) IBOutlet UIProgressView *runsPrgs2;
@property (strong, nonatomic) IBOutlet UIProgressView *runratePrgs2;
@property (strong, nonatomic) IBOutlet UIProgressView *dbPerPrgs2;
@property (strong, nonatomic) IBOutlet UIProgressView *WktsPrgs2;
@property (strong, nonatomic) IBOutlet UIProgressView *srPrgs2;
@property (strong, nonatomic) IBOutlet UIProgressView *avgPrgs2;
@property (strong, nonatomic) IBOutlet UIProgressView *bdryPerPrgs2;

@property (strong, nonatomic) IBOutlet UILabel *runslbl2;
@property (strong, nonatomic) IBOutlet UILabel *runratelbl2;
@property (strong, nonatomic) IBOutlet UILabel *dbPerlbl2;
@property (strong, nonatomic) IBOutlet UILabel *wktslbl2;
@property (strong, nonatomic) IBOutlet UILabel *srlbl2;
@property (strong, nonatomic) IBOutlet UILabel *avglbl2;
@property (strong, nonatomic) IBOutlet UILabel *bdryPerlbl2;

//powerplay3
@property (strong, nonatomic) IBOutlet UIProgressView *runsPrgs3;
@property (strong, nonatomic) IBOutlet UIProgressView *runratePrgs3;
@property (strong, nonatomic) IBOutlet UIProgressView *dbPerPrgs3;
@property (strong, nonatomic) IBOutlet UIProgressView *WktsPrgs3;
@property (strong, nonatomic) IBOutlet UIProgressView *srPrgs3;
@property (strong, nonatomic) IBOutlet UIProgressView *avgPrgs3;
@property (strong, nonatomic) IBOutlet UIProgressView *bdryPerPrgs3;

@property (strong, nonatomic) IBOutlet UILabel *runslbl3;
@property (strong, nonatomic) IBOutlet UILabel *runratelbl3;
@property (strong, nonatomic) IBOutlet UILabel *dbPerlbl3;
@property (strong, nonatomic) IBOutlet UILabel *wktslbl3;
@property (strong, nonatomic) IBOutlet UILabel *srlbl3;
@property (strong, nonatomic) IBOutlet UILabel *avglbl3;
@property (strong, nonatomic) IBOutlet UILabel *bdryPerlbl3;

@property (strong, nonatomic)  NSMutableArray *ProgressPowerPlayArray1;
@property (strong, nonatomic)  NSMutableArray *ProgressPowerPlayArray2;
@property (strong, nonatomic)  NSMutableArray *ProgressPowerPlayArray3;

@property (strong, nonatomic)  NSMutableArray *CollectionPowerPlayArray1;
@property (strong, nonatomic)  NSMutableArray *CollectionPowerPlayArray2;
@property (strong, nonatomic)  NSMutableArray *CollectionPowerPlayArray3;



@end
