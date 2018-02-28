//
//  StandingVC.m
//  APT_V2
//
//  Created by apple on 27/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "StandingVC.h"
#import "PlayerListCollectionViewCell.h"
#import "Config.h"
#import "CustomNavigation.h"

@interface StandingVC (){
    NSArray* headingKeyArray;
    NSArray* headingButtonNames;
    BOOL isYear;

}

@end

@implementation StandingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];

    self.PoplistTable.delegate = self;
    self.PoplistTable.dataSource = self;
    
    
    headingKeyArray =  @[@"Rank",@"Team",@"Played",@"Won",@"Lost",@"Tied",@"N/R",@"Net RR",@"For",@"Against",@"Pts"];
    
    
    headingButtonNames = @[@"Rank",@"Team",@"Played",@"Won",@"Lost",@"Tied",@"N/R",@"Net RR",@"For",@"Against",@"Pts"];
    
    [self.standingsCollectionView registerNib:[UINib nibWithNibName:@"PlayerListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ContentCellIdentifier"];
    
    
    self.standingsCollectionView.delegate = self;
    self.standingsCollectionView.dataSource = self;

}

-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.headderView addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"Standings";
    objCustomNavigation.btn_back.hidden = YES;
    objCustomNavigation.home_btn.hidden = YES;
    objCustomNavigation.menu_btn.hidden =NO;
    
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    
    [objCustomNavigation.menu_btn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



/* Filter */


#pragma mark - UITableViewDataSource
// number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(isYear==YES)
    {
        return 5;
    }
    else{
        return 0;
    }
    
}
// the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *MyIdentifier = @"cellid";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:MyIdentifier];
    }
    
    if(isYear==YES)
    {
        cell.textLabel.text = indexPath.row == 0 ? @"2017" : indexPath.row == 1 ? @"2016" : indexPath.row == 2 ? @"2015" :  indexPath.row == 3 ? @"2014" :  @"2013";
        
    }else{
        cell.textLabel.text = @"";
    }
    
    
    cell.selectionStyle = UIAccessibilityTraitNone;
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(isYear==YES)
    {
        self.yearlbl.text = indexPath.row == 0 ? @"2017" : indexPath.row == 1 ? @"2016" : indexPath.row == 2 ? @"2015" :  indexPath.row == 3 ? @"2014" :  @"2013";
        
    }
    
    isYear = NO;
    self.PoplistTable.hidden = YES;
    
}

- (IBAction)onClickYearDD:(id)sender
{
    
    if(isYear){
        
        isYear = NO;
        self.PoplistTable.hidden = YES;
        
        
    }else{
        
        isYear = YES;
        
        self.PoplistTable.hidden = NO;
        
        self.tableWidth.constant = 142;
        self.tableXposition.constant = self.filterView.frame.origin.x;
        [self.PoplistTable reloadData];
    }
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
    
    PlayerListCollectionViewCell* cell = [self.standingsCollectionView dequeueReusableCellWithReuseIdentifier:@"ContentCellIdentifier" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        
        cell.backgroundColor = [UIColor colorWithRed:44.0/255.0 green:167.0/255.0 blue:219.0/255.0 alpha:1.0];
        
        
        
        [cell.lblRightShadow setHidden:YES];
        cell.btnName.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        cell.btnName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
        
        for (id value in headingButtonNames) {
            
            if ([headingButtonNames indexOfObject:value] == indexPath.row) {
                [cell.btnName setTitle:value forState:UIControlStateNormal];
                cell.btnName.secondTag = indexPath.row;
                cell.btnName.titleLabel.numberOfLines = 2;
                
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
                if([temp isEqualToString:@"Rank"])
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
                [cell.btnName setTitle:[NSString stringWithFormat:@"T %ld",indexPath.section-1] forState:UIControlStateNormal];
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





@end
