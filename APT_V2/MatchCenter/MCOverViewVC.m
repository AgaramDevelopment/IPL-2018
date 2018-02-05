//
//  MCOverViewVC.m
//  APT_V2
//
//  Created by apple on 05/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "MCOverViewVC.h"
#import "MCOverViewResultCVC.h"
#import "CustomNavigation.h"

@interface MCOverViewVC ()

@end

@implementation MCOverViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    
    [self.resultCollectionView registerNib:[UINib nibWithNibName:@"MCOverViewResultCVC" bundle:nil] forCellWithReuseIdentifier:@"mcResultCVC"];
    
   // [_scrollView contentSize ]
   // _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, 3000);

    _scrollView.contentSize = _contentView.frame.size;
    
}

-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.headerView addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"OverView";
    objCustomNavigation.btn_back.hidden = YES;
    objCustomNavigation.home_btn.hidden = YES;
//    [objCustomNavigation.btn_back addTarget:self action:@selector(MenuBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if(collectionView == _resultCollectionView){
        return 3;
    }else{
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if(collectionView == self.resultCollectionView){
        
        
        
        MCOverViewResultCVC* cell = [self.resultCollectionView dequeueReusableCellWithReuseIdentifier:@"mcResultCVC" forIndexPath:indexPath];
        
        
        
        return cell;
        
    }
    return nil;
    
}


@end
