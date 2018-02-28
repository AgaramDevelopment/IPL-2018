//
//  TeamHeadToHead.m
//  APT_V2
//
//  Created by Apple on 28/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "TeamHeadToHead.h"
#import "CustomNavigation.h"
#import "SWRevealViewController.h"

@interface TeamHeadToHead ()
{
   
    BOOL isteam1;
    BOOL isteam2;
    BOOL isGround;
    
   
}



@property (nonatomic, strong) IBOutlet NSMutableArray *commonArray;

@property (nonatomic, strong)IBOutlet  NSLayoutConstraint *tableWidth;
@property (nonatomic, strong)IBOutlet  NSLayoutConstraint *tableXposition;
@property (nonatomic, strong)IBOutlet  NSLayoutConstraint *tableYposition;

@end

@implementation TeamHeadToHead

- (void)viewDidLoad {
    [super viewDidLoad];
    self.commonArray = [[NSMutableArray alloc]init];
    self.commonArray = @[@"1",@"2",@"3"];
    self.Poptable.hidden = YES;
    [self customnavigationmethod];
}

-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation;
    
    
    objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    [self.headerView addSubview:objCustomNavigation.view];
    objCustomNavigation.tittle_lbl.text=@"Head To Head";
    objCustomNavigation.btn_back.hidden = YES;
    objCustomNavigation.home_btn.hidden = YES;
    objCustomNavigation.menu_btn.hidden =NO;
    
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    
    [objCustomNavigation.menu_btn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (IBAction)GroundBtnAction:(id)sender
{
    isteam1 = NO;
    isteam2 = NO;
    isGround = YES;
    self.Poptable.hidden = NO;
    self.tableWidth.constant = self.groundView.frame.size.width;
    self.tableXposition.constant = self.groundView.frame.origin.x+5;
    self.tableYposition.constant = self.groundView.frame.origin.y;
}

- (IBAction)Team1BtnAction:(id)sender
{
    isteam1 = YES;
    isteam2 = NO;
    isGround = NO;
    
    self.Poptable.hidden = NO;
    
    self.tableWidth.constant = self.team1View.frame.size.width;
    self.tableXposition.constant = self.team1View.frame.origin.x+5;
    self.tableYposition.constant = self.team1View.frame.origin.y;
    
    
    
}

- (IBAction)Team2BtnAction:(id)sender
{
    isteam1 = NO;
    isteam2 = YES;
    isGround = NO;
    self.Poptable.hidden = NO;
    
    self.tableWidth.constant = self.team2View.frame.size.width;
    self.tableXposition.constant = self.team2View.frame.origin.x+5;
    self.tableYposition.constant = self.team2View.frame.origin.y;
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
// number of row in the section, I assume there is only 1 row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.commonArray.count;
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
    
    
        cell.textLabel.text = [self.commonArray objectAtIndex:indexPath.row];
  
    cell.selectionStyle = UIAccessibilityTraitNone;
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(isteam1==YES)
    {
        
            self.team1lbl.text = [self.commonArray objectAtIndex:indexPath.row];
        
         self.Poptable.hidden = YES;
    }
    if(isteam2==YES)
    {
        
        self.team2lbl.text = [self.commonArray objectAtIndex:indexPath.row];
         self.Poptable.hidden = YES;
    }
    if(isGround==YES)
    {
        
        self.groundlbl.text = [self.commonArray objectAtIndex:indexPath.row];
         self.Poptable.hidden = YES;
        
    }
    
    
    
}



@end
