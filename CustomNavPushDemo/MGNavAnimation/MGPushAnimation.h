//
//  MGPushAnimation.h
//  CustomNavPushDemo
//
//  Created by 马祥忠 on 2018/7/26.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MGPushAnimationStyleDefault = 0,//正常push
    MGPushAnimationStylePresent,//仿模态push
    MGPushAnimationStyleTopToBottom,//从上到下
    MGPushAnimationStyleCenterToFull,//中心扩散展开
} MGPushAnimationStyle;/** push动画类型 */

typedef enum : NSUInteger {
    MGPopAnimationStyleDefault = 0,//正常pop
    MGPopAnimationStyleDismiss,//仿模态dismiss
    MGPopAnimationStyleBottomToTop,//从下到上
    MGPopAnimationStyleFullToCenter,//全屏缩放到中心点
} MGPopAnimationStyle;/** pop动画类型 */

//MARK:push动画

@interface MGPushAnimation : NSObject<UIViewControllerAnimatedTransitioning>

/** 动画类型 */
@property(nonatomic,assign) MGPushAnimationStyle style;

@end

//MARK:pop动画

@interface MGPopAnimation :NSObject <UIViewControllerAnimatedTransitioning>

/** 动画类型 */
@property(nonatomic,assign) MGPopAnimationStyle style;

@end
