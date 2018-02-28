//
//  InjurySelectionViewController.h
//  APT_V2
//
//  Created by user on 23/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@interface InjurySelectionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *navBarView;
- (IBAction)injurySelectionAction:(CustomButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *FrontView;
@property (strong, nonatomic) IBOutlet UIView *BackView;

- (IBAction)actionFlipSelection:(id)sender;

@end
