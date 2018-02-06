//
//  HomeScreenStandingsVC.m
//  APT_V2
//
//  Created by MAC on 05/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "HomeScreenStandingsVC.h"
#import "HomeScreenStandingsCell.h"

@interface HomeScreenStandingsVC ()

@end

@implementation HomeScreenStandingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //Applying overall shadow to shadowView
    self.shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.shadowView.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    self.shadowView.layer.shadowOpacity = 1.0;
    self.shadowView.layer.shadowRadius = 6.0;

    
    rankArray = [[NSMutableArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", nil];
    teamArray = [[NSMutableArray alloc] initWithObjects:@"CKS", @"RR", @"MI", @"KXIP", @"SRH", @"DD", @"KKR", @"RCB", nil];
    playedArray = [[NSMutableArray alloc] initWithObjects:@"14", @"14", @"14", @"14", @"14", @"14", @"14", @"14", nil];
    wonArray = [[NSMutableArray alloc] initWithObjects:@"4", @"4", @"4", @"4", @"4", @"4", @"4", @"4", nil];
    lostArray = [[NSMutableArray alloc] initWithObjects:@"3", @"3", @"3", @"3", @"3", @"3", @"3", @"3", nil];
    nrrArray = [[NSMutableArray alloc] initWithObjects:@"+4.33", @"+4.33", @"+4.33", @"+4.33",@"+4.33", @"+4.33", @"+4.33", @"+4.33", nil];
    pointsArray = [[NSMutableArray alloc] initWithObjects:@"12", @"12", @"12", @"12", @"12", @"12", @"12", @"12", nil];
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

    return rankArray.count;
}
    // the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"standingsCell";
    
    HomeScreenStandingsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"HomeScreenStandingsCell" owner:self options:nil];
    cell = arr[0];
    cell.backgroundColor = [UIColor clearColor];
//    cell.textLabel.textColor = [UIColor blackColor];
    
    cell.rankLbl.text = rankArray[indexPath.row];
    cell.teamLbl.text = teamArray[indexPath.row];
    cell.playedLbl.text = playedArray[indexPath.row];
    cell.wonLbl.text = wonArray[indexPath.row];
    cell.lostLbl.text = lostArray[indexPath.row];
    cell.nrrLbl.text = nrrArray[indexPath.row];
    cell.pointsLbl.text = pointsArray[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
    // when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
