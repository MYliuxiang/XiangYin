//
//  MainTabBarController.h
//  MyMovie
//
//  Created by zsm on 14-8-15.
//  Copyright (c) 2014年 zsm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AxcAE_TabBar/AxcAE_TabBar.h>
#import "HyPopMenuView.h"
#import "ReleaseTextVC.h"
#import "ReleasePhotoVC.h"
#import "ReleaseVideoVC.h"

@interface MainTabBarController : UITabBarController

@property (nonatomic, strong) AxcAE_TabBar *axcTabBar;

//单例方法
+ (instancetype)shareMainTabBarController;


@end
