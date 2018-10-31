//
//  UINavigationController+DoitAnimation.h
//  DoitPushAnimator
//
//  Created by 罗泰 on 2018/10/31.
//  Copyright © 2018 chenwang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (DoitAnimation)

/**
 自定义push方法
 当doit为NO时,等效-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated

 @param viewController 目标vc
 @param animated 是否执行动画
 @param doit YES: 自定义转场动画 NO: 系统自带动画
 @param rect 当doit为YES时,动画开始的起点frame
 */
- (void)pushViewController:(UIViewController *)viewController
                  animated:(BOOL)animated
                      doit:(BOOL)doit
                      rect:(CGRect)rect;
@end

NS_ASSUME_NONNULL_END
