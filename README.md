# CustomTransitionAnimation
iOS 自定义转场动画（push ，pop 的自定义）

## 前言:
 之前有一个需求是 A push B, B present C , C pop A,顿时想骂街,这是什么鬼需求!!!但是没办法需求大于天.尝试了N多办法均已失败告终,后来接触到了自定义转场动画,所谓的'present(模态)'不就是个形态问题,只要动画效果达到就OK,我把push的动画改成present的动画问题不就迎刃而解了嘛,顿时想抽自己两个大嘴巴子.所以我们大多数问题都是陷入了思维死角,换个思路问题其实都很简单.废话不多说了,开搞!!!

### 第一步:了解 UIViewControllerAnimatedTransitioning协议

   UIViewControllerAnimatedTransitioning协议是苹果爸爸提供给我们实现转场动画的
   下面两个接口是必须实现的,也是实现转场动画的核心接口
 ````   
 // 这个接口返回的值为动画时长
 // This is used for percent driven interactive transitions, as well as for
 // container controllers that have companion animations that might need to
 // synchronize with the main animation.
 - (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext;
 // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
 // 这个接口返回的值为具体动画内容,也就是说,自定义的动画操作都通过这个接口来实现
 - (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext;  
````
### 第二步:实现具体动画
   首先我们先创建一个类(MGPushAnimation)实现UIViewControllerAnimatedTransitioning协议,实现两个核心方法
````
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

````
这里只展示了push动画的实现代码,pop同理.这样我们就完成了转场动画的代码实现,要实现动画还需要最后一步,遵守UINavigationControllerDelegate
### 第三步:实现UINavigationControllerDelegate协议 
   我们定义完了MGPushAnimation,但是具体是在哪里用呢,接下来UINavigationControllerDelegate就闪亮登场了.下面这个方法是在导航push或者pop动画时运行的.
   
   ````
   - (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
   animationControllerForOperation:(UINavigationControllerOperation)operation
   fromViewController:(UIViewController *)fromVC
   toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0);
````
所以我们只需在这个方法里实现相关代码即可
````
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
````

这里我是在自定义的导航控制器(MGNavigationController)里实现的,但是我们要控制具体的每个控制器(*ViewController)的动画方式,这里我是用到了BaseViewController ,头文件了暴露了设置方法,我们只需要在具体的控制器重写这两个方法来设置各自的转场动画即可.具体的代码可参考demo
````
@interface BaseViewController : UIViewController

//子类重写设置push动画
- (MGPushAnimationStyle)pushStyle;

//子类重写设置pop动画
- (MGPopAnimationStyle)popStyle;

@end

````

