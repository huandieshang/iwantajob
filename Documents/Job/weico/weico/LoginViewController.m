//
//  LoginViewController.m
//  weico
//
//  Created by 高超 on 3/2/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "RootViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
{
    UITextField *_text;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    UIView *baseView = [[UIView alloc] init];
    baseView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"loginBackground"]];
    self.view = baseView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(66, 153, 63, 62);
    [button addTarget:self action:@selector(logInSinaAccount) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UILabel *account = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 80, 20)];
    account.backgroundColor = [UIColor clearColor];
    account.text = @"微博账号:";
    [self.view addSubview:account];
    [account release];
    
    _text = [[UITextField alloc] initWithFrame:CGRectMake(95, 100, 200, 40)];
    _text.delegate = self;
    _text.text = @"samuelforwork@qq.com";
    [_text becomeFirstResponder];
    [self.view addSubview:_text];
    [_text release];
    
    UILabel *password = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, 300, 20)];
    password.backgroundColor = [UIColor clearColor];
    password.text = @"微博密码:  123456789";
    [self.view addSubview:password];
    [password release];
}

- (void)logInSinaAccount
{
    [_text resignFirstResponder];
    [self.sinaweibo logIn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * @description 清空认证信息
 */
- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
}

- (void)storeAuthData
{
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              self.sinaweibo.accessToken, @"AccessTokenKey",
                              self.sinaweibo.expirationDate, @"ExpirationDateKey",
                              self.sinaweibo.userID, @"UserIDKey",
                              self.sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"%@", authData);
}

#pragma mark SinaWeibo delegate
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    [self removeAuthData];
    [self storeAuthData];
    
    //授权成功， 进入会话见面
    //创建主控制器
    MainViewController *mainVC = [[MainViewController alloc] init];
    
    //创建左右菜单控制器
    RootViewController *rootVC = [[RootViewController alloc] initWithRootViewController:mainVC];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    
    [window setRootViewController:rootVC];
    
    [rootVC release];
}

#pragma mark textfield delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField selectAll:self];
}

@end
