//
//  FaceView.m
//  weico
//
//  Created by 高超 on 3/8/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import "FaceView.h"

#define emotionImageWidth 30
#define emotionCellWidth 45
#define emotionBigViewWidth 52
#define emotionBigViewHeight 104

@implementation FaceView
{
    NSMutableArray *_items;
    UIImageView *_bigImageView;
    NSString *_imageName;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initEmotionPlistData];
    }
    return self;
}

//初始化plist文件
- (void)initEmotionPlistData
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"emoticons" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray *items2D = nil;
    _items = [[NSMutableArray alloc] init];
    
    for (int index = 0; index<array.count; index++) {
        NSDictionary *item = [array objectAtIndex:index];
        if (index % 21 == 0) {
            items2D = [NSMutableArray arrayWithCapacity:21];
            [_items addObject:items2D];
        }
        [items2D addObject:item];
    }
    self.width = _items.count * IPHONE_WIDTH;
    self.height = emotionCellWidth * 3;
}

- (void)drawRect:(CGRect)rect
{
    //定义列和行
    int row = 0, column = 0;
    
    for (int i = 0; i < _items.count; i++) {
        NSArray *items2D = [_items objectAtIndex:i];
        for (int j = 0; j < items2D.count; j++) {
            NSDictionary *item = [items2D objectAtIndex:j];
            
            NSString *imageName = [item objectForKey:@"gif"];
            UIImage *image = [UIImage imageNamed:imageName];
            
            CGRect frame = CGRectMake(column*emotionCellWidth+i*IPHONE_WIDTH+7.5, row*emotionCellWidth+7.5, emotionImageWidth, emotionImageWidth);
            [image drawInRect:frame];
                        
            //更新列 行
            column++;
            if (column % 7 == 0) {
                row++;
                column = 0;
            }
            if (row == 3) {
                row = 0;
            }
        }
    }
}

static int pageStatic = 0;
static int columnStatic = 0;
static int rowStatic = 0;

- (void)touchFace:(CGPoint)point
{
    //获取页数
    int page = point.x/IPHONE_WIDTH;
    //获取列数
    int column = (point.x - page*IPHONE_WIDTH)/emotionCellWidth;
    //获取行数
    int row = point.y/emotionCellWidth;
    
    if (column < 0) {
        column = 0;
    }
    if (column > 6) {
        column = 6;
    }
    
    if (row < 0) {
        row = 0;
    }
    if (row > 2) {
        row = 2;
    }
    
    if (page != pageStatic || column != columnStatic || row != rowStatic) {
        NSArray *items2D = [_items objectAtIndex:page];
        NSDictionary *item = [items2D objectAtIndex:(column+(row*7))];
    
        UIImageView *littleImage = (UIImageView *)[_bigImageView viewWithTag:2];
        _imageName = item[@"gif"];
        littleImage.image = [UIImage imageNamed:_imageName];
        _bigImageView.frame = CGRectMake(-4+column*emotionCellWidth+page*IPHONE_WIDTH, 42-emotionBigViewHeight+row*emotionCellWidth, emotionBigViewWidth, emotionBigViewHeight);
        _bigImageView.hidden = NO;
        
        pageStatic = page, columnStatic = column, rowStatic = row;
    }else{
        return;
    }
}

//接触视图
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_bigImageView == nil) {
        _bigImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"emotionBigView"]];
        _bigImageView.frame = CGRectMake(0, 0, emotionBigViewWidth, emotionBigViewHeight);
        _bigImageView.hidden = YES;
        UIImageView *littleImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 14, emotionImageWidth, emotionImageWidth)];
        littleImage.tag = 2;
        [_bigImageView addSubview:littleImage];
        [littleImage release];
        [self addSubview:_bigImageView];
    }
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self touchFace:point];
    
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)[self superview];
        scrollView.scrollEnabled = NO;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self touchFace:point];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    _bigImageView.hidden = YES;
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)[self superview];
        scrollView.scrollEnabled = YES;
    }
}

@end
