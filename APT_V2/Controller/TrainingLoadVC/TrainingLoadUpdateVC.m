//
//  TrainingLoadUpdateVC.m
//  APT_V2
//
//  Created by MAC on 05/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "TrainingLoadUpdateVC.h"
#import "TrainingLoadUpdateCell.h"
#import "Config.h"

@interface TrainingLoadUpdateVC ()

@end

@implementation TrainingLoadUpdateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    

    
    sessionArray = [[NSMutableArray alloc] initWithObjects:@"Session 1", @"Session 2", @"Session 3", nil];
    activityArray = [[NSMutableArray alloc] initWithObjects:@"Cardio", @"Strengthening", @"Bowling", nil];
    valueArray = [[NSMutableArray alloc] initWithObjects:@"245", @"124", @"342", nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (IS_IPAD) {
        self.countViewWidth.constant = 100;
        self.countViewHeight.constant = 100;
    } else {
        self.countViewWidth.constant = 70;
        self.countViewHeight.constant = 70;
    }
    self.countview.layer.cornerRadius = self.countViewWidth.constant/2;
    self.countview.layer.borderWidth = 1;
    self.countview.layer.borderColor =[UIColor whiteColor].CGColor;
    self.countview.clipsToBounds = true;

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
    
    return sessionArray.count;
}
    // the cell will be returned to the tableView
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"updateCell";
    
    TrainingLoadUpdateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"TrainingLoadUpdateCell" owner:self options:nil];
    cell = arr[0];
    
    cell.backgroundColor = [UIColor clearColor];
    
    cell.sessionLbl.text = sessionArray[indexPath.row];
    cell.activityTypeLbl.text = activityArray[indexPath.row];
    cell.sessionValueLbl.text = valueArray[indexPath.row];
    
    
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
