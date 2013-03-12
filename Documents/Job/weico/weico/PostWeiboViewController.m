//
//  PostWeiboViewController.m
//  weico
//
//  Created by 高超 on 3/6/13.
//  Copyright (c) 2013 chao gao. All rights reserved.
//

#import "PostWeiboViewController.h"
#import "FaceView.h"

#define WEIBO_TEXTVIEW_HEIGHT 164
#define NAVIGATIONBAR_HEIGHT 44
#define FUNCTION_BUTTONS_HEIGHT 44

@interface PostWeiboViewController ()

//显示微博发送状态
- (void)showWeiboPostStatus:(BOOL)show title:(NSString *)title;
//获取本地的经纬度
- (void)getLocationPosition;
@end

@implementation PostWeiboViewController
{
    //编写内容视图
    UITextView *_textView;
    //发布功能按钮父视图
    UIView *_functionButtonsView;
    SinaWeibo *_sinaWeibo;
    //发布状态栏window
    UIWindow *_postWeiboStatusWindow;
    //经度
    NSString *_longitudeString;
    //维度
    NSString *_latitudeString;
    //上传图片存放视图
    UIButton *_tempSaveUploadButton;
    //上传图片存放图片
    UIImage *_tempSaveUploadImage;
    //图片详细视图
    UIImageView *_imageDetailView;
    //表情装载父视图
    UIScrollView *_emotionScrollView;
    //表情装载视图
    FaceView *_emotionView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //监听通知 获取键盘的高度
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShowNotification:) name:UIKeyboardWillShowNotification object:nil];
        _longitudeString = @"0.0";
        _latitudeString = @"0.0";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavigationButtons];
    [self initWeiboTextView];
    [self initWeiboPostFunctions];
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initNavigationButtons
{
    //自定义navigationbar按钮
    for (int index = 1; index < 4; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = index;
        button.backgroundColor = [UIColor colorWithRed:(202/255.0) green:(205/255.0) blue:(210/255.0) alpha:.5];
        button.layer.borderWidth = 1.0f;
        button.layer.borderColor = [UIColor colorWithRed:184/255.0f green:185/255.0f blue:189/255.0f alpha:1].CGColor;
        button.layer.cornerRadius = 2.0f;
        
        button.layer.shadowOffset = CGSizeMake(0, -1);
        button.layer.shadowColor = [[UIColor blackColor] CGColor];
        button.layer.shadowOpacity = .5;
        switch (index) {
            case 1:
                button.frame = CGRectMake(4, 4, 36, 36);
                break;
            case 2:                
                button.frame = CGRectMake(IPHONE_WIDTH-40, 4, 36, 36);
                break;
            case 3:
                button.frame = CGRectMake(44, 4, 232, 36);
                break;
            default:
                break;
        }
        [button addTarget:self action:@selector(navigationBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        if(index == 1){
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"closeButton"]];
            imageView.frame = CGRectMake(3, 3, 30, 30);
            [button addSubview:imageView];
        }else if(index == 2){
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"comfirmButton"]];
            imageView.frame = CGRectMake(3, 3, 30, 30);
            [button addSubview:imageView];
        }
        [self.view addSubview:button];
    }
}

//初始化微博编写内容视图
- (void)initWeiboTextView
{
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, NAVIGATIONBAR_HEIGHT, IPHONE_WIDTH, WEIBO_TEXTVIEW_HEIGHT)];
    [self.view addSubview:_textView];
    [_textView becomeFirstResponder];
}

//初始化发布微博按钮
- (void)initWeiboPostFunctions
{
    _functionButtonsView = [[UIView alloc] initWithFrame:CGRectMake(0, WEIBO_TEXTVIEW_HEIGHT+NAVIGATIONBAR_HEIGHT, IPHONE_WIDTH, FUNCTION_BUTTONS_HEIGHT)];
    
    for (int index = 0; index < 5; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = index;
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"postWeiboFunctionButton%d", index+1] ] forState:UIControlStateNormal];
        button.frame = CGRectMake(40+60*index, 5, 30, 30);
        [button addTarget:self action:@selector(functionButtonsPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_functionButtonsView addSubview:button];
    }
    
    [self.view addSubview:_functionButtonsView];
    [_functionButtonsView release];
}

