//
//  MessageSendToolBar.m
//  Part of Chat
//
//  Created by macmini2 on 16/7/6.
//  Copyright © 2016年 emiage. All rights reserved.
//

#import "MessageSendToolBar.h"
#import "UIColor+Hex.h"
#import "UIRecordHUD.h"
#import "FunctionCollectionCell.h"
#import "AdaptiveTextView.h"
#import "EmojiListView.h"
#import "FunctionCollectionView.h"
#import "EmojiInfo.h"


#define RecordTitleOutStatus @"松开手指,取消发送"
#define RecordTitleStatus    @"按住 录音"
#define UIImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"imageSource.bundle/chatKeyboardImages/%@",imageName]]
#define  DURTAION  0.25f

@interface MessageSendToolBar()<AdaptiveTextViewDelegate,InsertEmojiDelegate>
{
    CGFloat internalTextViewSizeDelta;
}
@property (strong, nonatomic)  FunctionCollectionView *collectionView;
@property (nonatomic) BOOL    isRecording;
@property (nonatomic,strong)  UIRecordHUD * recordHUD;
@property (nonatomic,strong)  EmojiListView * emojiListView;
@end


@implementation MessageSendToolBar
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}


-(void)awakeFromNib{
    self.toolbarHeight = self.backViewConstraints.constant;
    self.functionBackViewHeight = CGRectGetHeight(self.functionBackView.frame);
    self.isShowCollectioView = NO;
    //录音按钮
    self.recordButton.hidden=YES;
    self.messageText.delegete=self;

}


#pragma mark 切换录音或者文本
- (IBAction)changeRecordOrText:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {//弹出
        [sender setImage:UIImage(@"ChangeButtonImages/dd_input_normal.png") forState:UIControlStateNormal];
        self.recordButton.hidden = NO;
        self.messageText.hidden=YES;
        [self.messageText resignFirstResponder];
    }else{//收回
        [sender setImage:UIImage(@"ChangeButtonImages/dd_record_normal.png") forState:UIControlStateNormal];
        self.recordButton.hidden = YES;
        self.messageText.hidden=NO;
        [self.messageText becomeFirstResponder];
    }
    if(_delegate && [_delegate respondsToSelector:@selector(hideViewToRecord:)]){
        self.isShowCollectioView = NO;
        [_delegate hideViewToRecord:sender];
    }
}
#pragma mark 录音按钮 recordButton event
- (IBAction)starRecordAction:(UIButton *)sender {//按下开始录音
    sender.backgroundColor = UIColorRGB(231, 231, 231, 1);
    [self.recordHUD showWithStatus:UIRecordStatusRecording];
}
- (IBAction)endRecordAction:(UIButton *)sender {//松手结束录音
    sender.backgroundColor = [UIColor whiteColor];
    [sender setTitle:RecordTitleStatus forState:UIControlStateNormal];
    [self.recordHUD dismiss];
    
}
- (IBAction)touchUpOutSide:(UIButton *)sender { //取消录音
    sender.backgroundColor = [UIColor whiteColor];
    [sender setTitle:RecordTitleStatus forState:UIControlStateNormal];
    [self.recordHUD dismiss];
}
- (IBAction)moveOutSide:(UIButton *)sender {
    [sender setTitle:RecordTitleOutStatus forState:UIControlStateNormal];
    [self.recordHUD showWithStatus:UIRecordStatusCancel];
}
- (IBAction)moveInSide:(UIButton *)sender {
    [self.recordHUD showWithStatus:UIRecordStatusRecording];
}



-(void)beganRecord{
    
}
- (void)finishRecord
{
    
}
-(void)cancelRecord{
    
}





#pragma mark 弹出表情视图
- (IBAction)emojiShowAction:(UIButton *)sender {
  
    if (!_emojiListView) {
//        dispatch_async(dispatch_get_main_queue(), ^{
            [self.functionBackView addSubview:self.emojiListView];
//        });
    }
    _collectionView.hidden =YES;
    _emojiListView.hidden = NO;

    [self showEmojiViewAndFuncCollectionView];
}
#pragma mark  弹出其他功能按钮列表视图
- (IBAction)showOtherActionButton:(id)sender {
    if (!_collectionView) {
//        dispatch_async(dispatch_get_main_queue(), ^{
            [self.functionBackView addSubview:self.collectionView];
//        });
    }
    
    _emojiListView.hidden = YES;
    _collectionView.hidden = NO;
    [self showEmojiViewAndFuncCollectionView];
}

-(void)showEmojiViewAndFuncCollectionView{
    if (self.changeButton.selected) {
        [self  changeRecordOrText:self.changeButton];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(showFunctionButtonView:)]) {
        if (!self.isShowCollectioView) {
            self.isShowCollectioView = YES;
            [_delegate showFunctionButtonView:YES];
        }else{
            //            self.isShowCollectioView = NO;
            //            [_delegate showFunctionButtonView:NO];
        }
    }
    
    
}




#pragma mark UITextViewDelegate
-(void)textViewDidBeginEditing:(AdaptiveTextView *)growingTextView{
    self.isShowCollectioView = NO;
}
-(void)textView:(AdaptiveTextView *)growingTextView shouldChangeHeight:(CGFloat)height{
    CGFloat  diffrentH= height - self.messageText.bounds.size.height;
    self.backViewConstraints.constant += diffrentH;
    [UIView animateWithDuration:.25 delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect toolbarFrame = self.frame;
        toolbarFrame.origin.y -= diffrentH;
        toolbarFrame.size.height += diffrentH;
        self.frame = toolbarFrame;
        self.toolbarHeight = self.backViewConstraints.constant;
        
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
    
}








-(void)insertEmoji:(EmojiInfo *)emoji{
    if ([emoji.emojiString isEqualToString:@"[删除]"]) {
        [self.messageText deleteBackward];
    }else{
        [self.messageText insertEmoticon:emoji];
    }
}



#pragma mark  初始化控件
-(UIRecordHUD*)recordHUD{
    if (!_recordHUD) {
        _recordHUD = [[UIRecordHUD alloc]init];
    }
    return _recordHUD;
}


-(EmojiListView*)emojiListView{
    if(!_emojiListView){
        NSArray * nibs = [[NSBundle mainBundle]loadNibNamed:@"EmojiListView" owner:nil options:nil];
        _emojiListView=[nibs objectAtIndex:0];
        _emojiListView.delegate=self;
        _emojiListView.emojiViewFrame =self.functionBackView.bounds;
        [_emojiListView  setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    }
    return _emojiListView;
}


-(FunctionCollectionView*)collectionView{
    if (!_collectionView) {
        NSArray * nibs = [[NSBundle mainBundle] loadNibNamed:@"FunctionCollectionView" owner:nil options:nil];
        _collectionView = [nibs objectAtIndex:0];
        [_collectionView  setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        _collectionView.frame =self.functionBackView.bounds;
    }
    return _collectionView;
}








/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
