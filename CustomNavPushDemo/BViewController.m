//
//  BViewController.m
//  CustomNavPushDemo
//
//  Created by 马祥忠 on 2018/7/26.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import "BViewController.h"

@interface BViewController ()

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    self.title = @"BViewController";

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (MGPopAnimationStyle)popStyle{
    return MGPopAnimationStyleFullToCenter;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
