//
//  ReleasePhotoVC.m
//  XiangYin
//
//  Created by liuxiang on 2018/12/4.
//  Copyright © 2018年 liuxiang. All rights reserved.
//

#import "ReleasePhotoVC.h"

@interface ReleasePhotoVC ()

@end

@implementation ReleasePhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"发布图片";
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
