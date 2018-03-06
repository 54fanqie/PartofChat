//
//  ChatMeaasgeMacro.h
//  Part of Chat
//
//  Created by macmini2 on 16/9/6.
//  Copyright © 2016年 emiage. All rights reserved.
//

#ifndef ChatMeaasgeMacro_h
#define ChatMeaasgeMacro_h

typedef enum{
    SessionMessageTypeUnknown,
    SessionMessageTypeSystem,
    SessionMessageTypeText,
    SessionMessageTypeImage,
    SessionMessageTypeAudio,
    SessionMessageTypeVideo,
    SessionMessageTypeFile,
    SessionMessageTypeGif,
    SessionMessageTypeDate,
    SessionMessageTypeMultiFile,
}SessionMessageType;


/**
 *  该状态不考虑附件状态
 *  数据库中只保存ChatStatusWaitToSend和ChatStatusSuccess、ChatStatusWaitToRead（要么需要发送，要么不需要）
 *  其他状态在程序内存中用
 *
 */
typedef enum {
    ChatStatusSuccess,
    ChatStatusSending,
    ChatStatusSendFail,
    ChatStatusWaitToSend,
    ChatStatusWaitToRead,
    ChatStatusDraft  // 草稿
} ChatStatus;



#endif /* ChatMeaasgeMacro_h */
