//
//  UIChatTextCell.m
//  Part of Chat
//
//  Created by macmini2 on 16/9/19.
//  Copyright © 2016年 emiage. All rights reserved.
//

#import "UIChatTextCell.h"

@implementation UIChatTextCell


-(void)setChat:(ChatModel *)chat{
    if (chat.isFromMe) {
        self.otherHeadImageIV.hidden=YES;
        self.personName.hidden=YES;
        self.leftMessageContent.hidden=YES;
        self.leftBackGroundImage.hidden=YES;
        self.myHeadImageIV.image = chat.headImage;
        
        self.rightMessageContent.text =chat.messageContent;
  
    }else{
        self.myHeadImageIV.hidden=YES;
        self.rightMessageContent.hidden=YES;
        self.rightBackGroundImage.hidden=YES;
        
        
        self.otherHeadImageIV.image = chat.headImage;
        if (chat.isShowName) {
            self.layoutLeftLabTop.constant+=20;
            [self.leftMessageContent layoutIfNeeded];
            self.personName.text =chat.name;
        }else{
            self.personName.hidden=YES;
        }
        self.leftMessageContent.text =chat.messageContent;
        
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.leftMessageContent sizeToFit];
    [self.rightMessageContent sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
