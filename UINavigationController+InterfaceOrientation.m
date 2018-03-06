//
//  UINavigationController+InterfaceOrientation.m
//  EMiPian
//
//  Created by EMIAGE EMIAGE on 13- 5- 18.
//  Copyright (c) 2013年 emiage. All rights reserved.
//

#import "UINavigationController+InterfaceOrientation.h"

@implementation UINavigationController (InterfaceOrientation)

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return self.topViewController.supportedInterfaceOrientations;
}

- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}

@end
