//
//  WeiboView.m
//  Weico
//  布局微博内容视图
//  Created by 高超 on 3/1/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import "WeiboView.h"
#import "RTLabel.h"
#import "UIFactory.h"
#import "WeiboModel.h"
#import "UIImageView+WebCache.h"
#import "ThemeImageView.h"

@interface WeiboView ()

//初始化微博内容所需要的所有视图
-(void)initAllView;

@end

@implementation WeiboView
{
    RTLabel *_content;
    UIImageView *_contentImage;
    ThemeImageView *_repostContentBackgroundView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initAllView];
    }
    return self;
}

- (void)initAllView
{
    //初始化original微博
    _content = [[RTLabel alloc] initWithFrame:CGRectZero];
    _content.delegate = self;
    //_content.font = [UIFont systemFontOfSize:18.0f];
    _content.linkAttributes = [NSDictionary dictionaryWithObject:@"#4595CB" forKey:@"color"];
    
    [self addSubview:_content];
    
    //初始化original微博的图片
    _contentImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weiboUnloadImage"]];
    _contentImage.contentMode = UIViewContentModeScaleAspectFit;
    _contentImage.hidden = YES;
    [self addSubview:_contentImage];
    
//    _repostContentBackgroundView = [UIFactory createImageView:@"reportBackgroundImage"];
//    UIImage *image = [_repostContentBackgroundView.image stretchableImageWithLeftCapWidth:25 topCapHeight:10];
//    _repostContentBackgroundView.image = image;
//    _repostContentBackgroundView.leftCapWidth = 25;
//    _repostContentBackgroundView.topCapHeight = 10;
//    _repostContentBackgroundView.backgroundColor = [UIColor greenColor];
//    [self insertSubview:_repostContentBackgroundView atIndex:0];
}

- (void)setWeiboModel:(WeiboModel *)weiboModel
{
    if (_weiboModel != weiboModel) {
        [_weiboModel release], _weiboModel =nil;
        _weiboModel = [weiboModel retain];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float contentHeight = [WeiboView getWeiboViewHeight:self.weiboModel isRepost:NO isOriginal:YES];
    
    //加载original微博
    _content.text = self.weiboModel.text;
    _content.frame = CGRectMake(0, 0, self.width, 20);
    
    //判断当前视图是否为转发视图
//    if (self.isRepost) {
//        _textLabel.frame = CGRectMake(10, 10, self.width-20, 0);
//    }
    
    //文本内容尺寸
    _content.height = _content.optimumSize.height;
    
    if (self.weiboModel.thumbnailImage != nil && ![self.weiboModel.thumbnailImage isEqualToString:@""]) {
        _contentImage.hidden = NO;
        
        _contentImage.frame = CGRectMake(0, _content.optimumSize.height+10, 65, 50);
        [_contentImage setImageWithURL:[NSURL URLWithString:self.weiboModel.thumbnailImage]];
    }else{
        _contentImage.hidden = YES;
    }
    
    //判断是否有转发微博
    if (self.hasRepost) {
        _repostContentBackgroundView.frame = CGRectMake(0, _content.optimumSize.height+200, 65, 50);
        
        //初始化转发微博
        WeiboView *rePostContent = [[WeiboView alloc] init];
        rePostContent.isRepost = YES;
        rePostContent.hasRepost = NO;
        rePostContent.weiboModel = self.weiboModel.relWeibo;
        //[self addSubview:rePostContent];
        
        contentHeight += rePostContent.size.height;
    }
    
    if (self.isRepost) {
        self.backgroundColor = [UIColor grayColor];
    }else{
        
    }
    self.frame = CGRectMake(53, 30, WEIBO_ORIGINAL_VIEW_WIDTH, contentHeight);
}

+ (CGFloat)getWeiboViewHeight:(WeiboModel *)weiboModel isRepost:(BOOL)isRepost isOriginal:(BOOL)isOriginal
{
    CGFloat heigh = 0.0;
    
    //微博内容高度
    RTLabel *content = [[RTLabel alloc] initWithFrame:CGRectZero];
    content.text = weiboModel.text;
    content.width = WEIBO_ORIGINAL_VIEW_WIDTH;
    heigh += content.optimumSize.height;
    
    //微博图片高度
    if (weiboModel.thumbnailImage != nil && ![weiboModel.thumbnailImage isEqualToString:@""]) {
        heigh += 50+10;
    }
    
    if (isOriginal && weiboModel.relWeibo != nil) {
        //heigh += [WeiboView getWeiboViewHeight:weiboModel.relWeibo isRepost:YES isOriginal:NO];
    }
    
    return heigh;
}


- (void)dealloc
{
    [_content release], _content = nil;
    [super dealloc];
}

#pragma mark -RTLabel delegate

- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url
{
    
}

@end
