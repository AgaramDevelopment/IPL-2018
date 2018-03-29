//
//  DateProtocol.h
//  AlphaProTracker
//
//  Created by user on 19/01/18.
//  Copyright © 2018 agaraminfotech. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DateProtocol <NSObject>

@required
- (void)didSelectEventOfCell:(NSDate *)selectedDate;


@end
