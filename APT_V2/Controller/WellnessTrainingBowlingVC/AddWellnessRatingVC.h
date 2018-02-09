//
//  AddWellnessRatingVC.h
//  APT_V2
//
//  Created by Apple on 07/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RGSColorSlider.h"
@interface AddWellnessRatingVC : UIViewController

@property (strong, nonatomic) IBOutlet  RGSColorSlider *ColorSlider;
- (IBAction)sliderDidChange:(RGSColorSlider *)sender;

@end
