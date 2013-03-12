//
//  BaseViewController.m
//  Weico
//
//  Created by 高超 on 3/1/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"
@interface BaseViewController ()

@end

@implementation BaseViewController
{
    AppDelegate *_delegate;
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
    _delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (SinaWeibo *)sinaweibo
{
    
    return _delegate.sinaweibo;
}
//
//- (UIButton *)globalNavigationLeftBtn
//{
//    return _delegate.navLeftBtn;
//}
//
//- (UIButton *)globalNavigationRightBtn
//{
//    return _delegate.navRightBtn;
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
