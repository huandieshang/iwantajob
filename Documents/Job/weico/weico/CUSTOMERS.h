//
//  CUSTOMERS.h
//  FirstApp
//
//  Created by 高超 on 13-2-14.
//  Copyright (c) 2013年 chao gao. All rights reserved.
//

#ifndef FirstApp_CUSTOMERS_h
#define FirstApp_CUSTOMERS_h

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IPHONE_HEIGHT [UIScreen mainScreen].bounds.size.height
#define IPHONE_WIDTH [UIScreen mainScreen].bounds.size.width

#define TAB_BAR_HEIGHT 43
#define TAB_BAR_CELL_WIDTH IPHONE_WIDTH/5

#define IPHONE_STATUS_BAR 20

#define WEIBO_ORIGINAL_VIEW_WIDTH  240

#define kAppKey                             @"1141225743"
#define kAppSecret                          @"cd05268a752099b06f416de4bcb3b2cc"
#define kAppRedirectURI                     @"http://www.baidu.com"

#define Color(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#endif
