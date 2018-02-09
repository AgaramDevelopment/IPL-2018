//
//  CalendarViewController.h
//  APT_V2
//
//  Created by user on 08/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DatePickerProtocol <NSObject>

@required
-(void)selectedDate:(NSString *)Date;

@end
@interface CalendarViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *DatePickerView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (strong,readwrite) NSString* datePickerFormat;
@property (strong,readwrite) NSString* datePickerStyle;
@property (strong,nonatomic) id<DatePickerProtocol> datePickerDelegate;

@end
