//
//  MGNavigationController.m
//  CustomNavPushDemo
//
//  Created by 马祥忠 on 2018/7/26.
//  Copyright © 2018年 小马哥. All rights reserved.
//


#import "MGNavigationController.h"


@interface MGNavigationController ()


/** push动画类 */
@property (nonatomic, strong) MGPushAnimation *pushAnimation;

/** pop动画类 */
@property (nonatomic, strong) MGPopAnimation *popAnimation;

@end

@implementation MGNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
    self.pushAnimation = [MGPushAnimation new];
    self.pushAnimation.style = MGPushAnimationStyleDefault;
    
    self.popAnimation = [MGPopAnimation new];
    self.popAnimation.style = MGPopAnimationStyleDefault;


}

- (void)setPushStyle:(MGPushAnimationStyle)pushStyle{
    _pushStyle = pushStyle;
    self.pushAnimation.style = _pushStyle;
}

- (void)setPopStyle:(MGPopAnimationStyle)popStyle{
    _popStyle = popStyle;
    self.popAnimation.style = _popStyle;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPush) {
        
        return self.pushAnimation;
    }
    else if (operation == UINavigationControllerOperationPop){

        return self.popAnimation;
    }
    return nil;
}


@end
