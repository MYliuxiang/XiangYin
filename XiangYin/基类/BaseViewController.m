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

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation BaseViewController

- (void)dealloc
{
    NSLog(@"[%@] 释放了", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [self setupDefaultNavBar];
    self.leftBtnImage = @"返回箭头";

    if (self.navigationController.viewControllers.count > 1 ) {

        self.hiddenLeftBtn = NO;
    }else{
        
        self.hiddenLeftBtn = YES;
    }
    
    
    //    self.navigationController.navigationBar.translucent = NO;
    //    self.tabBarController.tabBar.translucent = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.view endEditing:YES];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:![self isStatusBarVisible]];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    //    [self.navigationController setNavigationBarHidden:![self isNaviBarVisible] animated:YES];
    UIStatusBarStyle style = [self preferredStatusBarStyle];
    [[UIApplication sharedApplication] setStatusBarStyle:style animated:NO];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)isNaviBarVisible {
    return YES;
}

- (BOOL)isStatusBarVisible {
    return YES;
}

- (void)setupDefaultNavBar
{
    [self configNavigationBar];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.translucent = NO;
    self.navigationController.navigationBar.translucent = NO;
    UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftButton];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, leftBtnItem, nil];
    
    UIBarButtonItem *rightnegativeSpacer = [[UIBarButtonItem alloc]
                                            initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                            target:nil action:nil];
    rightnegativeSpacer.width = -10;
    
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightBtnItem, nil];
   
    self.leftBtnImage = @"";
    self.rightBtnImage = @"";
    self.rightBtnTitle = @"";
    self.leftBtnTitle = @"";
    self.hiddenRightBtn = NO;
    self.hiddenLeftBtn = NO;
}

- (void)configNavigationBar {
    
    self.navigationController.navigationBar.titleTextAttributes=
    @{NSForegroundColorAttributeName:[UIColor whiteColor],
      NSFontAttributeName:[UIFont systemFontOfSize:18]};
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"返回箭头"] forBarMetrics:UIBarMetricsDefault];
////        [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
}

#pragma mark -- 事件
- (void)tapAction:(UITapGestureRecognizer *)tap
{
//    [self.view endEditing:YES];
}

- (void)leftButtonAction:(UIButton *)sender
{
    //    [self.navigationController popViewControllerAnimated:YES];
    //FIX ME:这里需要根据前置页面是present或者push进来做一个判断
    NSArray *viewControllers = self.navigationController.viewControllers;
    if (viewControllers.count > 1) {
        if (viewControllers[viewControllers.count - 1] == self) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)rightButtonAction:(UIButton *)sender
{
    NSLog(@"右键事件");
    [self doRightNavBarRightBtnAction];
}

- (void)accountBeKickedAction:(NSNotification *)note
{
    [self doAccountBeKicked];
}

#pragma mark -- 属性
- (UITapGestureRecognizer *)tap
{
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        _tap.cancelsTouchesInView = YES;
    }
    return _tap;
}

- (UIButton *)leftButton
{
    if (!_leftButton)
    {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        if (self.leftBtnTitleColor) {
            [_leftButton setTitleColor:self.leftBtnTitleColor forState:UIControlStateNormal];
        }else {
//            [_leftButton setTitleColor:UIColorFromRGB(0X238EFA) forState:UIControlStateNormal];
        }
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _leftButton.frame = CGRectMake(0, 0, 20, 40.0);
        [_leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightButton
{
    if (!_rightButton)
    {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        _rightButton.frame = CGRectMake(0, 0, 44, 40.0);
        
        [_rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (void)setLeftBtnTitle:(NSString *)leftBtnTitle
{
    _leftBtnTitle = leftBtnTitle;
    
    [_leftButton setTitle:leftBtnTitle forState:UIControlStateNormal];
}

- (void)setLeftBtnImage:(NSString *)leftBtnImage
{
    _leftBtnImage = leftBtnImage;
    [_leftButton setImage:[UIImage imageNamed:leftBtnImage] forState:UIControlStateNormal];
}

- (void)setRightBtnTitle:(NSString *)rightBtnTitle
{
    _rightBtnTitle = rightBtnTitle;
    [_rightButton setTitle:rightBtnTitle forState:UIControlStateNormal];
}

- (void)setRightBtnImage:(NSString *)rightBtnImage
{
    _rightBtnImage = rightBtnImage;
    
    [_rightButton setImage:[UIImage imageNamed:rightBtnImage] forState:UIControlStateNormal];
}

- (void)setHiddenLeftBtn:(BOOL)hiddenLeftBtn
{
    _hiddenLeftBtn = hiddenLeftBtn;
    
    _leftButton.hidden = hiddenLeftBtn;
    
    _leftButton.userInteractionEnabled = !hiddenLeftBtn;
}

- (void)setHiddenRightBtn:(BOOL)hiddenRightBtn
{
    _hiddenRightBtn = hiddenRightBtn;
    
    _rightButton.hidden = hiddenRightBtn;
}


#pragma mark - 代理
#pragma mark - <UITextFieldDelegate>
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)doAccountBeKicked
{
    UINavigationController *rootVC = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    if (rootVC.presentedViewController) {
        [rootVC.presentedViewController dismissViewControllerAnimated:YES completion:^{
            [rootVC popToRootViewControllerAnimated:YES];
        }];
    }
    else
    {
        [rootVC popToRootViewControllerAnimated:YES];
    }
};

- (void)doRightNavBarRightBtnAction
{
    
};


@end