//显示微博发送状态栏
- (void)showWeiboPostStatus:(BOOL)show title:(NSString *)title
{
    if (_postWeiboStatusWindow == nil) {
        _postWeiboStatusWindow = [[UIWindow alloc] initWithFrame:CGRectMake(100, 0, IPHONE_WIDTH-200, IPHONE_STATUS_BAR)];
        _postWeiboStatusWindow.windowLevel = UIWindowLevelStatusBar;
        _postWeiboStatusWindow.backgroundColor = [UIColor blackColor];
        
        UILabel *postStatusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH-200, IPHONE_STATUS_BAR)];
        postStatusLabel.textAlignment = UITextAlignmentCenter;
        postStatusLabel.textColor = [UIColor whiteColor];
        postStatusLabel.backgroundColor = [UIColor clearColor];
        postStatusLabel.font = [UIFont systemFontOfSize:13.0];
        postStatusLabel.text = title;
        postStatusLabel.tag = 10;
        [_postWeiboStatusWindow addSubview:postStatusLabel];
    }
    
    UILabel *postStatusLabel = (UILabel *)[_postWeiboStatusWindow viewWithTag:10];
    postStatusLabel.text = title;
    
    if (show) {
        _postWeiboStatusWindow.hidden = NO;
    }else{
        [self performSelector:@selector(delayPostWeiboStatusBarHide) withObject:nil afterDelay:1.5];
    }
}

- (void)delayPostWeiboStatusBarHide
{
    _postWeiboStatusWindow.hidden = YES;
}

- (void)navigationBtnPressed:(UIButton *)button
{
    NSUInteger tag = button.tag;

    if (tag == 1) {
        [self dismissModalViewControllerAnimated:YES];
    }else if (tag == 2){
        [self sendWeiboToSina];
    }else if (tag == 3){
        
    }
}

//发布微博
- (void)sendWeiboToSina
{
    _sinaWeibo = self.sinaweibo;
    NSString *text = _textView.text;
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:text,@"status", _latitudeString, @"lat", _longitudeString, @"long", nil];
    
    NSString *requestUrl;
    //判断是否要上传图片
    if (_tempSaveUploadButton == nil) {
        requestUrl = @"statuses/update.json";
    }else{
        requestUrl = @"statuses/upload.json";
        
        NSData *imageData = UIImageJPEGRepresentation(_tempSaveUploadImage, 0.5);
                
        [params setObject:imageData forKey:@"pic"];
    }
    [_sinaWeibo requestWithURL:requestUrl params:params httpMethod:@"POST" delegate:self];
    [self showWeiboPostStatus:YES title:@"发送中"];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)functionButtonsPressed:(UIButton *)button
{
    NSUInteger tag = button.tag;
    if (tag == 0) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择相机或相册" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机", @"相册", nil];
        [actionSheet showInView:self.view];
    }else if (tag == 1){
        
    }else if (tag == 2){
        
    }else if (tag == 3){
        //显示微博表情
        [self showEmotionGroupOfIcons];
    }else if (tag == 4){
        //get location position
        [self getLocationPosition];
    }
}


//显示微博表情
- (void)showEmotionGroupOfIcons
{
    //将功能按钮视图下移
    [UIView beginAnimations:@"functionButtonsHideOrShow" context:nil];
    _functionButtonsView.frame = CGRectMake(0, _textView.bottom+FUNCTION_BUTTONS_HEIGHT, IPHONE_WIDTH, FUNCTION_BUTTONS_HEIGHT);
    [UIView commitAnimations];
    
    if (_emotionScrollView == nil) {
        _emotionScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _functionButtonsView.bottom, IPHONE_WIDTH, IPHONE_HEIGHT-_functionButtonsView.bottom)];
        _emotionScrollView.backgroundColor = [UIColor colorWithRed:221/255.0f green:221/255.0f blue:221/255.0f alpha:1];
        _emotionView = [[FaceView alloc] initWithFrame:CGRectZero];
        _emotionView.backgroundColor = [UIColor clearColor];
        _emotionScrollView.contentSize = CGSizeMake(_emotionView.width, _emotionView.height);
        _emotionScrollView.pagingEnabled = YES;
        _emotionScrollView.clipsToBounds = NO;
        [_emotionScrollView addSubview:_emotionView];
    
        [self.view addSubview:_emotionScrollView];
    }
    
    [_textView resignFirstResponder];
}

