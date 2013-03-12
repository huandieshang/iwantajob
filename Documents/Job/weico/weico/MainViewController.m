//
//  MainViewController.m
//  Weico
//  视图主控制器
//  Created by 高超 on 3/1/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "AppsViewController.h"
#import "ProfileViewController.h"
#import "MoreViewController.h"
#import "BaseNavigationViewController.h"
#import "AppDelegate.h"
#import "SinaWeibo.h"
#import "WeiboModel.h"

@interface MainViewController ()

@end

@implementation MainViewController
{
    SinaWeibo *_sinaweibo;
    UIButton *_navLeftBtn;
    UIButton *_navRightBtn;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //hide tabbar
        self.tabBar.hidden = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self _initViewsController];
    [self _initTabbarView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AppDelegate *)appDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

//初始化tabbarcontroller
- (void)_initViewsController
{
    //resize tabbar 的视图的高度
    for (UIView *subview in self.view.subviews) {
        if ([subview isKindOfClass:(NSClassFromString(@"UITransitionView"))]) {
            subview.frame = CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT-TAB_BAR_HEIGHT);
        }
    }
    
    //create tabbar 子视图
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    MessageViewController *messageVC = [[MessageViewController alloc] init];
    AppsViewController *appsVC = [[AppsViewController alloc] init];
    ProfileViewController *profileVC = [[ProfileViewController alloc] init];
    MoreViewController *moreVC = [[MoreViewController alloc] init];
    
    NSArray *views = @[homeVC, messageVC, appsVC, profileVC, moreVC];
    NSMutableArray *navigationViews = [NSMutableArray arrayWithCapacity:5];
    for (UIViewController *viewVC in views) {
        BaseNavigationViewController *navigationView = [[BaseNavigationViewController alloc] initWithRootViewController:viewVC];
        [navigationViews addObject:navigationView];
        [navigationView release];
    }
    
    //视图控制机集合
    self.viewControllers = navigationViews;
    
    [messageVC release];
    [appsVC release];
    [profileVC release];
    [moreVC release];
}

//初始化tabbar的按钮
- (void)_initTabbarView
{
    //创建tabbar view
    _tabbarView = [[UIView alloc] initWithFrame:CGRectMake(0, IPHONE_HEIGHT-TAB_BAR_HEIGHT-IPHONE_STATUS_BAR, IPHONE_WIDTH, TAB_BAR_HEIGHT)];
    _tabbarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbarBackground"]];
    
    //创建选中效果
    _tabbarSelectedBackground = [[UIView alloc] initWithFrame:CGRectMake(10, (TAB_BAR_HEIGHT-34)/2.0, 40, 32)];
    _tabbarSelectedBackground.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"selected"]];
    [_tabbarView addSubview:_tabbarSelectedBackground];
    
    //创建tabbar 里面的button
    for (int i = 0; i < 5; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoLight];
        button.tag = i;
        button.frame = CGRectMake(16+TAB_BAR_CELL_WIDTH*i, 8, 28, 26);
        [button addTarget:self action:@selector(_tabbarButtonsTouched:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"buttonIcon_%d", i+1]] forState:UIControlStateNormal];
        [_tabbarView addSubview:button];
    }
    [self.view addSubview:_tabbarView];
}

//tabbar buttons touch
- (void)_tabbarButtonsTouched:(UIButton *)button
{
    //处理代理
    if ([_mainVCDelegate respondsToSelector:@selector(mainViewTabbarBottinTouchUpInside:)]) {
        [_mainVCDelegate mainViewTabbarBottinTouchUpInside:button];
    }
    
    self.selectedIndex = button.tag;
    
    //设置浮动效果动画
    [UIView beginAnimations:nil context:nil];
    _tabbarSelectedBackground.frame = CGRectMake(10+button.tag*TAB_BAR_CELL_WIDTH, (TAB_BAR_HEIGHT-34)/2.0, 40, 32);
    [UIView commitAnimations];
}

#pragma mark -sinaWeibo delegate
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    _sinaweibo = [self appDelegate].sinaweibo;
    
    [_sinaweibo requestWithURL:@"statuses/home_timeline.json" params:[NSMutableDictionary dictionaryWithObject:_sinaweibo.userID forKey:@"uid"] httpMethod:@"GET" delegate:self];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    
}

#pragma mark -sinaWeibo request delegate

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"加载失败");
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    NSArray *statuses = [result objectForKey:@"statuses"];
    NSMutableArray *weiboLists = [NSMutableArray arrayWithCapacity:statuses.count];
    for (NSDictionary *weiboList in statuses) {
        WeiboModel *weibo = [[WeiboModel alloc] initWithDataDic:weiboList];
        [weiboLists addObject:weibo];
        [weibo release];
    }
    //[_navLeftBtn setTitle:[result objectForKey:@"name"] forState:UIControlStateNormal];
}

- (void)dealloc
{
    [_tabbarView release];
    [_tabbarSelectedBackground release];
    [_sinaweibo release];
    [_navLeftBtn release];
    [_navRightBtn release];
    [super dealloc];
}

@end












