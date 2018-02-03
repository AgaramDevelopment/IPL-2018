//
//  RearViewController.m
//  APT_V2
//
//  Created by user on 03/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "RearViewController.h"
#import "Header.h"

@interface RearViewController ()
{
    NSIndexPath* PreviouslySelectedIndex;
}

@end

@implementation RearViewController
@synthesize arrItems;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    arrItems = @[@"Team",@"Assments",@"Sync",@"Logout"];
//    arrItems = @[@"Home",@"Logout"];

    PreviouslySelectedIndex = [NSIndexPath indexPathForRow:0 inSection:0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma marl - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrItems.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }

    cell.textLabel.text = arrItems[indexPath.row];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath == PreviouslySelectedIndex) {
        return;
    }
    // Grab a handle to the reveal controller, as if you'd do with a navigtion controller via self.navigationController.
    SWRevealViewController *revealController = appDel.viewController;
    UIViewController* newFrontController;

    if (indexPath.row == 0) {
        newFrontController= [self.storyboard instantiateViewControllerWithIdentifier:@"frontViewController"];;
    }
    else if (indexPath.row == arrItems.count -1)
    {
        [self actionLogOut];

    }
    
    if (newFrontController == nil) {
        return;
    }
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newFrontController];
    [navigationController setNavigationBarHidden:YES];
    [revealController pushFrontViewController:navigationController animated:YES];
    PreviouslySelectedIndex = indexPath;

}

-(void)actionLogOut
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:APP_NAME message:@"Are you sure, you want to Logout?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* actionNo = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction* actionYes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        UIViewController* newFrontController= (LoginVC *)[appDel.storyBoard instantiateViewControllerWithIdentifier:@"LoginVC"];;

        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newFrontController];
        [navigationController setNavigationBarHidden:YES];
        [appDel.viewController pushFrontViewController:navigationController animated:YES];

//        if ([appDel.window.rootViewController isKindOfClass: [LoginVC class]]) {
//            [appDel.window popToRootViewControllerAnimated:YES];
//        }else{
//            [self redirectSelectview:@"LoginVC"];
//        }
        
        
    }];
    
    [alert addAction:actionYes];
    [alert addAction:actionNo];
    [appDel.window.rootViewController presentViewController:alert animated:YES completion:nil];
    
}



@end
