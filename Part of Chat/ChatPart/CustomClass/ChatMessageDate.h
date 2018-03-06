//
//  ChatMessageDate.h
//  聊天时间显示
//
//  Created by macmini2 on 16/9/23.
//  Copyright © 2016年 emiage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatMessageDate : NSObject

+(NSString*)chatMessageTimeStr:(long long)timestamp;

+(NSDate*)stringTimeChangToDate:(NSString*)time;

@end
