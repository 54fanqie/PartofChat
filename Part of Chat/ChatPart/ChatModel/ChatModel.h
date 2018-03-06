//
//  ChatModel.h
//  Part of Chat
//
//  Created by macmini2 on 16/9/5.
//  Copyright © 2016年 emiage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatMeaasgeMacro.h"
#import <UIKit/UIKit.h>

@interface ChatModel : NSObject
//YES:我说的；NO:别人说的
@property (assign,nonatomic) BOOL isFromMe;
//是否显示名字
@property (assign,nonatomic) BOOL isShowName;


@property (nonatomic,assign) SessionMessageType  sessionMessageType;
@property (nonatomic,strong) UIImage * headImage;
@property (nonatomic,strong) UIImage * messsageImage;
@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * messageContent;
@property (nonatomic,strong) NSString * systemMessage;
@property (nonatomic,strong) NSString * systemDate;
@end
