//
//  BaseViewController.m
//  CustomNavPushDemo
//
//  Created by 马祥忠 on 2018/7/26.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import "BaseViewController.h"
#import "MGNavigationController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setNavPushAndPopStyle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setNavPushAndPopStyle{
    MGNavigationController *nav = (MGNavigationController *)[self currentNC];
    nav.pushStyle = [self pushStyle];
    nav.popStyle = [self popStyle];
}

- (MGPushAnimationStyle)pushStyle{
    return MGPushAnimationStyleDefault;
}

- (MGPopAnimationStyle)popStyle{
    return MGPopAnimationStyleDefault;
}

- (UINavigationController *)currentNC
{
    if (![[UIApplication sharedApplication].windows.lastObject isKindOfClass:[UIWindow class]]) {
        NSAssert(0, @"未获取到导航控制器");
        return nil;
    }
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self getCurrentNCFrom:rootViewController];
}

//递归
- (UINavigationController *)getCurrentNCFrom:(UIViewController *)vc
{
    if ([vc isKindOfClass:[UITabBarController class]]) {
        UINavigationController *nc = ((UITabBarController *)vc).selectedViewController;
        return [self getCurrentNCFrom:nc];
    }
    else if ([vc isKindOfClass:[UINavigationController class]]) {
        if (((UINavigationController *)vc).presentedViewController) {
            return [self getCurrentNCFrom:((UINavigationController *)vc).presentedViewController];
        }
        return [self getCurrentNCFrom:((UINavigationController *)vc).topViewController];
    }
    else if ([vc isKindOfClass:[UIViewController class]]) {
        if (vc.presentedViewController) {
            return [self getCurrentNCFrom:vc.presentedViewController];
        }
        else {
            return vc.navigationController;
        }
    }
    else {
        NSAssert(0, @"未获取到导航控制器");
        return nil;
    }
}


@end
