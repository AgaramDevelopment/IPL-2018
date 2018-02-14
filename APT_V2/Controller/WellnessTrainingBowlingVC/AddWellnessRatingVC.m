//
//  AddWellnessRatingVC.m
//  APT_V2
//
//  Created by Apple on 07/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "AddWellnessRatingVC.h"
#import "AppCommon.h"
#import "WebService.h"
#import "Config.h"
#import "WellnessTrainingBowlingVC.h"


@interface AddWellnessRatingVC ()
{
    WebService *objWebservice;
    WellnessTrainingBowlingVC *objWell;
float num1;
float num2;
float num3;
float num4;

NSString *metaSubCode1;
NSString *metaSubCode2;
NSString *metaSubCode3;
NSString *metaSubCode4;
    
    UIDatePicker *datePicker;
}

@property (strong, nonatomic) IBOutlet UISlider *sleepSlider;
@property (strong, nonatomic) IBOutlet UISlider *fatiqueSlider;
@property (strong, nonatomic) IBOutlet UISlider *muscleSlider;
@property (strong, nonatomic) IBOutlet UISlider *stressSlider;

@property (strong, nonatomic)  NSMutableArray *sleeplist;
@property (strong, nonatomic)  NSMutableArray *fatiqlist;
@property (strong, nonatomic)  NSMutableArray *sorelist;
@property (strong, nonatomic)  NSMutableArray *stresslist;

@property (strong, nonatomic)  NSMutableArray *sleeplist1;
@property (strong, nonatomic)  NSMutableArray *fatiqlist1;
@property (strong, nonatomic)  NSMutableArray *sorelist1;
@property (strong, nonatomic)  NSMutableArray *stresslist1;


@end

@implementation AddWellnessRatingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    objWebservice = [[WebService alloc] init];
    [self.view_datepicker setHidden:YES];
    
 
    _ColorSlider1.colorTrackImageView.image = [UIImage imageNamed:@"SliderBackground"];
    _ColorSlider2.colorTrackImageView.image = [UIImage imageNamed:@"SliderBackground"];
    _ColorSlider3.colorTrackImageView.image = [UIImage imageNamed:@"SliderBackground"];
    _ColorSlider4.colorTrackImageView.image = [UIImage imageNamed:@"SliderBackground"];
    
    [self metacodeWebservice];
}

-(IBAction)sliderDidChange:(RGSColorSlider *)sender{
    //self.colorView.backgroundColor = sender.color;
    
    sender.showPreview = NO;
    
}

- (CGRect)trackRectForBounds:(CGRect)bounds {
    CGRect rect = CGRectMake(0, 0, 100, 30);//change it to any size you want
    return rect;
}

- (IBAction)DateBtnAction:(id)sender {
    
    [self DisplaydatePicker];
    
}


-(void)DisplaydatePicker
{
    if(datePicker!= nil)
    {
        [datePicker removeFromSuperview];
        
    }
    self.view_datepicker.hidden=NO;
    //isStartDate =YES;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    //   2016-06-25 12:00:00
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    
    datePicker =[[UIDatePicker alloc]initWithFrame:CGRectMake(0,self.view_datepicker.frame.origin.y-180,self.view.frame.size.width,100)];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [datePicker setLocale:locale];
    
    // [datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    [datePicker reloadInputViews];
    [self.view_datepicker addSubview:datePicker];
    
}
-(IBAction)showSelecteddate:(id)sender{
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *matchdate = [NSDate date];
    [dateFormat setDateFormat:@"MM-dd-yyyy"];
    
    
    
    //self.datelbl.text=[dateFormat stringFromDate:datePicker.date];
    
   
    
    NSString * actualDate = [dateFormat stringFromDate:datePicker.date];
    

    self.datelbl.text = actualDate;
    
    //NSLog(@"%@", actualDate);
    
    [self.view_datepicker setHidden:YES];
   // [self dateWebservice];
    
}


-(void)SaveWebservice
{
    [AppCommon showLoading ];
    
    NSString *ClientCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    NSString *UserrefCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
    NSString *playerCode = [[NSUserDefaults standardUserDefaults]stringForKey:@"Userreferencecode"];
    NSString *usercode = [[NSUserDefaults standardUserDefaults]stringForKey:@"UserCode"];
    
    [objWebservice submit  :recordInsert :ClientCode :usercode:self.datelbl.text:playerCode:metaSubCode1:metaSubCode2:metaSubCode3:metaSubCode4 :self.bodyWeightTxt.text : self.sleepHrTxt.text : self.fatTxt.text : self.restingHrTxt.text : self.restingBpMaxTxt.text :self.restingBpMinTxt.text success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        if(responseObject >0)
        {
            BOOL Status = [responseObject valueForKey:@"Status"];
            if(Status == YES)
            {
                NSLog(@"success");
                [self ShowAlterMsg:@"Wellness Rating Inserted Successfully"];
                [self.view removeFromSuperview];
                objWell = [[WellnessTrainingBowlingVC alloc] init];
                [objWell setHeight];
                
                // [self.pieChartRight reloadData];
            }
            
        }
        
        [AppCommon hideLoading];
        
        
        
    }
        failure:^(AFHTTPRequestOperation *operation, id error) {
        NSLog(@"failed");
        [COMMON webServiceFailureError:error];
        }];
    
}


