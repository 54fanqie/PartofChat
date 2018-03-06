//
//  CALayer+XibConfiguration.m
//  Part of Chat
//
//  Created by macmini2 on 16/7/13.
//  Copyright © 2016年 emiage. All rights reserved.
//

#import "CALayer+XibConfiguration.h"

@implementation CALayer (XibConfiguration)

- (void)setBorderColorWithUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}
@end
