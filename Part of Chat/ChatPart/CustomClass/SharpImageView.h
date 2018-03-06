//
//  SharpImageView.h
//  不规则图片
//
//  Created by macmini2 on 16/9/18.
//  Copyright © 2016年 emiage. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    DirectionLeft,
    DirectionRight,
}AngleDirectionType;

@interface SharpImageView : UIImageView
-(void)setSharpCornerImage:(UIImage *)image with:(AngleDirectionType)angleDirectionType;
@end
