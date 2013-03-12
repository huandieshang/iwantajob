//
//  WeiboView.h
//  Weico
//
//  Created by 高超 on 3/1/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"

@class WeiboModel;
@class ThemeImageView;
@interface WeiboView : UIView<RTLabelDelegate>

@property (nonatomic, assign) BOOL hasRepost;
@property (nonatomic, assign) BOOL isRepost;

@property (nonatomic, retain) WeiboModel *weiboModel;

+ (CGFloat)getWeiboViewHeight:(WeiboModel *)weiboModel isRepost:(BOOL)isRepost isOriginal:(BOOL)isOriginal;

@end
