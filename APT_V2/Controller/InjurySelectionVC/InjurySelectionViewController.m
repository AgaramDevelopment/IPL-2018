//
//  InjurySelectionViewController.m
//  APT_V2
//
//  Created by user on 23/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "InjurySelectionViewController.h"
#import "Header.h"

@interface InjurySelectionViewController ()
{
    CALayer *blueLayer;
    CALayer *redLayer;
    CALayer *yellowLayer;
    CALayer *greenLayer;
}

@end

@implementation InjurySelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customnavigationmethod];
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

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    blueLayer = [[CALayer alloc] init];
    blueLayer.frame = CGRectMake(100, 100, 100, 100);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    blueLayer.name = @"Blue";
//    [self.view.layer addSublayer:blueLayer];
    
//    UIBezierPath* trianglePath = [UIBezierPath bezierPath];
    
//    blueLayer.accessibilityPath.bezierPath;
    redLayer = [[CALayer alloc] init];
    redLayer.frame = CGRectMake(200, 200, 100, 100);
    redLayer.backgroundColor = [UIColor redColor].CGColor;
    redLayer.name=@"Red";
//    [self.view.layer addSublayer:redLayer];
    
    yellowLayer = [[CALayer alloc] init];
    yellowLayer.frame = CGRectMake(300, 300, 100, 100);
    yellowLayer.backgroundColor = [UIColor yellowColor].CGColor;
    yellowLayer.name = @"Yellow";
//    [self.view.layer addSublayer:yellowLayer];
    
    greenLayer = [[CALayer alloc] init];
    greenLayer.frame = CGRectMake(400, 400, 100, 100);
    greenLayer.backgroundColor = [UIColor greenColor].CGColor;
    greenLayer.name=@"Green";
//    [self.view.layer addSublayer:greenLayer];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    
}

//The next step is to use the UIViewController's inheritance from the UIResponder class to take advantage of the touchesEnded: method.
- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
    
//    [super touchesBegan:touches withEvent:event];
//    [self.nextResponder touchesBegan:touches withEvent:event];
    
    CGPoint location = [[touches anyObject] locationInView:self.view];
    CALayer *hitLayer = [self.view.layer hitTest:[self.view convertPoint:location fromView:nil]];
    
    [self displayInfo:hitLayer.name];
}

-(void)displayInfo:(NSString *)nameOfLayer
{
    NSLog(@"%@",nameOfLayer);
}


-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    //    [self.view addSubview:objCustomNavigation.view];
    //    objCustomNavigation.tittle_lbl.text=@"";
    
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
    
    //    objCustomNavigation.btn_back.hidden =isBackEnable;
    //
    //    objCustomNavigation.menu_btn.hidden = objCustomNavigation.btn_back.isHidden;
    //    [objCustomNavigation.btn_back addTarget:self action:@selector(actionBack:) forControlEvents:UIControlEventTouchUpInside];
    //
    //    [objCustomNavigation.menu_btn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)actionBack
{
    [appDel.frontNavigationController popViewControllerAnimated:YES];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"BACK"];
    
}

@end