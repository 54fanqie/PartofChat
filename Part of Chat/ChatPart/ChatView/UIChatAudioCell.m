//
//  UIChatAudioCell.m
//  Part of Chat
//
//  Created by macmini2 on 16/9/19.
//  Copyright © 2016年 emiage. All rights reserved.
//

#import "UIChatAudioCell.h"


@implementation UIChatAudioCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

-(void)setChat:(ChatModel *)chat{
    if (chat.isFromMe) {
        self.otherHeadImageIV.hidden=YES;
        self.personName.hidden=YES;
        self.leftAudioIV.hidden=YES;
        self.leftAudioPlay.hidden=YES;
        self.myHeadImageIV.image = chat.headImage;
    }else{
        self.myHeadImageIV.hidden=YES;
        self.rightAudioIV.hidden=YES;
        self.rightAudioPlay.hidden=YES;
        self.otherHeadImageIV.image = chat.headImage;
        if (chat.isShowName) {
            self.personName.text =chat.name;
        }
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
