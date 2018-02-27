//
//  TTView.m
//  APT_V2
//
//  Created by user on 24/02/18.
//  Copyright © 2018 user. All rights reserved.
//

#import "TTView.h"

@implementation TTView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect {
    int xStart = 0, yStart = 0;
    int gridSize = self.frame.size.height;
    int noLines = 20;
    UIBezierPath *topPath = [UIBezierPath bezierPath];
    // draw vertical lines
    for(int xId=1; xId<=noLines; xId++) {
        int x = xStart + xId * gridSize / 3;
        [topPath moveToPoint:CGPointMake(x, yStart)];
        [topPath addLineToPoint:CGPointMake(x, yStart+gridSize)];
    }
    
    // draw horizontal lines
    for(int yId=1; yId<=noLines; yId++) {
        int y = yStart + yId * gridSize / 3;
        [topPath moveToPoint:CGPointMake(xStart, y)];
        [topPath addLineToPoint:CGPointMake(xStart+gridSize, y)];
    }
    
    [[UIColor blackColor] setStroke];
    
    [topPath stroke];
}
@end
