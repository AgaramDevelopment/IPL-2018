//
//  UITextField+testCode.h
//  APT_V2
//
//  Created by user on 17/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UITextField (testCode)
@property (readwrite,strong) NSString * strTestCode;

-(void)setStrTestCode:(NSString *)strTestCode;
-(NSString *)strTestCode;

@end
