//
//  InjuryVC.m
//  APT_V2
//
//  Created by Mac on 05/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "InjuryVC.h"
#import "CustomNavigation.h"
#import "SWRevealViewController.h"

@interface InjuryVC ()
{
    BOOL isOccurrence;
    BOOL isLocation;
    BOOL isSite;
    BOOL isType;
    BOOL isCasuse;
}
@property (nonatomic,weak) IBOutlet UITextField * compliant_Txt;
@property (nonatomic,weak) IBOutlet UITextField * comfirmatory_Txt;
@property (nonatomic,weak) IBOutlet UITextField * diagnosis_Txt;
@property (nonatomic,weak) IBOutlet UIButton * delay_Btn;
@property (nonatomic,weak) IBOutlet UIButton * tur_Btn;
@property (nonatomic,weak) IBOutlet UIButton * right_Btn;
@property (nonatomic,weak) IBOutlet UIButton * left_Btn;
@property (nonatomic,weak) IBOutlet UIButton * expectedright_Btn;
@property (nonatomic,weak) IBOutlet UIButton * expectedLeft_Btn;
@property (nonatomic,weak) IBOutlet UILabel * date_lbl;
@property (nonatomic,weak) IBOutlet UIView * navigation_view;
@property (nonatomic,weak) IBOutlet UITableView * pop_Tbl;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint * popviewYposition;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint * popviewXposition;
@property (nonatomic,weak) IBOutlet NSLayoutConstraint * popviewWidth;

@property (nonatomic,weak) IBOutlet UIView * occurrence_view;
@property (nonatomic,weak) IBOutlet UIView * location_view;
@property (nonatomic,weak) IBOutlet UIView * site_view;
@property (nonatomic,weak) IBOutlet UIView * type_view;
@property (nonatomic,weak) IBOutlet UIView * casuse_view;


@end

@implementation InjuryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customnavigationmethod];
    [self setBorderwidthMethod];
}

