//
//  InjurySelectionViewController.h
//  APT_V2
//
//  Created by user on 23/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTView.h"

@interface InjurySelectionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *navBarView;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UILabel *lblVertical;
@property (weak, nonatomic) IBOutlet UIImageView *imgFront;
@property (weak, nonatomic) IBOutlet UIView *gridView;
@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UIImageView *imgTemp;
@property (weak, nonatomic) IBOutlet UIButton *img123;
- (IBAction)injurySelectionAction:(UIButton *)sender;

@end
