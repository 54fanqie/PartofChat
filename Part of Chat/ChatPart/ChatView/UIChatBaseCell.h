//
//  UIChatBaseCell.h
//  Part of Chat
//
//  Created by macmini2 on 16/9/19.
//  Copyright © 2016年 emiage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatModel.h"

@interface UIChatBaseCell : UITableViewCell
@property (nonatomic,strong) ChatModel * chat;
+(id)cellWithChat:(ChatModel *)chat reuseID:(NSString *)reuseID;
@end
