//
//  MCTossAndResultsVC.m
//  APT_V2
//
//  Created by apple on 07/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "MCTossAndResultsVC.h"
#import "CustomNavigation.h"
#import "PlayerListCollectionViewCell.h"
#import "Config.h"
#import "SWRevealViewController.h"

@interface MCTossAndResultsVC ()
{
    NSArray* headingKeyArray;
    NSArray* headingButtonNames;

    
}
@end

@implementation MCTossAndResultsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    
    
    
    headingKeyArray =  @[@"Opponent",@"Toss Won",@"Elected To",@"Condition",@"Venue",@"Bat 1st Par\nScore",@"Bat 1st - Team",@"Bat 1st \nScore",@"Bat 2nd \nTeam",@"Bat 2nd \nScore",@"Won Team",@"Margin",@"Points"];
    
    
    headingButtonNames = @[@"Opponent",@"Toss Won",@"Elected To",@"Condition",@"Venue",@"Bat 1st Par\nScore",@"Bat 1st - Team",@"Bat 1st \nScore",@"Bat 2nd \nTeam",@"Bat 2nd \nScore",@"Won Team",@"Margin",@"Points"];
    
    

     [self.resultCollectionView registerNib:[UINib nibWithNibName:@"PlayerListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ContentCellIdentifier"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.headderView addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"Toss & Results";
    objCustomNavigation.btn_back.hidden = YES;
    objCustomNavigation.home_btn.hidden = YES;
    objCustomNavigation.menu_btn.hidden =NO;
    
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];

    
    [objCustomNavigation.menu_btn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];

}



#pragma mark UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
   
    return headingButtonNames.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return headingButtonNames.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(IS_IPHONE_DEVICE)
    {
        if(!IS_IPHONE5)
        {
            return CGSizeMake(130, 35);
        }
        else
        {
            
            return CGSizeMake(150, 40);
        }
    }
    else
    {
        
        return CGSizeMake(200, 50);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    PlayerListCollectionViewCell* cell = [self.resultCollectionView dequeueReusableCellWithReuseIdentifier:@"ContentCellIdentifier" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
      
            cell.backgroundColor = [UIColor colorWithRed:44.0/255.0 green:167.0/255.0 blue:219.0/255.0 alpha:1.0];
            
        
        
        [cell.lblRightShadow setHidden:YES];
        cell.btnName.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        cell.btnName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        
        for (id value in headingButtonNames) {
            
            if ([headingButtonNames indexOfObject:value] == indexPath.row) {
                [cell.btnName setTitle:value forState:UIControlStateNormal];
                //[cell.btnName addTarget:self action:@selector(btnActionForSorting:) forControlEvents:UIControlEventTouchUpInside];
              //  cell.btnName.tag = [[tagArray objectAtIndex:indexPath.row] integerValue];
                cell.btnName.secondTag = indexPath.row;
                cell.btnName.titleLabel.numberOfLines = 2;
//                if (indexPath.row == 16) {
//                    [cell.btnName setTitle:[headingButtonNames objectAtIndex:indexPath.row] forState:UIControlStateNormal];
//
//                }else if (indexPath.row == 17) {
//                    [cell.btnName setTitle:[headingButtonNames objectAtIndex:indexPath.row] forState:UIControlStateNormal];
//
//                }else if (indexPath.row == 18) {
//                    [cell.btnName setTitle:[headingButtonNames objectAtIndex:indexPath.row] forState:UIControlStateNormal];
//
//                }else if (indexPath.row == 19) {
//                    [cell.btnName setTitle:[headingButtonNames objectAtIndex:indexPath.row] forState:UIControlStateNormal];
//
//                }
//                if ([selectedHeading isEqualToString: cell.btnName.titleLabel.text]) {
//                    [cell.btnName setTitleColor: [ UIColor colorWithRed:(13/255.0f) green:(43/255.0f) blue:(129/255.0f) alpha:1.0f] forState:UIControlStateNormal];
//                }
//                else{
//                    [cell.btnName setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//                }
                
                
                break;
            }
        }
        cell.btnName.userInteractionEnabled = YES;
        
    }
    else
    {
        [cell.lblRightShadow setHidden:(indexPath.row == 0 ? NO : YES)];
        if (!cell.lblRightShadow.isHidden) {
            cell.lblRightShadow.clipsToBounds = NO;
            [self setShadow:cell.lblRightShadow.layer];
        }
        
        if (indexPath.section % 2 != 0) {
            cell.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0];
            
        }else
        {
            cell.backgroundColor = [UIColor whiteColor];
        }
        [cell.btnName setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        
        cell.btnName.userInteractionEnabled = NO;
        
        
        for (id temp in headingKeyArray) {
            if ([headingKeyArray indexOfObject:temp] == indexPath.row) {
               // NSString* str = [AppCommon checkNull:[[PlayerListArray objectAtIndex:indexPath.section-1]valueForKey:temp]];
                if([temp isEqualToString:@"Opponent"])
                {
                    cell.btnName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                    cell.btnName.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
                    //NSLog(@"Player Name %@ ",str);
                }
                else
                {
                    cell.btnName.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
                    cell.btnName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                }
                [cell.btnName setTitle:[NSString stringWithFormat:@"Test %ld",indexPath.section-1] forState:UIControlStateNormal];
                break;
            }
        }
        
    }
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return;
    }
//    PlayerStatsVC * nextVC = [[PlayerStatsVC alloc]init];
//    nextVC = (PlayerStatsVC *)[self.storyboard instantiateViewControllerWithIdentifier:@"PlayerStats"];
//    nextVC.SelectedPlayerCode = [[PlayerListArray objectAtIndex:indexPath.section-1] valueForKey:@"PlayerCode"];
//    [self.navigationController pushViewController:nextVC animated:YES];
    
}
-(void)setShadow:(CALayer *)layer
{
    layer.shadowColor = [[UIColor blackColor] CGColor];
    layer.shadowOffset = CGSizeMake(10,3);
    layer.shadowOpacity = 1.0;
    
}
// 10 - 12
//
//

@end
