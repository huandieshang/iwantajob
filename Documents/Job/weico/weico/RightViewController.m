//
//  RightViewController.m
//  weico
//
//  Created by 高超 on 3/2/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import "RightViewController.h"
#import "PostWeiboViewController.h"

@interface RightViewController ()

@end

@implementation RightViewController
{
    UIScrollView *_scrollView;
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
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(IPHONE_WIDTH-50, 44, IPHONE_WIDTH, IPHONE_HEIGHT-200)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.contentSize = CGSizeMake(IPHONE_WIDTH-50, IPHONE_HEIGHT-199);
    //添加按钮到视图
    [self initViewButtons];
    [self.view addSubview:_scrollView];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundViewImage"]];
}

- (void)initViewButtons
{
    for (int index = 0; index<3; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10, 10+index*40, 27, 27);
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"rightBackgroundBtn%d", index+1]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];
    }
}

- (void)buttonPressed:(UIButton *)button
{
    PostWeiboViewController *postWeibo = [[PostWeiboViewController alloc] init];
    postWeibo.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:postWeibo animated:YES completion:^{
        
    }];
    [postWeibo release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
