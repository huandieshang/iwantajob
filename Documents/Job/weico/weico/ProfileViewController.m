//
//  ProfileViewController.m
//  weico
//
//  Created by 高超 on 3/2/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import "ProfileViewController.h"
#import "WeiboListViewController.h"

#define imageHeight 550
#define imageInitOffset 80
#define sinaWeiboListPointOffset 50

@interface ProfileViewController ()
//初始化微博列表
- (void)initSinaWeiBoList;
- (void)showScrollerView;
@end

@implementation ProfileViewController
{
    UIView *_view;
    UIScrollView *_scrollView;
    UIImageView *_imageView;
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
        
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -imageInitOffset, IPHONE_WIDTH, imageHeight)];
    _imageView.image = [UIImage imageNamed:@"backgroundProfile"];
    [self.view addSubview:_imageView];
    [self initSinaWeiBoList];
}

- (void)initSinaWeiBoList
{
    //初始化微博列表
    _view = [[UIView alloc] initWithFrame:CGRectMake(0, sinaWeiboListPointOffset, IPHONE_WIDTH, IPHONE_HEIGHT)];
    _view.backgroundColor = [UIColor redColor];
    [self.view addSubview:_view];
}

static float beginTapPosition;

#pragma mark 创建手势
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSUInteger multTouches = [touches count];
    if (multTouches > 1) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    beginTapPosition = point.y;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSUInteger multTouches = [touches count];
    if (multTouches > 1) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    float currentPoint = point.y;
    
    float distance = currentPoint - beginTapPosition;
    
        
    _view.frame = CGRectMake(0, distance, IPHONE_WIDTH, IPHONE_HEIGHT);
    if (distance < imageInitOffset*3) {
        _imageView.frame = CGRectMake(0, -imageInitOffset+distance/3, IPHONE_WIDTH, imageHeight);
    }
    _view.frame = CGRectMake(0, sinaWeiboListPointOffset+distance/2, IPHONE_WIDTH, IPHONE_HEIGHT);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSUInteger multTouches = [touches count];
    if (multTouches > 1) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    float currentPoint = point.y;
    
    float distance = currentPoint - beginTapPosition;
    if (distance > imageInitOffset) {
        [UIView beginAnimations:@"hideView" context:nil];
        [UIView setAnimationDuration:0.5];
        _imageView.frame = CGRectMake(0, 0, IPHONE_WIDTH, imageHeight);
        _view.frame = CGRectMake(0, IPHONE_HEIGHT, IPHONE_WIDTH, IPHONE_HEIGHT);
        [UIView commitAnimations];
        [self showScrollerView];
    }else{
        [UIView beginAnimations:@"hideView" context:nil];
        [UIView setAnimationDuration:0.5];
        _imageView.frame = CGRectMake(0, -imageInitOffset, IPHONE_WIDTH, imageHeight);
        _view.frame = CGRectMake(0, sinaWeiboListPointOffset, IPHONE_WIDTH, IPHONE_HEIGHT);
        [UIView commitAnimations];
    }
}

- (void)showScrollerView
{
    [_imageView removeFromSuperview];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT)];
    _scrollView.contentSize = CGSizeMake(IPHONE_WIDTH, imageHeight);
    _imageView.frame = CGRectMake(0, 0, IPHONE_WIDTH, imageHeight);
    [_scrollView addSubview:_imageView];
    
    [self.view insertSubview:_scrollView belowSubview:_view];
    
    self.view.backgroundColor = [UIColor grayColor];
    [_scrollView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
