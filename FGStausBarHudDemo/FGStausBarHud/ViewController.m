//
//  ViewController.m
//  FGStausBarHud
//
//  Created by hsf on 2018/4/6.
//  Copyright © 2018年 衡申发. All rights reserved.
//

#import "ViewController.h"
#import "FGStatusBarHud.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)showWord:(id)sender {
    [FGStatusBarHud showMessage:@"可以哦，不错"];
}

- (IBAction)hide:(id)sender {
    [FGStatusBarHud hide];
}

- (IBAction)showSuccess:(id)sender {
    [FGStatusBarHud showSuccess:@"成功啦"];
}


- (IBAction)showError:(id)sender {
    [FGStatusBarHud showError:@"加载失败"];
}

- (IBAction)showLoading:(id)sender {
    [FGStatusBarHud showLoading:@"正在加载中"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}



@end
