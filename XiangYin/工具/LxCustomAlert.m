//
//  LxCustomAlert.m
//  BiDui
//
//  Created by 刘翔 on 2018/5/26.
//  Copyright © 2018年 刘翔. All rights reserved.
//

#import "LxCustomAlert.h"

@implementation LxCustomAlert

- (instancetype)init
{
    self = [super init];
    if (self) {
        
         self  = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
       
        
    }
    return self;
}

#pragma mark UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    //如果是子视图 self.edittingArea ，设置无法接受 父视图_collectionView 的长按事件。
    
//    if(CGRectContainsPoint(_maskView.frame, [touch locationInView:self])) {
//        return NO;
//    } else{
//
//        return YES;
//    };
    if ([touch.view isDescendantOfView:self]) {
        return NO;
    }
  
    return YES;
}

- (void)show{
    
   
    if(self.topVC){
        
        [self.topVC.view addSubview:_maskView];
        
    }else{
        
        [[self topView] addSubview:_maskView];
    }
    [_maskView addSubview:self];
    [self showAnimation];
    
    UITapGestureRecognizer *misstap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(misstap)];
    misstap.delegate = self;
    [_maskView addGestureRecognizer:misstap];
    
}

-(UIView*)topView{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    return  window.subviews[0];
}

- (void)disMiss
{
    [self hideAnimation];
    
}

- (void)misstap
{
    [self disMiss];
}

- (void)showAnimation {
    
    if (_type == LxCustomAlertTypeAlert) {
        self.center = _maskView.center;
        CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        popAnimation.duration             = 1;
        popAnimation.values               = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05f, 1.05f, 1.0)],
                                              [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95f, 0.95f, 1.0f)],
                                              [NSValue valueWithCATransform3D:CATransform3DIdentity]];
        popAnimation.keyTimes             = @[@0.2f, @0.5f, @0.75f, @1.0f];
        popAnimation.timingFunctions      = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                              [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                              [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.layer addAnimation:popAnimation forKey:nil];
    }else{
        
        self.top = _maskView.bottom;
        [UIView animateWithDuration:.35 animations:^{
            self.bottom = _maskView.bottom;
        }];
    }
   
}

- (void)hideAnimation{
    
    if (_type == LxCustomAlertTypeAlert) {
        [UIView animateWithDuration:0.4 animations:^{
            self.alpha = 0.0;
            _maskView.alpha = 0;
        } completion:^(BOOL finished) {
            
            [_maskView removeFromSuperview];
        }];
    }else{
        
        [UIView animateWithDuration:0.35 animations:^{
            self.top = _maskView.bottom;
            _maskView.alpha = 0;
            
        } completion:^(BOOL finished) {
            [_maskView removeFromSuperview];
        }];
    }
    
}

@end





