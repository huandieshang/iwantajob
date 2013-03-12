//
//  UIFactory.m
//  WXWeibo
//
//  Created by 高超 on 3/1/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import "UIFactory.h"

@implementation UIFactory

+ (ThemeButton *)createButton:(NSString *)imageName highlighted:(NSString *)highlightedName {
    ThemeButton *button = [[ThemeButton alloc] initWithImage:imageName highlighted:highlightedName];
    return [button autorelease];
}

+ (ThemeButton *)createButtonWithBackground:(NSString *)backgroundImageName
                      backgroundHighlighted:(NSString *)highlightedName {
    ThemeButton *button = [[ThemeButton alloc] initWithBackground:backgroundImageName highlightedBackground:highlightedName];
    return [button autorelease];
}

+ (ThemeImageView *)createImageView:(NSString *)imageName {
    ThemeImageView *themeImage = [[ThemeImageView alloc] initWithImageName:imageName];
    return [themeImage autorelease];
}

+ (ThemeLabel *)createLabel:(NSString *)colorName {
    ThemeLabel *themeLabel = [[ThemeLabel alloc] initWithColorName:colorName];
    return [themeLabel autorelease];
}

@end
