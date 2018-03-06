//
//  UIChatBaseCell.m
//  Part of Chat
//
//  Created by macmini2 on 16/9/19.
//  Copyright © 2016年 emiage. All rights reserved.
//

#import "UIChatBaseCell.h"
#import "UIChatTextCell.h"
#import "UIChatImageCell.h"
#import "UIChatAudioCell.h"
#import "UIChatVideoCell.h"
#import "UIChatSystemCell.h"


@implementation UIChatBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+(id)cellWithChat:(ChatModel *)chat reuseID:(NSString *)reuseID{
    UIChatBaseCell* cell = nil;
    NSString * nibName;
    switch (chat.sessionMessageType) {
        case SessionMessageTypeSystem:
            nibName = @"UIChatSystemCell";
            break;
        case SessionMessageTypeText:
            nibName = @"UIChatTextCell";
            break;
        case SessionMessageTypeImage:
            nibName = @"UIChatImageCell";
            break;
        case SessionMessageTypeAudio:
            nibName = @"UIChatAudioCell";
            break;
        case SessionMessageTypeVideo:
            nibName = @"UIChatVideoCell";
            break;
        case SessionMessageTypeDate:
            nibName = @"UIChatDateCell";
            break;
        case SessionMessageTypeGif:
        case SessionMessageTypeUnknown:
        default:
            break;
    }
    NSArray * nibs = [[NSBundle mainBundle]loadNibNamed:nibName owner:self options:nil];
    cell = [nibs objectAtIndex:0];
    cell.chat = chat;
    return cell;
}


@end
