//
//  PopOverVC.m
//  APT_V2
//
//  Created by MAC on 22/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "PopOverVC.h"
#import "Config.h"
#import "PopOverVCCell.h"
#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface PopOverVC ()

@end

@implementation PopOverVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"listArray:Count:%lu", (unsigned long)self.listArray.count);
    NSLog(@"listArray:%@", self.listArray);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (IS_IPAD ? 50 : 40);
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    PopOverVCCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"PopOverVCCell" owner:self options:nil];
    
    // 1. Dequeue the custom header cell
    headerCell = arr[0];
    NSString *count = [NSString stringWithFormat:@"%ld", self.listArray.count];
    headerCell.notificationCountLbl.text = count;
    // 3. And return
    return headerCell;
}

#pragma mark - UITableView Delegate Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.imageView.image = [UIImage imageNamed:@"bowler_defalut"];
    cell.textLabel.text = [self.listArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = @"29w 6d 19h ago";
    NSLog(@"DD%@", cell.detailTextLabel.text);
    return cell;
    */
    
    PopOverVCCell *cell = [tableView dequeueReusableCellWithIdentifier:@"notificationCell"];
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"PopOverVCCell" owner:self options:nil];
    
    // 1. Dequeue the custom header cell
    cell = arr[1];
        //Images
//    [self.team1ImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [key valueForKey:@"ATLogo"]]] placeholderImage:[UIImage imageNamed:@"no-image"]]; //team_logo_csk
    [cell.notificationImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [self.listArray valueForKey:@"UserPhoto"]]] placeholderImage:[UIImage imageNamed:@"player_andr"]];
    cell.notificationTitleLbl.text = [[self.listArray valueForKey:@"Description"]objectAtIndex:indexPath.row];
    cell.notificationDescrLbl.text = [[self.listArray valueForKey:@"Date"]objectAtIndex:indexPath.row];
    // 3. And return
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_IPAD) {
        return 70;
    } else {
        return 60;
    }
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
