//
//  MoreViewController.h
//  weico
//
//  Created by 高超 on 3/2/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import "BaseViewController.h"
#import <MapKit/MapKit.h>

@interface MoreViewController : BaseViewController<MKMapViewDelegate, SinaWeiboRequestDelegate>
@property (retain, nonatomic) IBOutlet MKMapView *mapView;

@end
