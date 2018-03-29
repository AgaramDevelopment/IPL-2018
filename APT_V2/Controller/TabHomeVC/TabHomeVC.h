//
//  TabHomeVC.h
//  APT_V2
//
//  Created by Apple on 06/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"
#import "VideoDocumentVC.h"
#import "SchResStandVC.h"

@interface TabHomeVC : UIViewController <openUploadDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *Titlecollview;
@property (strong, nonatomic) IBOutlet UIView *navi_View;

@property (strong, nonatomic) IBOutlet SwipeView *swipeView;

@property (strong, nonatomic) IBOutlet UIView *viewUpload;

@property (strong, nonatomic) IBOutlet UIView *datePickerView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *lblTeam;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayer;
@property (weak, nonatomic) IBOutlet UILabel *lblCategory;
@property (weak, nonatomic) IBOutlet UILabel *lblShareUser;
@property (weak, nonatomic) IBOutlet UITextField *txtVideoDate;
@property (weak, nonatomic) IBOutlet UITextField *txtKeyword;


- (IBAction)actionDatePicker:(id)sender;
- (IBAction)actionCameraGallery:(id)sender;
- (IBAction)actionUpload:(id)sender;
- (IBAction)actionDropDown:(id)sender;
- (IBAction)actionCloseUpload:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblList;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;

- (IBAction)actionDatePickerChange:(id)sender;

@end
