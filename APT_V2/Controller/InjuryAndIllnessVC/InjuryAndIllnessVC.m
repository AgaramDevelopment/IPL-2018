//
//  InjuryAndIllnessVC.m
//  APT_V2
//
//  Created by MAC on 27/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "InjuryAndIllnessVC.h"
#import "InjuryAndIllnessCell.h"
#import "Config.h"

@interface InjuryAndIllnessVC ()

@end

@implementation InjuryAndIllnessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma Tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.injuryTableView) {
        return injuryArray.count;
    }
    
    if (tableView == self.illnessTableView) {
        return illnessArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InjuryAndIllnessCell *cell;
    
    if (tableView == self.injuryTableView) {
        static NSString *cellIdentifier = @"injuryCell";
        
      cell  = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"InjuryAndIllnessCell" owner:self options:nil];
        cell = arr[0];
        
        if (injuryArray.count) {
            cell.injuryLbl.text = [injuryArray objectAtIndex:indexPath.row];
            cell.injuryDateLbl.text = [injuryArray objectAtIndex:indexPath.row];
            cell.injuryErdLbl.text = [injuryArray objectAtIndex:indexPath.row];
        }
    }
    
    if (tableView == self.illnessTableView) {
        static NSString *cellIdentifier = @"illnessCell";
        
        cell  = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"InjuryAndIllnessCell" owner:self options:nil];
        cell = arr[1];
        
        if (injuryArray.count) {
            cell.illnessLbl.text = [illnessArray objectAtIndex:indexPath.row];
            cell.illnessDateLbl.text = [illnessArray objectAtIndex:indexPath.row];
            cell.illnessErdLbl.text = [illnessArray objectAtIndex:indexPath.row];
        }
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_IPAD) {
        return 45;
    } else {
        return 35;
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
