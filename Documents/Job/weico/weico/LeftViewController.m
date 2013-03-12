//
//  LeftViewController.m
//  weico
//
//  Created by 高超 on 3/2/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController
{
    UITableView *_tableView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.dataSource = @[@"All",@"开发",@"娱乐"];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, IPHONE_WIDTH, IPHONE_HEIGHT-200) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    //设置第一条信息为选中
    [_tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:0];
    [self.view addSubview:_tableView];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundViewImage"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -tableView dataSource delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifily = @"cell";
    NSUInteger row = indexPath.row;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifily];
    if (cell == nil) {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifily];
    }
    cell.textLabel.text = self.dataSource[row];
    return cell;
}

#pragma mark -tableView delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 0)];
    for (int index = 0; index<3; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"backgroundViewFilterBtn%d", index+1]] forState:UIControlStateNormal];
        button.frame = CGRectMake(12+index*42, 6, 20, 20);
        [view addSubview:button];
        
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 36.0f;
}


- (void)dealloc
{
    [_tableView release], _tableView = nil;
    [super dealloc];
}


@end
