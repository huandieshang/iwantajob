//
//  ThemeManager.h
//  WXWeibo
//  主题管理类

//  Created by 高超 on 3/1/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kThemeDidChangeNofication @"kThemeDidChangeNofication"

@interface ThemeManager : NSObject

//当前使用的主题名称
@property(nonatomic,retain)NSString *themeName;
//配置主题的plist文件
@property(nonatomic,retain)NSDictionary *themesPlist;
//Label字体颜色配置plist文件
@property(nonatomic,retain)NSDictionary *fontColorPlist;

+ (ThemeManager *)shareInstance;

//返回当前主题下的图片
- (UIImage *)getThemeImage:(NSString *)imageName;

//返回当前主题下，字体的颜色
- (UIColor *)getColorWithName:(NSString *)name;

@end
