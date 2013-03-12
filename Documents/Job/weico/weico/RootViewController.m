//
//  RootViewController.m
//  weico
//
//  Created by 高超 on 3/2/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import "RootViewController.h"
#import "MainViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "AppDelegate.h"
#import "SinaWeibo.h"

@interface RootViewController ()

@end

static NSString *showDropView = @"main";

@implementation RootViewController
{
    SinaWeibo *_sinaWeibo;
    UIImageView *_rightImageBtn;
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
}

- (void)viewWillAppear:(BOOL)animated
{
    MainViewController *mainVC = (MainViewController *)self.rootViewController;
    mainVC.mainVCDelegate = self;
    //[mainVC release];
    self.delegate = self;
    [self _initLeftNavigationBtn];
    [self _initRightNavigationBtn];
    
    //获取微博用户名信息
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    _sinaWeibo = [appDelegate.sinaweibo retain];
    [_sinaWeibo requestWithURL:@"users/show.json" params:[NSMutableDictionary dictionaryWithObject:_sinaWeibo.userID forKey:@"uid"] httpMethod:@"GET" delegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//自定义navigationbar左边边按钮
- (void)_initLeftNavigationBtn
{
    if (_navLeftBtn != nil) {
        return;
    }
    _navLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _navLeftBtn.tag = 1;
    _navLeftBtn.backgroundColor = [UIColor colorWithRed:(202/255.0) green:(205/255.0) blue:(210/255.0) alpha:.7];
    _navLeftBtn.layer.borderWidth = 1.0f;
    _navLeftBtn.layer.borderColor = [UIColor colorWithRed:184/255.0f green:185/255.0f blue:189/255.0f alpha:1].CGColor;
    _navLeftBtn.layer.cornerRadius = 2.0f;
    
    _navLeftBtn.layer.shadowOffset = CGSizeMake(0, -1);
    _navLeftBtn.layer.shadowColor = [[UIColor blackColor] CGColor];
    _navLeftBtn.layer.shadowOpacity = .5;
    
    _navLeftBtn.frame = CGRectMake(4, 4, 198, 36);
    [_navLeftBtn addTarget:self action:@selector(navigationBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navLeftBtn];
}

//自定义navigationbar右边按钮
- (void)_initRightNavigationBtn
{
    if (_navRightBtn != nil) {
        return;
    }
    _navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _navRightBtn.tag = 2;
    _navRightBtn.backgroundColor = [UIColor colorWithRed:(202/255.0) green:(205/255.0) blue:(210/255.0) alpha:.7];
    _navRightBtn.layer.borderWidth = 1.0f;
    _navRightBtn.layer.borderColor = [UIColor colorWithRed:184/255.0f green:185/255.0f blue:189/255.0f alpha:1].CGColor;
    _navRightBtn.layer.cornerRadius = 2.0f;
    
    _navRightBtn.layer.shadowOffset = CGSizeMake(0, -1);
    _navRightBtn.layer.shadowColor = [[UIColor blackColor] CGColor];
    _navRightBtn.layer.shadowOpacity = .5;
    
    _navRightBtn.frame = CGRectMake(IPHONE_WIDTH - 40, 4, 36, 36);
    
    _rightImageBtn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightAddBtn"]];
    _rightImageBtn.frame = CGRectMake(8, 8, 20, 20);
    [_navRightBtn addSubview:_rightImageBtn];
    
    [_navRightBtn addTarget:self action:@selector(navigationBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_navRightBtn];
}

- (void)navigationBtnPressed:(UIButton *)button
{
    if (button.tag == 1) {
        if (showDropView == @"main") {
            LeftViewController *leftVC = [[LeftViewController alloc] init];
            [self pushViewController:leftVC onDirection:PPRevealSideDirectionLeft withOffset:120.0f animated:YES];
            showDropView = @"left";
        }else{
            [self popViewControllerAnimated:YES];
        }
    }else if(button.tag == 2){
        if (showDropView == @"main") {
            RightViewController *rightVC = [[RightViewController alloc] init];
            [self pushViewController:rightVC onDirection:PPRevealSideDirectionRight withOffset:260.0f animated:YES];
            showDropView = @"right";
            [UIView beginAnimations:@"rotate" context:nil];
            [UIView setAnimationDuration:0.3];
            _rightImageBtn.transform = CGAffineTransformMakeRotation((-45) * M_PI / 180.0);
            [UIView commitAnimations];
        }else{
            [self popViewControllerAnimated:YES];
            [UIView beginAnimations:@"rotate" context:nil];
            [UIView setAnimationDuration:0.3];
            _rightImageBtn.transform = CGAffineTransformMakeRotation((0) * M_PI / 180.0);
            [UIView commitAnimations];
        }
    }
}

#pragma mark -mainViewTabbar delegate
- (void)mainViewTabbarBottinTouchUpInside:(UIButton *)button
{
     showDropView = @"main";
    [self popViewControllerAnimated:YES];
    if (button.tag == 0) {
        _navLeftBtn.hidden = NO;
        _navRightBtn.hidden = NO;
    }else{
        _navRightBtn.hidden = YES;
        if (button.tag == 1) {
            _navLeftBtn.hidden = NO;
        }else{
            _navLeftBtn.hidden = YES;
        }
    }
}

#pragma mark -PPRevealSideViewController delegate
- (void) pprevealSideViewController:(PPRevealSideViewController *)controller willPopToController:(UIViewController *)centerController
{
    showDropView = @"main";
}

//模拟器没效果 具体要看真机
//- (BOOL) pprevealSideViewController:(PPRevealSideViewController *)controller shouldDeactivateGesture:(UIGestureRecognizer*)gesture forView:(UIView*)view
//{
//    NSLog(@"111");
//    return YES;
//}

#pragma mark -SinaWeiboRequest delegate
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"连接错误");
}
- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    [_navLeftBtn setTitle:[result objectForKey:@"name"] forState:UIControlStateNormal];
}


- (void)dealloc
{
    [_navLeftBtn release];
    [_navRightBtn release];
    [_sinaWeibo release];
    [_rightImageBtn release];
    [super dealloc];
}
@end
