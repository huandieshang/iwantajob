//
//  WeiboAnnotationView.m
//  weico
//
//  Created by 高超 on 3/10/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import "WeiboAnnotationView.h"
#import "WeiboMapAnnotation.h"
#import "UIImageView+WebCache.h"

@implementation WeiboAnnotationView
{
    UIImageView *_userImage;
    UIImageView *_weiboImage;
    UILabel *_weiboText;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    _userImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    _weiboImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _weiboImage.contentMode = UIViewContentModeScaleAspectFit;
    
    _weiboText = [[UILabel alloc] initWithFrame:CGRectZero];
    
    [self addSubview:_userImage];
    [self addSubview:_weiboImage];
    [self addSubview:_weiboText];
    self.alpha = 1;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    WeiboMapAnnotation *annotation = self.annotation;
    WeiboModel *weiboModel = nil;
    if ([annotation isKindOfClass:[WeiboMapAnnotation class]]) {
        weiboModel = annotation.weiboModel;
    }
    
    NSString *thumbnailImage = weiboModel.thumbnailImage;
    NSString *userImageUrl = weiboModel.user.profile_image_url;
    if (thumbnailImage == nil) {
        self.image = [UIImage imageNamed:@"mapWeiboBackground"];
        
        _userImage.frame = CGRectMake(6, 10, 35, 35);
        [_userImage setImageWithURL:[NSURL URLWithString:userImageUrl]];
        
        _weiboText.frame = CGRectMake(50, 10, 120, 35);
        _weiboText.backgroundColor = [UIColor clearColor];
        _weiboText.font = [UIFont systemFontOfSize:9.0f];
        _weiboText.textColor = [UIColor whiteColor];
        _weiboText.numberOfLines = 3;
        _weiboText.text = weiboModel.text;
        
    }else{
        self.image = [UIImage imageNamed:@"mapWeiboBackground2"];
        _weiboImage.frame = CGRectMake(5, 5, 85, 80);
        [_weiboImage setImageWithURL:[NSURL URLWithString:thumbnailImage]];
        
    }
    
}

@end
