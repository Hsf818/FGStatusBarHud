//
//  FGStatusBarHud.m
//  FGStausBarHud
//
//  Created by hsf on 2018/4/6.
//  Copyright © 2018年 衡申发. All rights reserved.
//

#import "FGStatusBarHud.h"

@implementation FGStatusBarHud

/** 全局的窗口 */
static UIWindow *window_;
/** 定时器 */
static NSTimer *timer_;

+ (void)showWindow{
    
    // frame数据
    CGFloat windowH = 20;
    CGRect frame = CGRectMake(0, - windowH, [UIScreen mainScreen].bounds.size.width, windowH);
    
    // 显示窗口
    window_.hidden = YES;
    window_ = [[UIWindow alloc] init];
    window_.backgroundColor = [UIColor blackColor];
    window_.windowLevel = UIWindowLevelAlert;
    window_.frame = frame;
    window_.hidden = NO;
    
    // 动画
    frame.origin.y = 0;
    [UIView animateWithDuration:0.25 animations:^{
        window_.frame = frame;
    }];
}

/**
 * 显示普通信息
 * @param msg       文字
 * @param image     图片
 */

+ (void)showMessage:(NSString *)msg image:(UIImage *)image{
    // 关闭定时器
    [timer_ invalidate];
    [self showWindow];
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:msg forState:UIControlStateNormal];
    btn.frame = window_.bounds;
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    if(image){
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        [btn setImage:image forState:UIControlStateNormal];
    }
    
    [window_ addSubview:btn];
    
    // 开启定时器
    timer_ = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(hide) userInfo:nil repeats:NO];
}
/**
 * 显示普通信息
 */
+ (void)showMessage:(NSString *)msg{
    [self showMessage:msg image:nil];
}
/**
 * 显示成功信息
 */
+ (void)showSuccess:(NSString *)msg{
    [self showMessage:msg image:[UIImage imageNamed:@"FGStatusBarHud.bundle/success"]];
}

/**
 * 显示失败信息
 */
+ (void)showError:(NSString *)msg{
    [self showMessage:msg image:[UIImage imageNamed:@"FGStatusBarHud.bundle/error"]];
}
/**
 * 显示正在处理的信息
 */
+ (void)showLoading:(NSString *)msg{
    // 关闭定时器
    [timer_ invalidate];
    timer_ = nil;
    
    [self showWindow];
    
    // 添加文字
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    label.frame = window_.bounds;
    label.text = msg;
    label.textAlignment = NSTextAlignmentCenter;
    [window_ addSubview:label];
    
    // 添加菊花
    UIActivityIndicatorView *loadView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [loadView startAnimating];
    CGFloat msgW = [msg sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}].width;
    CGFloat centerX = ([UIScreen mainScreen].bounds.size.width - msgW)* 0.5 - 20;
    CGFloat centerY = window_.bounds.size.height * 0.5;
    loadView.center = CGPointMake(centerX, centerY);
    [window_ addSubview:loadView];
    // 开启定时器
    timer_ = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(hide) userInfo:nil repeats:NO];
    
}
/**
 * 隐藏
 */
+ (void)hide{
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = window_.frame;
        frame.origin.y = - frame.size.height;
        window_.frame = frame;
    } completion:^(BOOL finished) {
        window_ = nil;
        timer_ = nil;
    }];
    
}
@end
