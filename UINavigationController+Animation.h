//
//  UINavigationController+Animation.h
//  EMPian
//
//  Created by EMIAGE EMIAGE on 13-7-22.
//  Copyright (c) 2013年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    TransitionFade,
    TransitionMoveIn,
    TransitionPush,
    TransitionReveal,
    TransitionPageCurl,
    TransitionPageUnCurl,
    TransitionRippleEffect,
    TransitionSuckEffect,
    TransitionCube,
    TransitionOglFlip             

}TransitionType;

@interface UINavigationController (Animation)

- (void)pushViewController:(UIViewController *)viewController transitionType:(TransitionType)transitionType;

- (void)popViewControllerWithtransitionType:(TransitionType)transitionType;

@end
