//
//  UIChatSystemCell.m
//  Part of Chat
//
//  Created by macmini2 on 16/9/19.
//  Copyright © 2016年 emiage. All rights reserved.
//

#import "UIChatSystemCell.h"

@implementation UIChatSystemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}
-(void)setChat:(ChatModel *)chat{
    self.systemMessageLab.text = chat.systemMessage;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
