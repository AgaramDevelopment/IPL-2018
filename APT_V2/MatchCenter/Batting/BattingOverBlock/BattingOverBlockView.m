//
//  BattingOverBlockView.m
//  APT_V2
//
//  Created by apple on 26/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "BattingOverBlockView.h"
#import "BattingOverBlockCVC.h"

@implementation BattingOverBlockView


-(void) loadPowerPlayDetails {
    
    self.pp1CollectionView.dataSource = self;
    self.pp1CollectionView.delegate = self;
    
    self.pp2CollectionView.dataSource = self;
    self.pp2CollectionView.delegate = self;
    
    self.pp3CollectionView.dataSource = self;
    self.pp3CollectionView.delegate = self;
    
    [self.pp1CollectionView registerNib:[UINib nibWithNibName:@"BattingOverBlockCVC" bundle:nil] forCellWithReuseIdentifier:@"battingOverBlockCVC"];
    
    [self.pp2CollectionView registerNib:[UINib nibWithNibName:@"BattingOverBlockCVC" bundle:nil] forCellWithReuseIdentifier:@"battingOverBlockCVC"];
    
    [self.pp3CollectionView registerNib:[UINib nibWithNibName:@"BattingOverBlockCVC" bundle:nil] forCellWithReuseIdentifier:@"battingOverBlockCVC"];
    
}

#pragma mark UICollectionView


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;

    /*if(collectionView == self.pp1CollectionView){
        return 5;
    }else if(collectionView == self.pp2CollectionView){
        return 7;
    }else if(collectionView == self.pp3CollectionView){
        return 10;
    }else{
        return 0;
    }*/
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    
    if(collectionView == self.pp1CollectionView){
        BattingOverBlockCVC * cell = [self.pp1CollectionView dequeueReusableCellWithReuseIdentifier:@"battingOverBlockCVC" forIndexPath:indexPath];
        return cell;
        
    }else if(collectionView == self.pp2CollectionView){
        BattingOverBlockCVC * cell = [self.pp1CollectionView dequeueReusableCellWithReuseIdentifier:@"battingOverBlockCVC" forIndexPath:indexPath];
        return cell;
        
    }else if(collectionView == self.pp3CollectionView){
        BattingOverBlockCVC * cell = [self.pp1CollectionView dequeueReusableCellWithReuseIdentifier:@"battingOverBlockCVC" forIndexPath:indexPath];
        return cell;
        
    }
    
    return nil;
    
    
    
}

@end
