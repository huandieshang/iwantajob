//
//  WeiboMapAnnotation.h
//  weico
//
//  Created by 高超 on 3/10/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "WeiboModel.h"

@interface WeiboMapAnnotation : NSObject<MKAnnotation>

@property (nonatomic, retain) WeiboModel *weiboModel;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

- (id)initWithDataByWeiboModel:(WeiboModel *)weiboModel;

@end
