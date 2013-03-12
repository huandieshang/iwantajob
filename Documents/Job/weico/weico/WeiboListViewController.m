//
//  WeiboListViewController.m
//  weico
//
//  Created by 高超 on 3/3/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import "WeiboListViewController.h"
#import "WeiboModel.h"
#import "WeiboCell.h"
#import "WeiboView.h"
#import "WeiboDetailViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "UserDB.h"

@interface WeiboListViewController ()

//初始化下拉刷新
-(void)initPullRefresh;
//获取新浪微博json
-(void)urlLoadWeiboList;

@end

@implementation WeiboListViewController
{
    UIActivityIndicatorView *_activeView;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initPullRefresh];
        
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (_dataSource == nil) {
        self.tableView.hidden = YES;
    }else{
        
    }
    [self urlLoadWeiboList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_refreshHeaderView release], _refreshHeaderView = nil;
    [super dealloc];
}

//下拉更新微博
- (void)initPullRefresh
{
    if (!self.noNeedPullReflash) {
        _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f-self.tableView.bounds.size.height, IPHONE_WIDTH, self.tableView.bounds.size.height)];
        [self.view addSubview:_refreshHeaderView];
        _refreshHeaderView.delegate = self;
    }
}

- (void)urlLoadWeiboList
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self.sinaWeibo requestWithURL:@"statuses/home_timeline.json" params:[NSMutableDictionary dictionaryWithObject:@"50" forKey:@"count"] httpMethod:@"GET" delegate:self];
    [self initSqlite];
}

- (void)initSqlite
{
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"WeiboCell";
    WeiboCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[WeiboCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.weiboModel = [self.dataSource objectAtIndex:[indexPath row]];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height = [WeiboView getWeiboViewHeight:[self.dataSource objectAtIndex:indexPath.row] isRepost:NO isOriginal:YES];
    return height+60;
}

#pragma mark -sinaWeibo request delegate

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    NSLog(@"连接出错");
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    NSArray *statuses = [result objectForKey:@"statuses"];
    NSMutableArray *weibos = [NSMutableArray arrayWithCapacity:statuses.count];
    for (NSDictionary *statusesDic in statuses) {
        WeiboModel *weiboList = [[WeiboModel alloc] initWithDataDic:statusesDic];
        [weibos addObject:weiboList];
        [weiboList relWeibo];
    }
    self.dataSource = weibos;
    //列表重新加载
    [self.tableView reloadData];
    //关闭下拉刷新
    [self doneLoadingTableViewData];
    
    self.tableView.hidden = NO;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
    UserDB *userDB = [[UserDB alloc] init];
    [userDB insertTable];
    
}


//---------------egoPullReFresh-START------------//

#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	//  should be calling your tableviews data source model to reload
	_reloading = YES;
}

- (void)doneLoadingTableViewData{
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}

#pragma mark -egoRefreshTableHeader delegate

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    //开始请求微博json
    [self urlLoadWeiboList];
	[self reloadTableViewDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	return [NSDate date]; // should return date data source was last changed
	
}

#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}
//---------------egoPullReFresh-END------------//
@end
