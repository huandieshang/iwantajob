//
//  WeiboCell.m
//  WXWeibo
//
//  Created by wei.chen on 13-1-23.
//  Copyright (c) 2013年 www.iphonetrain.com 无限互联3G学院. All rights reserved.
//

#import "WeiboCell.h"
#import <QuartzCore/QuartzCore.h>
#import "WeiboView.h"
#import "WeiboModel.h"
#import "UserModel.h"
#import "UIImageView+WebCache.h"

@interface WeiboCell ()

@end

@implementation WeiboCell
{

    UIImageView *_userHeadImageView;
    UILabel *_userNameLabel;
    WeiboView *_weiboContentView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //初始化微博头像
        _userHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
        _userHeadImageView.image = [UIImage imageNamed:@"userImageDefault"];
        [self.contentView addSubview:_userHeadImageView];
        //初始化微博发布人名称
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(53, 5, 135, 18)];
        [self.contentView addSubview:_userNameLabel];
        //初始化微博内容
        _weiboContentView = [[WeiboView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_weiboContentView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    UserModel *user = self.weiboModel.user;
    //加载头像
    [_userHeadImageView setImageWithURL:[NSURL URLWithString:user.profile_image_url]];
    
    //加载用户名
    _userNameLabel.text = user.screen_name;
    
    //加载微博内容    
    if (self.weiboModel.relWeibo != nil) {
        _weiboContentView.hasRepost = YES;
    }
    _weiboContentView.weiboModel = self.weiboModel;
    [_weiboContentView setNeedsLayout];
}

- (void)dealloc
{
    [_userHeadImageView release], _userHeadImageView = nil;
    [_userNameLabel release], _userNameLabel = nil;
    [_weiboContentView release], _weiboContentView = nil;
    [super dealloc];
}

@end
