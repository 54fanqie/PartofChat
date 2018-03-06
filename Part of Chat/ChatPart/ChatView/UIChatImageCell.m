//
//  UIChatImageCell.m
//  Part of Chat
//
//  Created by macmini2 on 16/9/19.
//  Copyright © 2016年 emiage. All rights reserved.
//

#import "UIChatImageCell.h"

#define ImageMaxWidth ([[UIScreen mainScreen] bounds].size.width-120)*2/3

@implementation UIChatImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setChat:(ChatModel *)chat{
    CGSize imageSize = CGSizeZero;
    if (chat.messsageImage) {
        imageSize= [[self class]imageViewSizeWithImage:chat.messsageImage];
    }
    
    if (chat.isFromMe) {
        self.otherHeadImageIV.hidden=YES;
        self.personName.hidden=YES;
        self.leftMessageImage.hidden=YES;
        self.myHeadImageIV.image = chat.headImage;
        
        [self.rightMessageImage setNeedsLayout];
        self.rightLayoutImageHeight.constant = imageSize.height;
        self.rightLayoutImageWidth.constant = imageSize.width;
        
        [self.rightMessageImage layoutIfNeeded];
        [self.rightMessageImage setSharpCornerImage:chat.messsageImage with:DirectionRight];
    }else{
        self.myHeadImageIV.hidden=YES;
        self.rightMessageImage.hidden=YES;
        self.otherHeadImageIV.image = chat.headImage;
        
        [self.leftMessageImage setNeedsLayout];
        
        
        if (chat.isShowName) {
            self.personName.text =chat.name;
            self.layoutTopHeight.constant =30;
        }else{
            self.personName.hidden=YES;
            self.layoutTopHeight.constant =10;
        }
        
        self.leftLayoutImageHeight.constant = imageSize.height;
        self.leftLayoutImageWidth.constant = imageSize.width;
        
        [self.leftMessageImage layoutIfNeeded];
        [self.leftMessageImage setSharpCornerImage:chat.messsageImage with:DirectionLeft];
    }
    
}



+ (CGSize)imageViewSizeWithImage:(UIImage *)image
{
    CGSize imageSize = CGSizeZero;
    if (image) {
        UIScreen *screen = [UIApplication sharedApplication].keyWindow.screen;
        CGSize originSize = CGSizeMake(image.size.width *image.scale/screen.scale, image.size.height *image.scale/screen.scale);
        if (originSize.width > ImageMaxWidth) {
            CGFloat aspectRatio = originSize.width / originSize.height;
            CGFloat height = ImageMaxWidth / aspectRatio;
            imageSize = CGSizeMake(ImageMaxWidth,(NSInteger)height);
        } else {
            imageSize = originSize;
        }
    }
    return imageSize;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
