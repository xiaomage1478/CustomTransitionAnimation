//
//  AViewController.m
//  CustomNavPushDemo
//
//  Created by 马祥忠 on 2018/7/26.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import "AViewController.h"

@interface AViewController ()

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"AViewController";

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.navigationController pushViewController:[[NSClassFromString(@"BViewController") alloc]init] animated:YES];
}

- (MGPushAnimationStyle)pushStyle{
    return MGPushAnimationStylePresent;
}
- (MGPopAnimationStyle)popStyle{
    return MGPopAnimationStyleFullToCenter;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
