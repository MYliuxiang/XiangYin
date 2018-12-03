//
//  BaseViewController.h
//  Familysystem
//
//  Created by 李立 on 15/8/21.
//  Copyright (c) 2015年 LILI. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, BarItemAlignment) {
    BarItemAlignment_Left,
    BarItemAlignment_Right,
};

@interface BaseViewController : UIViewController



/**
 设置标题

 @param title 标题
 @param titleColor 标题颜色 为nil时 默认白色
 */
- (void)set_title:(NSString *)title
       titleColor:(UIColor *)titleColor;


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
     contentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment;




/**
 点击返回按钮的方法
 */
- (void)back;


/**
 添加无网提示
 */
- (BOOL)add_NetWorkStateTypeNoconnect;

/**
 添加没有数据提示

 @param imagaName 默认图片
 @param defaultString 默认文字
 */
- (void)add_no_data_default_image:(NSString *)imagaName defaultString:(NSString *)defaultString;


/**
 移除没有数据显示
 */
- (void)remove_no_data_default;


/**
 网络改变通知

 @param noti 通知
 */
- (void)YZYnetWorkStateChange:(NSNotification *)noti;



@end
