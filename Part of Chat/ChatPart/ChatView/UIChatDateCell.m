//
//  UIChatDateCell.m
//  Part of Chat
//
//  Created by macmini2 on 16/9/22.
//  Copyright © 2016年 emiage. All rights reserved.
//

#import "UIChatDateCell.h"
#import "ChatMessageDate.h"
@implementation UIChatDateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}
-(void)setChat:(ChatModel *)chat{
    
    NSDate * date = [ChatMessageDate stringTimeChangToDate:chat.systemDate];
    NSString * hah = [ChatMessageDate chatMessageTimeStr:[date timeIntervalSince1970]];
    self.systemTimeLab.text = hah;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
