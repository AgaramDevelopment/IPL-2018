//
//  MyStatsBattingVC.m
//  APT_V2
//
//  Created by MAC on 06/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "MyStatsBattingVC.h"
#import "MyStatsBattingCell.h"
#import "Config.h"

@interface MyStatsBattingVC ()
{
    
    NSInteger selectedIndex;
    NSIndexPath *lastIndex;
}
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *battingTableViewHeight;

@end

@implementation MyStatsBattingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    lastIndex = NULL;
    selectedIndex = -1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UITableViewDataSource
    // number of section(s), now I assume there is only 1 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
    // number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;
}
    // the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellIdentifier = (IS_IPAD)? @"battingCellIpad" : @"battingCell";
    
    //static NSString * cellIdentifier = identifier;
    
    MyStatsBattingCell * Battingcell =(MyStatsBattingCell *) [self.batttingTableView dequeueReusableCellWithIdentifier:cellIdentifier];

    //ScoreCardCellTVCell *cell = (ScoreCardCellTVCell *)[tableView dequeueReusableCellWithIdentifier:batsmanCell];
    if (Battingcell == nil) {
        
        
           [[NSBundle mainBundle] loadNibNamed:@"MyStatsBattingCell" owner:self options:nil];
        
        
        Battingcell = (IS_IPAD)?self.StatsBattingCell: self.StatsBattingCellIphone;
        // self.batsmanCell = nil;
        
        
    }
    
    
   // NSArray *arr= [[NSBundle mainBundle] loadNibNamed:@"MyStatsBattingCell" owner:self options:nil];
    /*
    if (indexPath.row  == 0) {
        cell = arr[0];
        cell = arr[1];
    }

    if (indexPath.row > 0 || indexPath.row <= 3) {
     */
//        if (IS_IPAD) {
//
//            Battingcell = arr[3];
//
//        } else {
//
//            Battingcell = arr[2];
//
////            UIView *scoreVV=(UIView*)[cell.contentView viewWithTag:10];
////            scoreVV.hidden = YES;
////            cell.scoreViewHeight.constant = 0;
////            NSLog(@"scoreViewHeight:%f", cell.scoreViewHeight.constant);
//      }
//    }
    
   
    Battingcell.backgroundColor = [UIColor clearColor];
    
    return Battingcell;
}

#pragma mark - UITableViewDelegate
    // when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    static NSString *cellIdentifier = @"battingCell";
//    MyStatsBattingCell * Battingcell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//
//    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"MyStatsBattingCell" owner:self options:nil];
   // Battingcell = arr[2];
    
    MyStatsBattingCell * cell = [self.batttingTableView cellForRowAtIndexPath:indexPath];

    [self.batttingTableView beginUpdates];

    if(indexPath.row == selectedIndex)
        {
        selectedIndex = -1;
        
            //cell.scoreView.hidden = YES;

        lastIndex = NULL;
        
        } else
            {
            
                //cell.scoreView.hidden = NO;
            if(lastIndex != nil){
                
               
                [self.batttingTableView reloadRowsAtIndexPaths:@[lastIndex] withRowAnimation:UITableViewRowAnimationAutomatic];

                
            }
            
            lastIndex = indexPath;
            selectedIndex = indexPath.row;
                
                
            
            }
    //[self.batttingTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem: indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationAutomatic];

    
    //[self.batttingTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

    [self.batttingTableView endUpdates];

    [self.batttingTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

   
    
    [self.batttingTableView reloadData];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   // if (tableView == self.batttingTableView) {
        if(indexPath.row ==  selectedIndex)
            {
                return 420;
            }
        else
            {
        
                return (IS_IPAD)?80: 60;
            
            }
    //} else return 0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(MyStatsBattingCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //if(tableView== self.batttingTableView  )
       // {
        if (selectedIndex == indexPath.row)
            {
            
            [cell setBackgroundColor:[UIColor lightGrayColor]];
            [cell setAccessibilityTraits:UIAccessibilityTraitSelected];
            CGFloat height = MIN(self.view.bounds.size.height, self.batttingTableView.contentSize.height);
            self.battingTableViewHeight.constant = height;
                cell.scoreView.hidden = NO;
            [self.view layoutIfNeeded];
            
        
            }
        else
            {
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell setAccessibilityTraits:0];
                cell.scoreView.hidden = YES;

            CGFloat height = MIN(self.view.bounds.size.height, self.batttingTableView.contentSize.height);
            self.battingTableViewHeight.constant = height;
            [self.view layoutIfNeeded];
            
            
            }
    
       // }
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
