//
//  MessageSendToolBar.h
//  Part of Chat
//
//  Created by macmini2 on 16/7/6.
//  Copyright © 2016年 emiage. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MessageToolBarDelegate <NSObject>
-(void)showFunctionButtonView:(BOOL)showFunctionMenu;//弹出按钮菜单
-(void)hideViewToRecord:(UIButton*)button;//切换到录音 隐藏所有view(按钮视图、表情视图)
@end
@class AdaptiveTextView;
@interface MessageSendToolBar : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * backViewConstraints;
@property (weak, nonatomic) IBOutlet UIButton *emojiButton;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;
@property (weak, nonatomic) IBOutlet UIButton *otherButton;
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet AdaptiveTextView * messageText;
//文本框输入背景
@property (weak, nonatomic) IBOutlet UIView *textBackView;

//表情及更多功能背景
@property (weak, nonatomic) IBOutlet UIView *functionBackView;



@property (assign, nonatomic) CGFloat toolbarHeight;        //UITextView所占的高度，不包括下面功能按钮。
@property (assign, nonatomic) CGFloat functionBackViewHeight; //功能按钮高度

@property (nonatomic) BOOL isShowCollectioView;

@property (nonatomic,weak) id<MessageToolBarDelegate>delegate;

@end
