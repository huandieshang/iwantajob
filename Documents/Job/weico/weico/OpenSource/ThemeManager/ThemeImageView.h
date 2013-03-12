//
//  ThemeImageView.h
//  WXWeibo
//
//  Created by 高超 on 3/1/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeImageView : UIImageView

//图片名称
@property(nonatomic,copy)NSString *imageName;

@property(nonatomic,assign)int leftCapWidth;
@property(nonatomic,assign)int topCapHeight;

- (id)initWithImageName:(NSString *)imageName;

@end
