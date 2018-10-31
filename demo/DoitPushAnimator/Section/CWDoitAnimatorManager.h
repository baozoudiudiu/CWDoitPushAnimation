//
//  CWDoitAnimatorManager.h
//  DoitPushAnimator
//
//  Created by 罗泰 on 2018/10/31.
//  Copyright © 2018 chenwang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CWDoitAnimatorType) {
    CWDoitAnimatorTypePush = 0,
    CWDoitAnimatorTypePop,
};

NS_ASSUME_NONNULL_BEGIN
@interface CWDoitAnimatorManager : NSObject<UINavigationControllerDelegate>
@property (nonatomic, assign) CGRect                    originRect;
@end


@interface CWDoitAnimator : NSObject<UIViewControllerAnimatedTransitioning, CAAnimationDelegate>
@property (nonatomic, assign) NSTimeInterval                    animationDuring;
@property (nonatomic, assign, readonly) CWDoitAnimatorType      type;
@property (nonatomic, weak, readonly) CWDoitAnimatorManager     *manager;
@property (nonatomic, weak, readonly) id<UIViewControllerContextTransitioning> context;
@property (nonatomic, strong) CAShapeLayer                      *shapeLayer;
- (instancetype)initWithType:(CWDoitAnimatorType)type manager:(CWDoitAnimatorManager *)manager;
@end
NS_ASSUME_NONNULL_END
