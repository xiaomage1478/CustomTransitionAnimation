//
//  MGPushAnimation.m
//  CustomNavPushDemo
//
//  Created by 马祥忠 on 2018/7/26.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import "MGPushAnimation.h"

@implementation MGPushAnimation

- (void)setStyle:(MGPushAnimationStyle)style{
    _style = style;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.4;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView* toView = nil;
    UIView* fromView = nil;
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    
    [[transitionContext containerView] addSubview:toView];
    [self pushAnimation:toView withTransitionContext:transitionContext];
    
}


- (void)pushAnimation:(UIView *)toView withTransitionContext:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGRect endRect;
    switch (self.style) {
            
        case MGPushAnimationStyleDefault:
            toView.frame = CGRectMake(0, width, width, height);
            endRect = CGRectMake(0, 0, width, height);
            break;
            
        case MGPushAnimationStylePresent:
            toView.frame = CGRectMake(0, height, width, height);
            endRect = CGRectMake(0, 0, width, height);
            break;
            
        case MGPushAnimationStyleTopToBottom:
            toView.frame = CGRectMake(0, -height, width, height);
            endRect = CGRectMake(0, 0, width, height);
            break;
            
        case MGPushAnimationStyleCenterToFull:
            toView.frame = CGRectMake(width/2, height/2, 0, 0);
            endRect = CGRectMake(0, 0, width, height);
            break;
            
        default:
            toView.frame = CGRectMake(0, width, width, height);
            endRect = CGRectMake(0, 0, width, height);
            break;
    }
    
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.frame = endRect;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}
@end

#pragma mark ------------------pop---------------------

@implementation MGPopAnimation

- (void)setStyle:(MGPopAnimationStyle)style{
    _style = style;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView* toView = nil;
    UIView* fromView = nil;
    
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    
    [[transitionContext containerView] insertSubview:toView belowSubview:fromView];
    
    [self popAnimation:fromView withTransitionContext:transitionContext];
}


- (void)popAnimation:(UIView *)fromView withTransitionContext:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    fromView.frame = CGRectMake(0, 0, width, height);
    CGRect endRect;
    switch (self.style) {
            
        case MGPopAnimationStyleDefault:
            endRect = CGRectMake(width, 0, width, height);
            break;
            
        case MGPopAnimationStyleDismiss:
            endRect = CGRectMake(0, height, width, height);
            break;
            
        case MGPopAnimationStyleBottomToTop:
            endRect = CGRectMake(0, -height, width, height);
            break;
            
        case MGPopAnimationStyleFullToCenter:
            endRect = CGRectMake(width/2, height/2, 0, 0);
            break;
            
        default:
            endRect = CGRectMake(width, 0, width, height);
            break;
    }
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.frame = endRect;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
