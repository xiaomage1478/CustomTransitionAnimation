//
//  BaseViewController.h
//  CustomNavPushDemo
//
//  Created by 马祥忠 on 2018/7/26.
//  Copyright © 2018年 小马哥. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGPushAnimation.h"

@interface BaseViewController : UIViewController

//子类重写设置push动画
- (MGPushAnimationStyle)pushStyle;

//子类重写设置pop动画
- (MGPopAnimationStyle)popStyle;

@end
