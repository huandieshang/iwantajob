//
//  RootViewController.h
//  weico
//
//  Created by 高超 on 3/2/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import "PPRevealSideViewController.h"
#import "MainViewController.h"
#import "SinaWeibo.h"
@interface RootViewController : PPRevealSideViewController<MainViewTabbarDelegate, PPRevealSideViewControllerDelegate,SinaWeiboRequestDelegate>

@property (nonatomic, retain) UIButton *navLeftBtn;
@property (nonatomic, retain) UIButton *navRightBtn;

@end
