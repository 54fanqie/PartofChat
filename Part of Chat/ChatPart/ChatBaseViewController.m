//
//  ChatBaseViewController.m
//  Part of Chat
//
//  Created by macmini2 on 16/7/6.
//  Copyright © 2016年 emiage. All rights reserved.
//

#import "ChatBaseViewController.h"
#import "MessageSendToolBar.h"
#import "UIColor+Hex.h"
#import "AdaptiveTextView.h"
#import "CaptureVideoViewController.h"
@interface ChatBaseViewController ()<MessageToolBarDelegate>

@end

@implementation ChatBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self initMessageSendToolBar];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(collectionViewDidSelectItemAtIndexPath:) name:@"functionCollectionViewDidSelectItem" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollerHideKeyBoard) name:@"hideMessageText" object:nil];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.messageSendToolBar];
}
#pragma mark 初始化输入界面
-(void)initMessageSendToolBar{
    
    
    NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"MessageSendToolBar" owner:self options:nil];
    self.messageSendToolBar = [nib objectAtIndex:0];
    self.messageSendToolBar.frame = CGRectMake(0,
                                               self.view.frame.size.height-self.messageSendToolBar.toolbarHeight,
                                               self.view.frame.size.width,
                                               self.messageSendToolBar.bounds.size.height);
    self.messageSendToolBar.delegate=self;
    self.messageSendToolBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.messageSendToolBar];
    self.messageSendToolBar.backgroundColor = [UIColor redColor];
    
}


#pragma mark  MessageToolBarDelegate
#pragma mark  其他功能按钮
-(void)showFunctionButtonView:(BOOL)showFunctionMenu{
    if (showFunctionMenu) {
        [self messageSendToolBarAnimation:self.messageSendToolBar.functionBackViewHeight];
    }else{
        [self.messageSendToolBar.messageText becomeFirstResponder];
    }
    
}
#pragma mark  切换到录音隐藏所有弹出的视图view
-(void)hideViewToRecord:(UIButton *)button{
    if (button.selected) {
        [self messageSendToolBarAnimation:0];
    }else{
        [self.messageSendToolBar.messageText becomeFirstResponder];
    }
}

-(void)messageSendToolBarAnimation:(CGFloat)height{
    [UIView animateWithDuration:.25 animations:^{
        [self.messageSendToolBar.messageText resignFirstResponder];
        [self.messageSendToolBar setFrame:CGRectMake(self.messageSendToolBar.frame.origin.x, self.view.frame.size.height - self.messageSendToolBar.toolbarHeight-height, self.messageSendToolBar.frame.size.width, self.messageSendToolBar.frame.size.height)];
    }completion:^(BOOL finished){
    }];
}




#pragma mark  Notification
#pragma mark  KeyboardNotification  输入键盘
-(void)keyBoardWillShow:(NSNotification*)notification{
    if (self.view.window && [self.view.window isKeyWindow] && [self.messageSendToolBar.messageText isFirstResponder]) {
        NSDictionary * notifi = notification.userInfo;
        CGRect keyBoardFrame = [[notifi objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        keyBoardFrame = [self.view convertRect:keyBoardFrame fromView:nil];
        UIViewAnimationCurve curve = [[notifi objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
        CGFloat duration = [[notifi objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
        [UIView animateWithDuration:duration delay:0 options:(curve <<16) animations:^{
            self.messageSendToolBar.frame = CGRectMake(self.messageSendToolBar.frame.origin.x, self.view.frame.size.height - self.messageSendToolBar.toolbarHeight - keyBoardFrame.size.height, self.messageSendToolBar.frame.size.width, self.messageSendToolBar.frame.size.height);
        } completion:^(BOOL finished) {
        }];
    }
}
-(void)keyBoardWillHide:(NSNotification*)notification{
    NSDictionary * notifi = notification.userInfo;
    UIViewAnimationCurve curve = [[notifi objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    CGFloat duration = [[notifi objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration delay:0 options:(curve <<16) animations:^{
        self.messageSendToolBar.frame = CGRectMake(self.messageSendToolBar.frame.origin.x, self.view.frame.size.height - self.messageSendToolBar.toolbarHeight, self.messageSendToolBar.frame.size.width, self.messageSendToolBar.frame.size.height);
    } completion:^(BOOL finished) {
    }];
}


-(void)scrollerHideKeyBoard{
    if ([self.messageSendToolBar.messageText isFirstResponder]) {
        [self.messageSendToolBar.messageText resignFirstResponder];
    }else{
        self.messageSendToolBar.isShowCollectioView = NO;
        [self messageSendToolBarAnimation:0];
    }
}


#pragma mark  Action
-(void)collectionViewDidSelectItemAtIndexPath:(NSNotification*)note{
    CaptureVideoViewController * con = [[CaptureVideoViewController alloc]initWithNibName:@"CaptureVideoViewController" bundle:nil];
    [self.navigationController pushViewController:con animated:YES];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
