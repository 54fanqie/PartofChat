//
//  UIChatTextCell.h
//  Part of Chat
//
//  Created by macmini2 on 16/9/19.
//  Copyright © 2016年 emiage. All rights reserved.
//


#import "UIChatBaseCell.h"

@interface UIChatTextCell : UIChatBaseCell
@property (weak, nonatomic) IBOutlet UIImageView * otherHeadImageIV;
@property (weak, nonatomic) IBOutlet UIImageView * myHeadImageIV;
@property (weak, nonatomic) IBOutlet UILabel *personName;

@property (weak, nonatomic) IBOutlet UILabel * leftMessageContent;
@property (weak, nonatomic) IBOutlet UILabel * rightMessageContent;

@property (weak, nonatomic) IBOutlet UIImageView *leftBackGroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *rightBackGroundImage;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutLeftLabTop;
@end
