//
//  BaseViewController.h
//  Weico
//
//  Created by 高超 on 3/1/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"

@interface BaseViewController : UIViewController

- (SinaWeibo *) sinaweibo;

- (UIButton *) globalNavigationLeftBtn;
- (UIButton *) globalNavigationRightBtn;

@end