-(void)customnavigationmethod
{
    CustomNavigation * objCustomNavigation=[[CustomNavigation alloc] initWithNibName:@"CustomNavigation" bundle:nil];
    
    SWRevealViewController *revealController = [self revealViewController];
    [revealController panGestureRecognizer];
    [revealController tapGestureRecognizer];
    
    //    [self.view addSubview:objCustomNavigation.view];
    //    objCustomNavigation.tittle_lbl.text=@"";
    
    //UIView* view= self.navigation_view.subviews.firstObject;
    [self.navigation_view addSubview:objCustomNavigation.view];
    
    objCustomNavigation.btn_back.hidden =YES;
    objCustomNavigation.menu_btn.hidden =NO;
    //        [objCustomNavigation.btn_back addTarget:self action:@selector(didClickBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [objCustomNavigation.menu_btn addTarget:revealController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    //        [objCustomNavigation.home_btn addTarget:self action:@selector(HomeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)setBorderwidthMethod
{
    self.compliant_Txt.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.compliant_Txt.layer.borderWidth = 1.0;
    self.compliant_Txt.layer.masksToBounds = YES;
    
    self.comfirmatory_Txt.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.comfirmatory_Txt.layer.borderWidth = 1.0;
    self.comfirmatory_Txt.layer.masksToBounds = YES;
    
    self.diagnosis_Txt.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.diagnosis_Txt.layer.borderWidth = 1.0;
    self.diagnosis_Txt.layer.masksToBounds = YES;
    
    self.delay_Btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.delay_Btn.layer.borderWidth = 1.0;
    self.delay_Btn.layer.masksToBounds = YES;
    
    self.tur_Btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tur_Btn.layer.borderWidth = 1.0;
    self.tur_Btn.layer.masksToBounds = YES;
    
    self.right_Btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.right_Btn.layer.borderWidth = 1.0;
    self.right_Btn.layer.masksToBounds = YES;
    
    self.left_Btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.left_Btn.layer.borderWidth = 1.0;
    self.left_Btn.layer.masksToBounds = YES;
    
    self.expectedright_Btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.expectedright_Btn.layer.borderWidth = 1.0;
    self.expectedright_Btn.layer.masksToBounds = YES;
    
    self.expectedLeft_Btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.expectedLeft_Btn.layer.borderWidth = 1.0;
    self.expectedLeft_Btn.layer.masksToBounds = YES;
    
    self.date_lbl.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.date_lbl.layer.borderWidth = 1.0;
    self.date_lbl.layer.masksToBounds = YES;
    
    self.pop_Tbl.layer.borderColor = [UIColor brownColor].CGColor;
    self.pop_Tbl.layer.borderWidth = 1.0;
    self.pop_Tbl.layer.masksToBounds = YES;
    
    self.pop_Tbl.layer.cornerRadius = 10;
    self.pop_Tbl.layer.masksToBounds =YES;
    
    self.pop_Tbl.hidden= YES;
}

-(IBAction)didClickOccurrencePopBtn:(id)sender
{
    self.popviewYposition.constant = self.occurrence_view.frame.origin.y-95;
    self.popviewXposition.constant = self.view.frame.size.width - (self.view.frame.size.width/1.25);
    self.popviewWidth.constant = self.occurrence_view.frame.size.width-180;
    if(isOccurrence == NO)
    {
        self.pop_Tbl.hidden = NO;
        isOccurrence = YES;
        [self showAnimate];
        
    }
    else
    {
        self.pop_Tbl.hidden = YES;
        isOccurrence = NO;
        [self removeAnimate];
    }
    
    isCasuse = NO;
    isLocation = NO;
    isSite = NO;
    isType = NO;
}

-(IBAction)didClickLocationPopBtn:(id)sender
{
    self.popviewYposition.constant = self.location_view.frame.origin.y-85;
    self.popviewXposition.constant = self.view.frame.size.width - (self.view.frame.size.width/1.25);
    self.popviewWidth.constant = self.location_view.frame.size.width-180;
    if(isLocation == NO)
    {
        self.pop_Tbl.hidden = NO;
        isLocation = YES;
        [self showAnimate];
    }
    else
    {
        self.pop_Tbl.hidden = YES;
        isLocation = NO;
        [self removeAnimate];
    }
    
    isCasuse = NO;
    isOccurrence = NO;
    isSite = NO;
    isType = NO;
}

-(IBAction)didClicksitePopBtn:(id)sender
{
    self.popviewYposition.constant = self.site_view.frame.origin.y-40;
    self.popviewXposition.constant = self.view.frame.size.width - (self.view.frame.size.width/1.25);
    self.popviewWidth.constant = self.site_view.frame.size.width-180;
    if(isSite == NO)
    {
        self.pop_Tbl.hidden = NO;
        isSite = YES;
        [self showAnimate];
    }
    else
    {
        self.pop_Tbl.hidden = YES;
        isSite = NO;
        [self removeAnimate];
    }
    
    isCasuse = NO;
    isOccurrence = NO;
    isLocation = NO;
    isType = NO;
}
-(IBAction)didClickTypeBtn:(id)sender
{
    self.popviewYposition.constant = self.type_view.frame.origin.y-150;
    self.popviewXposition.constant = 5;
    self.popviewWidth.constant = self.type_view.frame.size.width/2.1;
    
    if(isType == NO)
    {
        self.pop_Tbl.hidden = NO;
        isType = YES;
        [self showAnimate];
    }
    else
    {
        self.pop_Tbl.hidden = YES;
        isType = NO;
        [self removeAnimate];
    }
    
    isCasuse = NO;
    isOccurrence = NO;
    isLocation = NO;
    isSite = NO;
}
-(IBAction)didClickCasuseBtn:(id)sender
{
    self.popviewYposition.constant = self.type_view.frame.origin.y-150;
    self.popviewXposition.constant = self.view.frame.size.width - (self.view.frame.size.width/2.05);
    self.popviewWidth.constant = self.type_view.frame.size.width/2.1;
    if(isCasuse == NO)
    {
        self.pop_Tbl.hidden = NO;
        isCasuse = YES;
        [self showAnimate];
    }
    else
    {
        self.pop_Tbl.hidden = YES;
        isCasuse = NO;
        [self removeAnimate];
    }
    
    isType = NO;
    isOccurrence = NO;
    isLocation = NO;
    isSite = NO;
}


- (void)showAnimate
{
    self.pop_Tbl.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.pop_Tbl.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.pop_Tbl.alpha = 1;
        self.pop_Tbl.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)removeAnimate
{
    [UIView animateWithDuration:.25 animations:^{
        self.pop_Tbl.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.pop_Tbl.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            // [self.popTblView removeFromSuperview];
            self.pop_Tbl.hidden = YES;
        }
    }];
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

@end

