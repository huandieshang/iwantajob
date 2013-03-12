//
//  WeiboListViewController.h
//  weico
//
//  Created by 高超 on 3/3/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "EGORefreshTableHeaderView.h"

@interface WeiboListViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate, SinaWeiboRequestDelegate, EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
	
	//  Reloading var should really be your tableviews datasource
	//  Putting it here for demo purposes
	BOOL _reloading;
}

@property (nonatomic, retain) NSArray *dataSource;

@property (nonatomic, retain) SinaWeibo *sinaWeibo;

@property (nonatomic, assign) BOOL noNeedPullReflash;
@end
