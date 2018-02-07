//
//  WellnessTrainingBowlingVC.m
//  APT_V2
//
//  Created by Apple on 07/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "WellnessTrainingBowlingVC.h"
#import "AddWellnessRatingVC.h"

@interface WellnessTrainingBowlingVC ()
{
    AddWellnessRatingVC * objWell;
}
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topviewHeight;

@end

@implementation WellnessTrainingBowlingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)AddBtnAction:(id)sender {
    
    objWell = [[AddWellnessRatingVC alloc] initWithNibName:@"AddWellnessRatingVC" bundle:nil];
    objWell.view.frame = CGRectMake(0,0, self.topView.bounds.size.width, self.topView.bounds.size.height);
    [self.topView addSubview:objWell.view];
    
    self.topviewHeight.constant = 578;
    
}


@end
