//
//  PostWeiboViewController.h
//  weico
//
//  Created by 高超 on 3/6/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface PostWeiboViewController : BaseViewController<SinaWeiboRequestDelegate, CLLocationManagerDelegate, UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end
