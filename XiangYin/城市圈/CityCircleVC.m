//
//  CityCircleVC.m
//  XiangYin
//
//  Created by liuxiang on 2018/11/30.
//  Copyright © 2018年 liuxiang. All rights reserved.
//

#import "CityCircleVC.h"
#import "SWCommentList.h"

@interface CityCircleVC ()

@property(nonatomic,strong) SWCommentList *commentView;
@end

@implementation CityCircleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.title = @"城市圈";
    self.navigationItem.title = @"城市圈";
  
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
