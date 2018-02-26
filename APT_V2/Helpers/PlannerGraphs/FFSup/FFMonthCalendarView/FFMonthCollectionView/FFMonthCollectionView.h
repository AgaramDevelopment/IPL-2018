//
//  FFMonthCollectionView.h
//  FFCalendar
//
//  Created by Fernanda G. Geraissate on 2/15/14.
//  Copyright (c) 2014 Fernanda G. Geraissate. All rights reserved.
//
//  http://fernandasportfolio.tumblr.com
//

#import <UIKit/UIKit.h>
#import "DateProtocol.h"

@protocol FFMonthCollectionViewProtocol <NSObject>
@required
- (void)setNewDictionary:(NSDictionary *)dict;
@end

@protocol CollectionCellProtocol <NSObject>
@required
- (void)getDate:(NSDate *)date;
@end


@interface FFMonthCollectionView : UICollectionView

@property (nonatomic, strong) id<FFMonthCollectionViewProtocol>protocol;
@property (nonatomic, strong) NSMutableDictionary *dictEvents;
@property (nonatomic, strong) id<CollectionCellProtocol> cellProtocol;

@end
