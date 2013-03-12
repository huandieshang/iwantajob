//
//  MainViewController.h
//  Weico
//
//  Created by 高超 on 3/1/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"

@protocol MainViewTabbarDelegate <NSObject>

@optional

- (void)mainViewTabbarBottinTouchUpInside:(UIButton *)button;

@end

@interface MainViewController : UITabBarController<SinaWeiboDelegate,SinaWeiboRequestDelegate>
{
    UIView *_tabbarView;
    UIView *_tabbarSelectedBackground;
}

@property (nonatomic, retain) id<MainViewTabbarDelegate> mainVCDelegate;

@end

