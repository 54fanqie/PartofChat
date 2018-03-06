//
//  UIChatImageCell.h
//  Part of Chat
//
//  Created by macmini2 on 16/9/19.
//  Copyright © 2016年 emiage. All rights reserved.
//


#import "UIChatBaseCell.h"
#import "SharpImageView.h"

@interface UIChatImageCell : UIChatBaseCell
@property (weak, nonatomic) IBOutlet UIImageView * otherHeadImageIV;
@property (weak, nonatomic) IBOutlet UILabel *personName;
@property (weak, nonatomic) IBOutlet SharpImageView *leftMessageImage;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLayoutImageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLayoutImageWidth;



@property (weak, nonatomic) IBOutlet UIImageView * myHeadImageIV;
@property (weak, nonatomic) IBOutlet SharpImageView *rightMessageImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutTopHeight;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightLayoutImageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightLayoutImageWidth;
+ (CGSize)imageViewSizeWithImage:(UIImage *)image;
@end