-(void)metacodeWebservice
{
    
    [AppCommon showLoading];
    NSString *cliendcode = [[NSUserDefaults standardUserDefaults]stringForKey:@"ClientCode"];
    
    NSString *Rc=@"RC14";
    
    
    
    [objWebservice getmetacodelist :metasubKey :cliendcode :Rc success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"responseObject=%@",responseObject);
        if(responseObject >0)
        {
            self.sleeplist = [[NSMutableArray alloc]init];
            self.fatiqlist = [[NSMutableArray alloc]init];
            self.sorelist = [[NSMutableArray alloc]init];
            self.stresslist = [[NSMutableArray alloc]init];
            
            
            self.sleeplist = [responseObject valueForKey:@"Sleeps"];
            self.fatiqlist = [responseObject valueForKey:@"Fatigues"];
            self.sorelist = [responseObject valueForKey:@"MuscleSoreNesses"];
            self.stresslist = [responseObject valueForKey:@"Stresses"];
            
            self.sleeplist1 = ([[self.sleeplist valueForKey:@"MetaSubCode"] isEqual:[NSNull null]])?@"":[self.sleeplist valueForKey:@"MetaSubCode"];
            
            self.fatiqlist1 = ([[self.fatiqlist valueForKey:@"MetaSubCode"] isEqual:[NSNull null]])?@"":[self.fatiqlist valueForKey:@"MetaSubCode"];
            
            self.sorelist1 = ([[self.sorelist valueForKey:@"MetaSubCode"] isEqual:[NSNull null]])?@"":[self.sorelist valueForKey:@"MetaSubCode"];
            
            self.stresslist1 = ([[self.stresslist valueForKey:@"MetaSubCode"] isEqual:[NSNull null]])?@"":[self.stresslist valueForKey:@"MetaSubCode"];
            
            
        }
        [AppCommon hideLoading];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, id error) {
        NSLog(@"failed");
        [AppCommon hideLoading];
        [COMMON webServiceFailureError:error];
    }];
   
}
-(void)ShowAlterMsg:(NSString*) MsgStr
{
    UIAlertView *objAlter =[[UIAlertView alloc]initWithTitle:@"" message:MsgStr delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [objAlter show];
    
}

- (IBAction)submitAction:(id)sender {
    
   
     if([self.datelbl.text isEqualToString:@""])
    {
        [self ShowAlterMsg:@"Please Select Date"];
    }
    else if(self.sleepSlider.value ==0)
    {
        [self ShowAlterMsg:@"Please Select Sleep"];
    }
    else if(self.fatiqueSlider.value ==0)
    {
        [self ShowAlterMsg:@"Please Select Fatique"];
    }
    else if(self.muscleSlider.value ==0)
    {
        [self ShowAlterMsg:@"Please Select MuscleSoreness"];
    }
    else if(self.stressSlider.value ==0)
    {
        [self ShowAlterMsg:@"Please Select Stress"];
    }
    else
    {
        [self SaveWebservice];
        
        self.sleepSlider.value =0;
        self.fatiqueSlider.value =0;
        self.muscleSlider.value =0;
        self.stressSlider.value =0;
        
        [self SleepSliderAction:0];
        [self FatiqueSliderAction:0];
        [self MuscleSliderAction:0];
        [self StressSliderAction:0];
        
        self.datelbl.text = @"";
        
    }
    
}

- (IBAction)SleepSliderAction:(id)sender {
    
    NSLog(@"%.f",self.sleepSlider.value);
    // value1 = [NSString stringWithFormat:@"%.f",self.sleepSlider.value];
    
    num1 = [self.sleepSlider value];
    
    NSLog(@"%f",num1);
    
    if(num1 ==0)
    {
        
    }
    
    if(num1 >0.1 && num1 <=1 )
    {
        
        metaSubCode1 = [self.sleeplist1 objectAtIndex:0];
        
        
    }
    if(num1 >1.1 && num1 <= 2)
    {
        
        metaSubCode1 = [self.sleeplist1 objectAtIndex:1];
        
    }
    
    if(num1 >2.1 && num1 <= 3)
    {
        
        
        metaSubCode1 = [self.sleeplist1 objectAtIndex:2];
        
    }
    
    if(num1 > 3.1 && num1 <= 4 )
    {
        
        
        metaSubCode1 = [self.sleeplist1 objectAtIndex:3];
        
    }
    
    if(num1 >4.1 && num1 <= 5 )
    {
        
        metaSubCode1 = [self.sleeplist1 objectAtIndex:4];
        
    }
    if(num1 >5.1 && num1 <= 6)
    {
        
        metaSubCode1 = [self.sleeplist1 objectAtIndex:5];
        
    }
    if(num1 >6.1 && num1 <= 7)
    {
        
        metaSubCode1 = [self.sleeplist1 objectAtIndex:6];
        
    }
    
    
    
    self.SleepRatinglbl.text = [NSString stringWithFormat:@"%d/7",(int)self.sleepSlider.value];
    
}

- (IBAction)FatiqueSliderAction:(id)sender {
    
    
    num2 = [self.fatiqueSlider value];
    
    
    NSLog(@"%f",num2);
    
    if(num2 ==0)
    {
        
    }
    
    if(num2 >0.1 && num2 <=1 )
    {
        
        metaSubCode2 = [self.fatiqlist1 objectAtIndex:0];
        
        
    }
    if(num2 >1.1 && num2 <= 2)
    {
        
        metaSubCode2 = [self.fatiqlist1 objectAtIndex:1];
        
    }
    
    if(num2 >2.1 && num2 <= 3)
    {
        metaSubCode2 = [self.fatiqlist1 objectAtIndex:2];
        
    }
    
    if(num2 > 3.1 && num2 <= 4 )
    {
        
        
        metaSubCode2 = [self.fatiqlist1 objectAtIndex:3];
        
    }
    
    if(num2 >4.1 && num2 <= 5 )
    {
        
        metaSubCode2 = [self.fatiqlist1 objectAtIndex:4];
        
    }
    if(num2 >5.1 && num2 <= 6)
    {
        
        metaSubCode2 = [self.fatiqlist1 objectAtIndex:5];
        
    }
    if(num2 >6.1 && num2 <= 7)
    {
        
        metaSubCode2 = [self.fatiqlist1 objectAtIndex:6];
        
    }
    
    self.FatiqueRatinglbl.text = [NSString stringWithFormat:@"%d/7",(int)self.fatiqueSlider.value];
    
    
    
}

- (IBAction)MuscleSliderAction:(id)sender {
    
    
    num3 = [self.muscleSlider value];
    NSLog(@"%f",num2);
    
    if(num3 ==0)
    {
        
    }
    
    if(num3 >0.1 && num3 <=1 )
    {
        
        metaSubCode3 = [self.sorelist1 objectAtIndex:0];
        
    }
    if(num3 >1.1 && num3 <= 2)
    {
        
        metaSubCode3 = [self.sorelist1 objectAtIndex:1];
        
    }
    
    if(num3 >2.1 && num3 <= 3)
    {
        
        metaSubCode3 = [self.sorelist1 objectAtIndex:2];
        
    }
    
    if(num3 > 3.1 && num3 <= 4 )
    {
        
        
        metaSubCode3 = [self.sorelist1 objectAtIndex:3];
        
    }
    
    if(num3 >4.1 && num3 <= 5 )
    {
        
        metaSubCode3 = [self.sorelist1 objectAtIndex:4];
        
    }
    if(num3 >5.1 && num3 <= 6)
    {
        
        metaSubCode3 = [self.sorelist1 objectAtIndex:5];
        
    }
    if(num3 >6.1 && num3 <= 7)
    {
        
        metaSubCode3 = [self.sorelist1 objectAtIndex:6];
        
    }
    
    
    self.MuscleRatinglbl.text = [NSString stringWithFormat:@"%d/7",(int)self.muscleSlider.value];
    
}

- (IBAction)StressSliderAction:(id)sender {
    
    num4 = [self.stressSlider value];
    NSLog(@"%f",num4);
    
    if(num4 ==0)
    {
        
    }
    
    if(num4 >0.1 && num4 <=1 )
    {
        
        
        metaSubCode4 = [self.stresslist1 objectAtIndex:0];
        
        
        
        
    }
    if(num4 >1.1 && num4 <= 2)
    {
        
        
        metaSubCode4 = [self.stresslist1 objectAtIndex:1];
        
    }
    
    if(num4 >2.1 && num4 <= 3)
    {
        
        
        metaSubCode4 = [self.stresslist1 objectAtIndex:2];
        
    }
    
    if(num4 > 3.1 && num4 <= 4 )
    {
        
        metaSubCode4 = [self.stresslist1 objectAtIndex:3];
        
    }
    
    if(num4 >4.1 && num4 <= 5 )
    {
        
        metaSubCode4 = [self.stresslist1 objectAtIndex:4];
        
    }
    if(num4 >5.1 && num4 <= 6)
    {
        
        metaSubCode4 = [self.stresslist1 objectAtIndex:5];
        
    }
    if(num4 >6.1 && num4 <= 7)
    {
        
        metaSubCode4 = [self.stresslist1 objectAtIndex:6];
        
    }
     self.StressRatinglbl.text = [NSString stringWithFormat:@"%d/7",(int)self.stressSlider.value];
    
}


@end
