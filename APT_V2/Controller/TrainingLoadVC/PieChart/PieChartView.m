//
//  PieChartView.m
//  PieChartViewDemo
//
//  Created by Strokin Alexey on 8/27/13.
//  Copyright (c) 2013 Strokin Alexey. All rights reserved.
//

#import "PieChartView.h"
#import <QuartzCore/QuartzCore.h>

@implementation PieChartView

@synthesize delegate;
@synthesize datasource;

-(id)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
   if (self != nil)
   {
      //initialization
      self.backgroundColor = [UIColor clearColor];
     // self.layer.shadowColor = [[UIColor blackColor] CGColor];
      //self.layer.shadowOffset = CGSizeMake(0.0f, 2.5f);
      //self.layer.shadowRadius = 1.9f;
      //self.layer.shadowOpacity = 0.9f;
      self.obj =[[UILabel alloc]init];
   }
   return self;
}

-(void)reloadData
{
   [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{

//prepare
   CGContextRef context = UIGraphicsGetCurrentContext();
   CGFloat theHalf = rect.size.width/2;
   CGFloat lineWidth = theHalf;
   if ([self.delegate respondsToSelector:@selector(centerCircleRadius)])
   {
      lineWidth -= [self.delegate centerCircleRadius];
      NSAssert(lineWidth <= theHalf, @"wrong circle radius");
   }
   CGFloat radius = theHalf-lineWidth/2;
   
   CGFloat centerX = theHalf;
   CGFloat centerY = rect.size.height/2;
   
//drawing
   
   double sum = 0.0f;
   int slicesCount = [self.datasource numberOfSlicesInPieChartView:self];
   
   for (int i = 0; i < slicesCount; i++)
   {
      sum += [self.datasource pieChartView:self valueForSliceAtIndex:i];
   }
   
   float startAngle = - M_PI_2;
   float endAngle = 0.0f;
   
    if(self.obj != nil)
    {
        [self.obj removeFromSuperview];
    }
    self.obj.frame = CGRectMake(centerX-15, centerY-20, 50, 50);       //]initWithFrame:CGRectMake(centerX, centerY, 50, 50)];
    self.obj.textColor =[UIColor whiteColor];
    [self addSubview:self.obj];
    
   for (int i = 0; i < slicesCount; i++)
   {
      double value = [self.datasource pieChartView:self valueForSliceAtIndex:i];

      endAngle = startAngle + M_PI*2*value/sum;
      CGContextAddArc(context, centerX, centerY, radius, startAngle, endAngle, false);
   
      UIColor  *drawColor = [self.datasource pieChartView:self colorForSliceAtIndex:i];
   
      CGContextSetStrokeColorWithColor(context, drawColor.CGColor);
   	CGContextSetLineWidth(context, lineWidth);
   	CGContextStrokePath(context);
      startAngle += M_PI*2*value/sum;
   }
    
    if([[self.datasource percentagevalue] isEqualToString:@""])
    {
        NSString * percentage =[self.datasource percentagevalue];
        self.obj.text =[percentage stringByAppendingString:@""];
    }
    else
    {
        NSString * percentage =[self.datasource percentagevalue];
        float ss=[[NSDecimalNumber decimalNumberWithString:percentage]floatValue] ;
        
        if(ss==100)
        {
            
            NSString *s = [NSString stringWithFormat:@"%.f",ss];
            self.obj.text =[s stringByAppendingString:@"%"];
        }
        else
        {
        NSString *s = [NSString stringWithFormat:@"%.01f",ss];
        self.obj.text =[s stringByAppendingString:@"%"];
        }
    }
    
    
}

@end
