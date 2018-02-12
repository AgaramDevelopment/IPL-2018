//
//  CalendarViewController.m
//  APT_V2
//
//  Created by user on 08/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "CalendarViewController.h"

@interface CalendarViewController ()
{
    NSDateFormatter* format;
}


@end

@implementation CalendarViewController
@synthesize datePickerStyle,datePickerFormat,datePickerDelegate;

@synthesize datePicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    format = [[NSDateFormatter alloc] init];
    [format setDateFormat:datePickerFormat];
    [datePicker setDatePickerMode:UIDatePickerModeDate];

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

- (IBAction)ActionResignDatePicker:(id)sender {
    if ([sender tag])// Done
    {
        [datePickerDelegate selectedDate:[format stringFromDate:[datePicker date]]];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)dismissView:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
