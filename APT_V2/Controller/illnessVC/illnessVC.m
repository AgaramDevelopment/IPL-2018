//
//  illnessVC.m
//  APT_V2
//
//  Created by MAC on 09/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "illnessVC.h"
#import "Header.h"

@interface illnessVC ()

@end

@implementation illnessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    illnessArray = [NSMutableArray new];
    
    self.illnessTableView.tableFooterView = [UIView new];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self customnavigationmethod];
}

-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    
    UIView* view= self.view.subviews.firstObject;
    [view addSubview:objCustomNavigation.view];
    
    BOOL isBackEnable = [[NSUserDefaults standardUserDefaults] boolForKey:@"BACK"];
    
    if (isBackEnable) {
        objCustomNavigation.menu_btn.hidden =YES;
        objCustomNavigation.btn_back.hidden =NO;
        [objCustomNavigation.btn_back addTarget:self action:@selector(actionBack) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        objCustomNavigation.menu_btn.hidden =NO;
        objCustomNavigation.btn_back.hidden =YES;
        [objCustomNavigation.menu_btn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.navBarView addSubview:objCustomNavigation.view];
//    objCustomNavigation.tittle_lbl.text=@"";

    
}

-(void)actionBack
{
    [appDel.frontNavigationController popViewControllerAnimated:YES];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"BACK"];
    
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
    
    static NSString *cellIdentifier = @"illnessCell";
    
    illnessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"illnessTableViewCell" owner:self options:nil];
    cell = arr[0];
    
    cell.backgroundColor = [UIColor clearColor];
    
//    cell.illnessLbl.text = illnessArray[indexPath.row];
//    cell.dateLbl.text = illnessArray[indexPath.row];
//    cell.erdLbl.text = illnessArray[indexPath.row];
    
    
    return cell;
}

#pragma mark - UITableViewDelegate
    // when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        return 40;
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
