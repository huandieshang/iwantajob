//
//  HomeViewController.m
//  weico
//
//  Created by 高超 on 3/2/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import "HomeViewController.h"
#import "WeiboListViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
{
    WeiboListViewController *_tableVC;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tableVC = [[WeiboListViewController alloc] initWithStyle:UITableViewStylePlain];
    _tableVC.sinaWeibo = self.sinaweibo;
    self.view = _tableVC.view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc {
    [_tableVC release], _tableVC = nil;
    [super dealloc];
}
- (void)viewDidUnload {
    [super viewDidUnload];
}

@end