//
//  MoreViewController.m
//  weico
//
//  Created by 高超 on 3/2/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import "MoreViewController.h"
#import "WeiboAnnotationView.h"
#import "WeiboMapAnnotation.h"
#import "SinaWeibo.h"
#import "WeiboModel.h"

@interface MoreViewController ()

@end

@implementation MoreViewController
{
    SinaWeibo *_sinaWeibo;
    NSMutableArray *_dataSource;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    self.mapView.mapType = MKMapTypeStandard;
    
    //坐标
    CLLocationCoordinate2D coord = {23.130321, 113.378174};
    MKCoordinateSpan span = {0.06,0.06};
    
    MKCoordinateRegion region = {coord, span};
    [self.mapView setRegion:region];
    
    
    //获取新浪微博附近的接口
    _sinaWeibo = self.sinaweibo;
    [_sinaWeibo requestWithURL:@"place/nearby_timeline.json" params:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"23.130321", @"lat", @"113.378174", @"long", nil] httpMethod:@"GET" delegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_mapView release];
    [_sinaWeibo release], _sinaWeibo = nil;
    [super dealloc];
}
- (void)viewDidUnload {
    [self setMapView:nil];
    [super viewDidUnload];
}

#pragma mark mkMap delegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    static NSString *identify = @"cell";
    WeiboAnnotationView *annotationView = (WeiboAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identify];
    if (annotationView == nil) {
        annotationView = [[[WeiboAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identify] autorelease];
    }
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    for (WeiboAnnotationView *annotantionView in views) {
        CGAffineTransform transform = annotantionView.transform;
        
        annotantionView.transform = CGAffineTransformScale(transform, 0.7, 0.7);
        annotantionView.alpha = 0;
        
        [UIView animateWithDuration:0.3 animations:^{
            annotantionView.transform = CGAffineTransformScale(transform, 1.2, 1.2);
            annotantionView.alpha = 1;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                annotantionView.transform = CGAffineTransformIdentity;
            }];
        }];
    }
}

#pragma mark sinaWeibo request delegate
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"连接出错");
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    NSArray *statuses = [result objectForKey:@"statuses"];
        
    for (int i = 0; i<statuses.count; i++) {
        NSDictionary *statusesDic = [statuses objectAtIndex:i];
        WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:statusesDic];
        WeiboMapAnnotation *annotation = [[WeiboMapAnnotation alloc] initWithDataByWeiboModel:weibo];
        [self.mapView performSelector:@selector(addAnnotation:) withObject:annotation afterDelay:i*0.05];
        [weibo release];
        [annotation release];
    }
}

@end
