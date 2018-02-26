//
//  BattingOverBlockView.h
//  APT_V2
//
//  Created by apple on 26/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BattingOverBlockView : UIView <UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *pp1CollectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *pp2CollectionView;
@property (strong, nonatomic) IBOutlet UICollectionView *pp3CollectionView;
-(void) loadPowerPlayDetails ;


@end
