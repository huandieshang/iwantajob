//
//  AppsViewController.m
//  weico
//
//  Created by 高超 on 3/2/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import "AppsViewController.h"

@interface AppsViewController ()

    //加载广告的图片到scrollview
    - (void)initScrollViewImages;

@end

@implementation AppsViewController
{
    UIScrollView *_scrollView;
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
    UIImageView *headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"appsHeaderImages"]];
    headerView.frame = CGRectMake(0, 0, 320, 115);
    [self.view addSubview:headerView];
    [headerView release];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 115, 320, 301)];
    _scrollView.contentSize = CGSizeMake(320*3, 301);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    [self initScrollViewImages];
    
    UIPageControl *pageContrl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, IPHONE_HEIGHT-90, IPHONE_WIDTH, 30)];
    pageContrl.numberOfPages = 3;
    pageContrl.tag = 101;
    [self.view addSubview:pageContrl];
    [pageContrl release];
}

- (void)initScrollViewImages
{
    for (int index = 0; index < 3; index++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"appsImages%d",index+1]]];
        imageView.frame = CGRectMake(0+IPHONE_WIDTH*index, 0, IPHONE_WIDTH, 301);
        [_scrollView addSubview:imageView];
        [imageView release];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -UIScrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger number = scrollView.contentOffset.x/320;
    UIPageControl *pageContrl = (UIPageControl *)[self.view viewWithTag:101];
    pageContrl.currentPage = number;

}

@end
