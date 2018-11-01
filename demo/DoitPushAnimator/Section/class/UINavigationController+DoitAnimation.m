//
//  UINavigationController+DoitAnimation.m
//  DoitPushAnimator
//
//  Created by 罗泰 on 2018/10/31.
//  Copyright © 2018 chenwang. All rights reserved.
//

#import "UINavigationController+DoitAnimation.h"
#import "CWDoitAnimatorManager.h"

@implementation UINavigationController (DoitAnimation)
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated doit:(BOOL)doit rect:(CGRect)rect {
    if (animated && doit)
    {
        static CWDoitAnimatorManager *manager = nil;
        if (!manager)
            manager = [[CWDoitAnimatorManager alloc] init];
        manager.originRect = rect;
        self.delegate = manager;
    }
    else
    {
        self.delegate = nil;
    }
    [self pushViewController:viewController animated:animated];
}


@end
