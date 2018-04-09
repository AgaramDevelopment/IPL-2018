//
//  LineTextField.h
//  AUIAutoGrowingTextView
//
//  Created by user on 03/02/18.
//  Copyright © 2018 adamsiton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineTextField : UITextField


@property (nonatomic,strong) NSString* selectedCode;
@property (nonatomic,weak) UIButton* button;
-(NSString *)getText;

-(void)setup;

@end
