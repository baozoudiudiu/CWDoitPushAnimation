//
//  CWDoitAnimatorManager.m
//  DoitPushAnimator
//
//  Created by 罗泰 on 2018/10/31.
//  Copyright © 2018 chenwang. All rights reserved.
//

#import "CWDoitAnimatorManager.h"
@implementation CWDoitAnimatorManager

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if(operation == UINavigationControllerOperationPush)
    {
        return [[CWDoitAnimator alloc] initWithType:CWDoitAnimatorTypePush manager:self];
    }
    else if(operation == UINavigationControllerOperationPop)
    {
        return [[CWDoitAnimator alloc] initWithType:CWDoitAnimatorTypePop manager:self];
    }
    return nil;
}


- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end



@implementation CWDoitAnimator
- (instancetype)initWithType:(CWDoitAnimatorType)type manager:(CWDoitAnimatorManager *)manager {
    if(self = [super init])
    {
        self.animationDuring = 0.45f;
        _type = type;
        _manager = manager;
    }
    return self;
}


- (void)dealloc {
    NSLog(@"%s", __func__);
}


- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = [transitionContext containerView];
    switch(self.type)
    {
        case CWDoitAnimatorTypePush:
        {
            [self pushAnimationWithFromVC:fromVC
                                 fromView:fromView
                                     toVC:toVC
                                   toView:toView
                            containerView:containerView
                                  context:transitionContext];
        }
            break;
        case CWDoitAnimatorTypePop:
        {
            [self popAnimationWithFromVC:fromVC
                                fromView:fromView
                                    toVC:toVC
                                  toView:toView
                           containerView:containerView
                                 context:transitionContext];
        }
            break;
        default:break;
    }
}


- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return self.animationDuring;
}


- (void)pushAnimationWithFromVC:(UIViewController *)fromVC fromView:(UIView *)fromView toVC:(UIViewController *)toVC toView:(UIView *)toView containerView:(UIView *)containerView context:(id<UIViewControllerContextTransitioning>)context {
    [self AnimationWithFromVC:fromVC fromView:fromView toVC:toVC toView:toView containerView:containerView context:context];
}


- (void)popAnimationWithFromVC:(UIViewController *)fromVC fromView:(UIView *)fromView toVC:(UIViewController *)toVC toView:(UIView *)toView containerView:(UIView *)containerView context:(id<UIViewControllerContextTransitioning>)context {
    [self AnimationWithFromVC:fromVC fromView:fromView toVC:toVC toView:toView containerView:containerView context:context];
}


- (void)AnimationWithFromVC:(UIViewController *)fromVC fromView:(UIView *)fromView toVC:(UIViewController *)toVC toView:(UIView *)toView containerView:(UIView *)containerView context:(id<UIViewControllerContextTransitioning>)context {
    
    _context = context;
    [containerView addSubview:toView];
    UIView *animationView = self.type == CWDoitAnimatorTypePush ? toView : fromView;
    [containerView bringSubviewToFront:animationView];
    CGPoint center = CGPointMake(self.manager.originRect.origin.x + CGRectGetWidth(self.manager.originRect) * 0.5,
                                 self.manager.originRect.origin.y + CGRectGetHeight(self.manager.originRect) * 0.5);
    UIBezierPath *bPath = [UIBezierPath bezierPathWithArcCenter:center
                                                         radius:CGRectGetWidth(self.manager.originRect) * 0.5
                                                     startAngle:0
                                                       endAngle:M_PI * 2
                                                      clockwise:YES];
    UIBezierPath *bPath2 = [UIBezierPath bezierPathWithArcCenter:center
                                                          radius:[self maxRadius:center frame:animationView.frame]
                                                      startAngle:0
                                                        endAngle:M_PI * 2
                                                       clockwise:YES];
    [self addAnimation:bPath targetPath:bPath2 animationView:animationView];
}


- (void)addAnimation:(UIBezierPath *)originPath targetPath:(UIBezierPath *)targetPath animationView:(UIView *)animationView {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    self.shapeLayer = shapeLayer;
    CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    baseAnimation.duration = self.animationDuring;
    baseAnimation.delegate = self;
    baseAnimation.removedOnCompletion = NO;
    baseAnimation.fillMode = kCAFillModeForwards;
    if(self.type == CWDoitAnimatorTypePush)
    {
        baseAnimation.fromValue = (__bridge id)(originPath.CGPath);
        baseAnimation.toValue = (__bridge id)(targetPath.CGPath);
    }
    else
    {
        baseAnimation.toValue = (__bridge id)(originPath.CGPath);
        baseAnimation.fromValue = (__bridge id)(targetPath.CGPath);
    }
    [animationView.layer setMask:shapeLayer];
    [shapeLayer addAnimation:baseAnimation forKey:@"pushAnimation"];
}


- (CGFloat)maxRadius:(CGPoint)center frame:(CGRect)frame {
    CGFloat HSpace = CGRectGetWidth(frame) - center.x;
    CGFloat VSpace = CGRectGetHeight(frame) - center.y;
    return sqrt(pow(MAX(HSpace, center.x), 2) + pow(MAX(center.y, VSpace), 2));
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if(flag)
    {
        [[self.context viewControllerForKey:UITransitionContextToViewControllerKey].view.layer setMask:nil];
        [[self.context viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer setMask:nil];
        [self.context completeTransition:![self.context transitionWasCancelled]];
        [self.shapeLayer removeAllAnimations];
        if([self.context transitionWasCancelled])
        {
            [[self.context viewForKey:UITransitionContextFromViewKey] removeFromSuperview];
            [[self.context viewForKey:UITransitionContextToViewKey] removeFromSuperview];
        }
    }
}
@end
