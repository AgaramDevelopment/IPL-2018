//
//  HorizontalXLblFormatter.m
//  SportsStats
//
//  Created by Mac on 12/01/18.
//  Copyright © 2018 agaram. All rights reserved.
//

#import "HorizontalXLblFormatter.h"

@implementation HorizontalXLblFormatter

{
    NSMutableArray *xValues;

}

- (id)initForChart:(NSMutableArray *)xValues
{
    self = [super init];
    if (self)
    {
        self->xValues = xValues;
        
    }
    return self;
}

- (NSString *)stringForValue:(double)value
axis:(ChartAxisBase *)axis
{
    int val = ((int)value) % 10;
    
    if(val == 0){
        int inx =  ((int)value) / 10;
        if(inx < xValues.count){
            //return [NSString stringWithFormat: @"M %@", [@((NSInteger)val) stringValue]];
           return [self->xValues objectAtIndex:inx];
        }else{
            return @"";
        }
        
    }else{
        return @"";

    }
    
    
    
    //return  [[self->xValues valueForKey:@"bowlType"]objectAtIndex:value-1];
    //return [@((NSInteger)value) stringValue];
}

@end

