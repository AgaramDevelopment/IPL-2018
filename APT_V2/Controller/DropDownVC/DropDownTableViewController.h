//
//  DropDownTableViewController.h
//  APT_V2
//
//  Created by user on 05/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol selectedDropDown <NSObject>

-(void)selectedValue:(NSMutableArray *)array andKey:(NSString*)key andIndex:(NSIndexPath *)Index;
@end



@interface DropDownTableViewController : UIViewController

@property (strong, nonatomic)id<selectedDropDown> protocol;
@property (weak, nonatomic) IBOutlet UITableView *tblDropDown;

@property (strong,nonatomic)NSMutableArray* array;
@property (strong, nonatomic) NSString* key;
@end