//获取当前经纬度
- (void)getLocationPosition
{
    CLLocationManager *locationManage = [[CLLocationManager alloc] init];
    locationManage.delegate = self;
    [locationManage setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [locationManage startUpdatingLocation];
}

#pragma mark -keyBoardHightChange
static float keyBoardHeight = 0;
//点击键盘切换输入法 重新初始化高度
- (void)keyboardShowNotification:(NSNotification *)notification
{
    NSValue *keyboardValues = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect frame = [keyboardValues CGRectValue];
    float height = frame.size.height;
    if (keyBoardHeight != height) {
        _textView.frame = CGRectMake(0, NAVIGATIONBAR_HEIGHT, IPHONE_WIDTH, IPHONE_HEIGHT-IPHONE_STATUS_BAR - FUNCTION_BUTTONS_HEIGHT-NAVIGATIONBAR_HEIGHT-height);
        [UIView beginAnimations:@"functionButtonsHideOrShow" context:nil];
        _functionButtonsView.frame = CGRectMake(0, IPHONE_HEIGHT-IPHONE_STATUS_BAR - NAVIGATIONBAR_HEIGHT-height, IPHONE_WIDTH, FUNCTION_BUTTONS_HEIGHT);
        [UIView commitAnimations];
        keyBoardHeight = height;
    }
}

//插入上传视图到功能按钮界面
- (void)insertPreUploadImage:(NSDictionary *)info
{
    _tempSaveUploadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _tempSaveUploadButton.frame = CGRectMake(6, 16, FUNCTION_BUTTONS_HEIGHT-10, FUNCTION_BUTTONS_HEIGHT-10);
    [_tempSaveUploadButton setImage:info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
    [_tempSaveUploadButton addTarget:self action:@selector(showDetailImage:) forControlEvents:UIControlEventTouchUpInside];
    [_functionButtonsView addSubview:_tempSaveUploadButton];
    _tempSaveUploadImage = (UIImage *)info[UIImagePickerControllerOriginalImage];
}

//点击放大图片
- (void)showDetailImage:(UIButton *)button
{
    //失去焦点
    [_textView resignFirstResponder];
    //隐藏键盘
    
    
    if (_imageDetailView == nil) {
        _imageDetailView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT)];
        _imageDetailView.contentMode = UIViewContentModeScaleAspectFit;
        _imageDetailView.backgroundColor = [UIColor blackColor];
    }
    
    if (![_imageDetailView superview]) {
        _imageDetailView.userInteractionEnabled = YES;
        _imageDetailView.image = _tempSaveUploadImage;
        [self.view.window addSubview:_imageDetailView];
        
        _imageDetailView.frame = CGRectMake(6, 16, FUNCTION_BUTTONS_HEIGHT-10, FUNCTION_BUTTONS_HEIGHT-10);
        [UIView animateWithDuration:.4 animations:^{
            _imageDetailView.frame = CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT);
        } completion:^(BOOL finished) {
            [UIApplication sharedApplication].statusBarHidden = YES;
        }];
    }
}

- (void)dealloc
{
    [_textView release], _textView = nil;
    [super dealloc];
}

#pragma mark actionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerControllerSourceType sourceType;
    if (buttonIndex == 0) {
        BOOL cameraAvailable = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!cameraAvailable) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"无法使用相机" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        sourceType = UIImagePickerControllerSourceTypeCamera;
    }else if (buttonIndex == 1){
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }else{
        return;
    }
    UIImagePickerController *camera = [[UIImagePickerController alloc] init];
    camera.sourceType = sourceType;
    camera.delegate = self;
    [self presentModalViewController:camera animated:YES];
    [camera release];
}

#pragma mark UIImagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissModalViewControllerAnimated:YES];
    [self insertPreUploadImage:info];
}

#pragma mark cllocationManage delegate
- (void)locationManager:(CLLocationManager *)manager
didUpdateToLocation:(CLLocation *)newLocation
fromLocation:(CLLocation *)oldLocation
{
    [manager stopUpdatingLocation];
    
    float longitude = newLocation.coordinate.longitude;
    float latitude = newLocation.coordinate.latitude;
    _longitudeString = [[NSString stringWithFormat:@"%f",longitude] retain];
    _latitudeString = [[NSString stringWithFormat:@"%f", latitude] retain];
}

#pragma mark sinaWeibo request delegate
- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self showWeiboPostStatus:NO title:@"发送失败."];
    NSLog(@"error %@", error);
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self showWeiboPostStatus:NO title:@"发送成功."];
    [self dismissModalViewControllerAnimated:YES];
}
@end
