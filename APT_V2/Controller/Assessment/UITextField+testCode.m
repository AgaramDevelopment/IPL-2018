//
//  UITextField+testCode.m
//  APT_V2
//
//  Created by user on 17/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "UITextField+testCode.h"

@implementation UITextField (testCode)
@dynamic strTestCode;

-(void)setStrTestCode:(NSString *)strTestCode
{
    self.strTestCode = strTestCode;
}

-(NSString *)strTestCode
{
    return self.strTestCode;
}
@end
