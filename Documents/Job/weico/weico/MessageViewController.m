//
//  MessageViewController.m
//  weico
//
//  Created by 高超 on 3/2/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import "MessageViewController.h"
#import "WeiboListViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController
{
    WeiboListViewController *_tableVC;
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
    _tableVC = [[WeiboListViewController alloc] initWithStyle:UITableViewStylePlain];
    _tableVC.sinaWeibo = self.sinaweibo;
    self.view = _tableVC.view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
