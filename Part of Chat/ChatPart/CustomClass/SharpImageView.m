//
//  SharpImageView.m
//  不规则图片
//
//  Created by macmini2 on 16/9/18.
//  Copyright © 2016年 emiage. All rights reserved.
//

#import "SharpImageView.h"

@implementation SharpImageView
-(void)setSharpCornerImage:(UIImage *)image with:(AngleDirectionType)angleDirectionType{
    //三角形距离最上部的位置
    CGFloat y=20;
    //正三角的的边长
    CGFloat triangle=6;
    //圆角半径
    CGFloat  radiansAngle =5;
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, [UIScreen mainScreen].scale);
    //1.获取bitmap上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path1 = CGPathCreateMutable();
    
    
    if (angleDirectionType == DirectionRight) {
        CGPathMoveToPoint(path1, NULL, 0, radiansAngle);
        CGPathAddArc(path1, NULL, radiansAngle, radiansAngle, radiansAngle, M_PI, M_PI*3/2, NO);
        CGPathAddLineToPoint(path1, NULL, width-triangle-radiansAngle, 0);
        CGPathAddArc(path1, NULL, width-triangle-radiansAngle, radiansAngle, radiansAngle,  M_PI*3/2,0, NO);
        CGPathAddLineToPoint(path1, NULL, width-triangle, y);
        CGPathAddLineToPoint(path1, NULL, width,y+triangle);
        CGPathAddLineToPoint(path1, NULL, width-triangle,y+triangle*2);
        CGPathAddLineToPoint(path1, NULL, width-triangle,height-radiansAngle);
        CGPathAddArc(path1, NULL, width-triangle-radiansAngle, height-radiansAngle, radiansAngle, 0 ,M_PI/2, NO);
        CGPathAddLineToPoint(path1, NULL, radiansAngle,height);
        CGPathAddArc(path1, NULL,radiansAngle, height-radiansAngle, radiansAngle,M_PI/2, M_PI , NO);
        
        CGPathAddLineToPoint(path1, NULL, 0,height-radiansAngle);
    }else{
        y=y-radiansAngle;
        CGPathMoveToPoint(path1, NULL,triangle, radiansAngle);
        CGPathAddArc(path1, NULL, radiansAngle + triangle, radiansAngle, radiansAngle, M_PI, M_PI*3/2, NO);
        CGPathAddLineToPoint(path1, NULL, width-radiansAngle, 0);
        CGPathAddArc(path1, NULL, width-radiansAngle, radiansAngle, radiansAngle,  M_PI*3/2,0, NO);
        CGPathAddLineToPoint(path1, NULL, width,height-radiansAngle);
        CGPathAddArc(path1, NULL, width-radiansAngle, height-radiansAngle, radiansAngle, 0 ,M_PI/2, NO);
        CGPathAddLineToPoint(path1, NULL, triangle+radiansAngle,height);
        CGPathAddArc(path1, NULL,radiansAngle + triangle, height-radiansAngle, radiansAngle,M_PI/2, M_PI , NO);
        
        CGPathAddLineToPoint(path1, NULL,triangle,y+triangle*2+radiansAngle);
        
        CGPathAddLineToPoint(path1, NULL, 0,y+triangle+radiansAngle);
        CGPathAddLineToPoint(path1, NULL, triangle,y+radiansAngle);
        
    }
    
    
    CGContextAddPath(context, path1);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextSetLineWidth(context, 1);
    CGPathRelease(path1);
    [image drawInRect:CGRectMake(0, 0, width, height)];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.image = result;
    
}

@end
