//
//  WeiboMapAnnotation.m
//  weico
//
//  Created by 高超 on 3/10/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import "WeiboMapAnnotation.h"
#import "WeiboModel.h"

@implementation WeiboMapAnnotation

- (id)initWithDataByWeiboModel:(WeiboModel *)weiboModel
{
    self = [super init];
    if (self != nil) {
        self.weiboModel = weiboModel;
        NSDictionary *geo = weiboModel.geo;
        if ([geo isKindOfClass:[NSDictionary class]]) {
            NSArray *coordinates = [geo objectForKey:@"coordinates"];
            float lat = [coordinates[0] floatValue];
            float lon = [coordinates[1] floatValue];
            CLLocationCoordinate2D _coor = {lat, lon};
            _coordinate = _coor;
            self.title = weiboModel.user.name;
            self.subtitle = weiboModel.text;
            [coordinates release];
        }
    }
    return self;
}

@end
