//
//  BaseViewController.m
//  Familysystem
//
//  Created by 李立 on 15/8/21.
//  Copyright (c) 2015年 LILI. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "BaseViewController.h"
#import "BaseNavigationController.h"
#import "MainTabBarController.h"


#define timeOutCount  15

@interface BaseViewController ()
{
    UIView *_default_view;//默认无数据试图
}
@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    if ([[WLSQXcloulink sharedManager] getWLSQXcloulinkNetWorkStateType] == YZYNetWorkStateTypeNoconnect) {
//
//        [MBProgressHUD mh_showTips:@"当前网络不可用，请尝试开启手机网络"];
//
//    }
//
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(YZYnetWorkStateChange:) name:Noti_ChanceNetWorkStateType object:nil];
   
}

- (void)viewWillDisappear:(BOOL)animated
{

    [super viewWillDisappear:animated];
    
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:Noti_ChanceNetWorkStateType object:nil];
  

}



#pragma mark  ------------  网络改变的通知--------------------
- (void)YZYnetWorkStateChange:(NSNotification *)noti
{

}


- (void)login_out
{
    
//    [UserDefaults setBool:NO forKey:ISLogin];
//    [UserDefaults synchronize];
//
//    [[NSNotificationCenter defaultCenter]postNotificationName:Noti_Login_exit object:nil];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //关闭/开启系统右滑返回
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    // 状态栏的字体为黑色：UIStatusBarStyleDefault 状态栏的字体为白色：UIStatusBarStyleLightContent
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.view.backgroundColor = Color_fafafa;
//    [self wr_setNavBarTitleColor:[UIColor whiteColor]];
//    [self wr_setNavBarBarTintColor:Color_nav];
    [self add_back_btu];
    
}


/**
 添加返回按钮
 */
- (void)add_back_btu
{
    if (self.navigationController.viewControllers.count > 1) {
        
//       self.navigationItem.leftBarButtonItem = [UIBarButtonItem mh_backItemWithTitle:nil imageName:@"返回键" target:self action:@selector(back)];
    }
  
}


/**
 点击返回按钮的方法
 */
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}



/**
 设置标题
 
 @param title 标题
 @param titleColor 标题颜色 为nil时 默认白色
 */
- (void)set_title:(NSString *)title
       titleColor:(UIColor *)titleColor
{
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:titleColor == nil ? [UIColor whiteColor] : titleColor}];
    self.navigationItem.title = title;
}


/**
 通过自定义的方法，快速初始化一个UIBarButtonItem，内部是按钮
 
 @param title 显示的文字，例如'完成'、'取消'
 @param titleColor title的颜色，if nil ，The Color is [UIColor whiteColor]
 @param imageName 图片名称 if nil 没有图片
 @param barItemAlignment 按钮在左还是在右
 @param target target
 @param selector selector
 @param contentHorizontalAlignment 文本对齐方向
 
 */

- (void)add_customItemWithTitle:(NSString *)title
                     titleColor:(UIColor *)titleColor
                      imageName:(NSString *)imageName
               barItemAlignment:(BarItemAlignment)barItemAlignment
                         target:(id)target
                       selector:(SEL)selector
     contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment
{
    
    if (barItemAlignment == BarItemAlignment_Left) {
        
//        self.navigationItem.leftBarButtonItem = [UIBarButtonItem mh_customItemWithTitle:title titleColor:titleColor imageName:imageName target:target selector:selector contentHorizontalAlignment:contentHorizontalAlignment];
    }
    
    if (barItemAlignment == BarItemAlignment_Right) {
        
//        self.navigationItem.rightBarButtonItem = [UIBarButtonItem mh_customItemWithTitle:title titleColor:titleColor imageName:imageName target:target selector:selector contentHorizontalAlignment:contentHorizontalAlignment];
    }
    
}


/**
 添加无网提示
 */
- (BOOL)add_NetWorkStateTypeNoconnect
{
    
//    if ([[WLSQXcloulink sharedManager] getWLSQXcloulinkNetWorkStateType] == YZYNetWorkStateTypeNoconnect) {
//        
//        [MBProgressHUD showError:@"当前网络不可用，请尝试开启手机网络" toView:[UIApplication sharedApplication].keyWindow];
//        
//        return YES;;
//    }
//    
    return NO;
}


/**
 添加没有数据提示
 
 @param imagaName 默认图片
 @param defaultString 默认文字
 */

- (void)add_no_data_default_image:(NSString *)imagaName defaultString:(NSString *)defaultString
{

    if (_default_view == nil) {
        
        _default_view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
        
        
        _default_view.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_default_view];
        
        UIImageView *bg_imageView = [[UIImageView alloc]initWithFrame:_default_view.bounds];
        bg_imageView.image = [UIImage imageNamed:@"def_bg"];
        [_default_view addSubview:bg_imageView];
        
        UIImageView *default_imageView = [[UIImageView alloc]initWithFrame:CGRectMake((_default_view.width - 186) / 2.0,( _default_view.height - 183 ) / 2.0 - 20, 186, 183)];
        default_imageView.image = [UIImage imageNamed:imagaName];
        [_default_view addSubview:default_imageView];
        
        UILabel *default_label = [[UILabel alloc] initWithFrame:CGRectMake(10, default_imageView.bottom + 20, _default_view.width - 20, 20)];
//        default_label.textColor = Color_666666;
        default_label.font = [UIFont systemFontOfSize:15];
        default_label.textAlignment = NSTextAlignmentCenter;
        default_label.text = defaultString;
        [_default_view addSubview:default_label];
        
    }
    

}

/**
 移除没有数据显示
 */

- (void)remove_no_data_default
{

    [_default_view removeFromSuperview];
    _default_view = nil;

}

@end
