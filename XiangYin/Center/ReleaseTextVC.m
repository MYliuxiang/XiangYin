//
//  ReleaseTextVC.m
//  XiangYin
//
//  Created by liuxiang on 2018/12/4.
//  Copyright © 2018年 liuxiang. All rights reserved.
//

#import "ReleaseTextVC.h"

@interface ReleaseTextVC ()

@end

@implementation ReleaseTextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"发布文字";
    self.hiddenLeftBtn = NO;
}
- (void)back
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
