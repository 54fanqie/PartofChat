//
//  UIColor+Hex.h
//  Part of Chat
//
//  Created by macmini2 on 16/7/7.
//  Copyright © 2016年 emiage. All rights reserved.
//

#import <UIKit/UIKit.h>

#define  UIColorRGB(R,G,B,A)   [UIColor colorWithRed:((R)/255.0f) green:((G)/255.0f) blue:((B/255.0f)) alpha:A]
#define  UIColorHex(rgbValue)  [UIColor colorWithHexString:rgbValue]

@interface UIColor (Hex)
+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end
