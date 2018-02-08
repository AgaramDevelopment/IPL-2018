//
//  HorizontalXLblFormatter.h
//  SportsStats
//
//  Created by Mac on 12/01/18.
//  Copyright © 2018 agaram. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Charts;

@interface HorizontalXLblFormatter : NSObject <IChartAxisValueFormatter>

- (id)initForChart:(NSMutableArray *)xValues;

@end
