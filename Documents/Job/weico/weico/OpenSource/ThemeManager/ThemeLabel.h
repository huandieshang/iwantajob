//
//  ThemeLabel.h
//  WXWeibo
//
//  Created by 高超 on 3/1/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeLabel : UILabel

@property(nonatomic,copy)NSString *colorName;

- (id)initWithColorName:(NSString *)colorName;

@end
