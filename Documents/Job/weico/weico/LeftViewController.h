//
//  LeftViewController.h
//  weico
//
//  Created by 高超 on 3/2/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import "BaseViewController.h"

@interface LeftViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSArray *dataSource;

@end
