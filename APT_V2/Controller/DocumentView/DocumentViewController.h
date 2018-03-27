//
//  DocumentViewController.h
//  APT_V2
//
//  Created by user on 23/03/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DocumentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *docView;
@property (weak, nonatomic) IBOutlet UICollectionView *docCollectionView;
@property (weak, nonatomic) IBOutlet UITableView *tblDropDown;
@property (weak, nonatomic) IBOutlet UIView *teamView;
@property (weak, nonatomic) IBOutlet UIView *venueView;
@property (weak, nonatomic) IBOutlet UILabel *lblTeam;
@property (weak, nonatomic) IBOutlet UILabel *lblVenue;
@property (weak, nonatomic) IBOutlet UIView *tableMainView;
@property (weak, nonatomic) IBOutlet UILabel *lblNoDoc;

@property (strong, nonatomic) IBOutlet UIViewController *pdfView;
@property (weak, nonatomic) IBOutlet UIWebView *docWebview;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;



@end