//
//  UINavigationController+Animation.m
//  EMPian
//
//  Created by EMIAGE EMIAGE on 13-7-22.
//  Copyright (c) 2013年 com. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "UINavigationController+Animation.h"

#define TransitionDuration 0.5

@implementation UINavigationController (Animation)

- (void)pushViewController:(UIViewController *)viewController transitionType:(TransitionType)transitionType
{
    CATransition *animation = [CATransition animation];
    animation.duration = TransitionDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    animation.type = [self transitionType:transitionType];
    animation.subtype = kCATransitionFromBottom;
    
    [self.view.layer addAnimation:animation forKey:nil];
    [self pushViewController:viewController animated:NO];
}

- (void)popViewControllerWithtransitionType:(TransitionType)transitionType
{
    CATransition *animation = [CATransition animation];
    animation.duration = TransitionDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    animation.type = [self transitionType:transitionType];
    animation.subtype = kCATransitionFromBottom;
    
    [self.view.layer addAnimation:animation forKey:nil];
    [self popViewControllerAnimated:NO];
}

- (NSString *)transitionType:(TransitionType)transitionType
{
    switch (transitionType) {
        case TransitionFade:
            return kCATransitionFade;
        case TransitionMoveIn:
            return kCATransitionMoveIn;
        case TransitionPush:
            return kCATransitionPush;
        case TransitionReveal:
            return kCATransitionReveal;
        case TransitionPageCurl:
            return @"pageCurl";
        case TransitionPageUnCurl:
            return @"pageUnCurl";
        case TransitionRippleEffect:
            return @"rippleEffect";
        case TransitionSuckEffect:
            return @"suckEffect";
        case TransitionCube:
            return @"cube";
        case TransitionOglFlip:
            return @"oglFlip";
        default:
            return kCATransitionPush;
    }
}

@end
