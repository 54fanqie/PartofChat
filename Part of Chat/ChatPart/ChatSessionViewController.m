//
//  ChatSessionViewController.m
//  Part of Chat
//
//  Created by macmini2 on 16/7/6.
//  Copyright © 2016年 emiage. All rights reserved.
//

#import "ChatSessionViewController.h"
#import "MessageSendToolBar.h"
#import "UIColor+Hex.h"
#import "AdaptiveTextView.h"
#import "CaptureVideoViewController.h"
#import "UIChatBaseCell.h"
#import "ChatModel.h"
#import "UIChatImageCell.h"


@interface ChatSessionViewController ()<UITableViewDelegate,UITableViewDataSource,MessageToolBarDelegate>
@property (nonatomic,strong) MessageSendToolBar * messageSendToolBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottmHeight;
@property (weak, nonatomic) IBOutlet UITableView *chatTabelView;
@property (nonatomic,strong) UIRefreshControl * refreshControl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottmHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topY;
@property (nonatomic,assign) CGFloat  tableViewHeight;
@property (nonatomic,strong) NSArray * chatArray;
@end

@implementation ChatSessionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventValueChanged];
    [self.chatTabelView addSubview:self.refreshControl];
    

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(collectionViewDidSelectItemAtIndexPath:) name:@"functionCollectionViewDidSelectItem" object:nil];
    
    [self initMessageSendToolBar];
    
    //    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    ChatModel * chat1 = [[ChatModel alloc]init];
    chat1.isFromMe =YES;
    chat1.sessionMessageType = SessionMessageTypeAudio;
    chat1.headImage =[UIImage imageNamed:@"wn.jpg"];
    chat1.name = @"张三";
    chat1.isShowName =NO;
    
    ChatModel * chat2 = [[ChatModel alloc]init];
    chat2.isFromMe =NO;
    chat2.sessionMessageType = SessionMessageTypeText;
    chat2.headImage =[UIImage imageNamed:@"wo.jpg"];
    chat2.messageContent = @"你吃饭了么？我好想你❤️1";
    chat2.name = @"李四";
    chat2.isShowName =YES;
    
    ChatModel * chat3 = [[ChatModel alloc]init];
    chat3.isFromMe =YES;
    chat3.sessionMessageType = SessionMessageTypeAudio;
    chat3.headImage =[UIImage imageNamed:@"wp.jpg"];
    chat3.name = @"我是";
    chat3.messageContent = @"2011年3月11日，日本东北方外海发生9.0级地震，又引发海啸，造成福岛第一核电站一系列灾害事件，演成人类历史上1986年切尔诺贝利以来最严重的核事故。五年后的今天，福岛是什么样呢？ 2CH网友上传了图片，称“福?u、すっかりサファリパ?クになるｗｗｗｗｗｗ（福岛完全变成野生动物园了）”。";
    chat3.isShowName =NO;
    
    
    
    ChatModel * chat4 = [[ChatModel alloc]init];
    chat4.isFromMe =NO;
    chat4.sessionMessageType = SessionMessageTypeText;
    chat4.headImage =[UIImage imageNamed:@"wq.jpg"];
    chat4.messageContent=@"　该微博原文称：她可以发的，没关系，图片是私人XX给她的。打马赛克了。反正20号你公布。但是你要公布公关说的那一部分，有些要5个月以后次才能说。然后转发的@我是韩亚宏的微博则称：你在这里发什么？？明天把这些给他们。你问这小杨，直播平台选哪个。远程连线的时候，让马姐戴个帽子和墨镜。图为微博曝光的马赛克照片，其中长发男子看起来有点像是王宝强啊，细思极恐，这是准备黑王宝强的节奏吗？";
    chat4.name = @"王五";
    chat4.isShowName =NO;
    
    
    
    ChatModel * chat5 = [[ChatModel alloc]init];
    chat5.isFromMe =NO;
    chat5.sessionMessageType = SessionMessageTypeAudio;
    chat5.headImage =[UIImage imageNamed:@"ws.jpg"];
    chat5.name = @"马可波罗·奥德罗克夫蒂斯柴德洛夫斯基马可波罗·奥德罗克夫蒂斯柴德洛夫斯基";
    chat5.isShowName =YES;
    
    ChatModel * chat6 = [[ChatModel alloc]init];
    chat6.isFromMe =YES;
    chat6.sessionMessageType = SessionMessageTypeAudio;
    chat6.headImage =[UIImage imageNamed:@"qh"];
    chat6.name = @"黑小瘪三";
    chat6.isShowName =YES;
    
    ChatModel * chat7 = [[ChatModel alloc]init];
    chat7.isFromMe =NO;
    chat7.sessionMessageType = SessionMessageTypeSystem;
    chat7.headImage =[UIImage imageNamed:@"qh"];
    chat7.name = @"黑小瘪三";
    chat7.systemMessage=@"彼岸🌹和群类其他人都不是好友关系,请注意隐私安全，防止上当受骗,最近有人上当受骗，这是一个咋骗群，请大家注意，防火防盗房色诱.";
    chat7.isShowName =YES;
    
    ChatModel * chat8 = [[ChatModel alloc]init];
    chat8.isFromMe =YES;
    chat8.sessionMessageType = SessionMessageTypeImage;
    chat8.headImage =[UIImage imageNamed:@"wr.jpg"];
    chat8.name = @"泡芙小姐";
    chat8.isShowName =YES;
    chat8.messsageImage = [UIImage imageNamed:@"5.png"];
    
    
    ChatModel * chat9 = [[ChatModel alloc]init];
    chat9.isFromMe =NO;
    chat9.sessionMessageType = SessionMessageTypeImage;
    chat9.headImage =[UIImage imageNamed:@"wo.jpg"];
    chat9.name = @"钢铁侠";
    chat9.isShowName =NO;
    chat9.messsageImage = [UIImage imageNamed:@"IMG_0245.jpg"];
    
    
    ChatModel * chat10 = [[ChatModel alloc]init];
    chat10.isFromMe =NO;
    chat10.sessionMessageType = SessionMessageTypeImage;
    chat10.headImage =[UIImage imageNamed:@"wn.jpg"];
    chat10.name = @"番茄";
    chat10.isShowName =YES;
    chat10.messsageImage = [UIImage imageNamed:@"18.jpg"];
    
    ChatModel * chat11 = [[ChatModel alloc]init];
    chat11.isFromMe =NO;
    chat11.sessionMessageType = SessionMessageTypeText;
    chat11.headImage =[UIImage imageNamed:@"qh"];
    chat11.name = @"洪荒";
    chat11.isShowName =NO;
    chat11.messageContent = @"你好,我们好像在哪儿见过你记好像在哪儿见过你记好像在哪儿见过你记";
    chat11.messsageImage = [UIImage imageNamed:@"18.jpg"];
    
    
    
    ChatModel * chat12 = [[ChatModel alloc]init];
    chat12.isFromMe =YES;
    chat12.sessionMessageType = SessionMessageTypeText;
    chat12.headImage =[UIImage imageNamed:@"wp.jpg"];
    chat12.name = @"钢铁侠";
    chat12.isShowName =NO;
    chat12.messageContent = @"一切的一切，从这开始萌芽，愿所有美好的记忆，不是从岁月里匆匆走过，而是让它永驻我们的心中。一座山城，因为你，它便成了最特殊的存在 。 在一天天在与困惑的角逐中失利时，你的出现是点亮这个快灰败了的世界 ";
    chat12.messsageImage = [UIImage imageNamed:@"18.jpg"];
    
    
    ChatModel * chat13 = [[ChatModel alloc]init];
    chat13.isFromMe =YES;
    chat13.sessionMessageType = SessionMessageTypeText;
    chat13.headImage =[UIImage imageNamed:@"ws.jpg"];
    chat13.name = @"钢铁侠";
    chat13.isShowName =NO;
    chat13.messageContent = @"一切的一切，从这开始萌芽 ";
    chat13.messsageImage = [UIImage imageNamed:@"18.jpg"];
    
    ChatModel * chat14 = [[ChatModel alloc]init];
    chat14.isFromMe =YES;
    chat14.sessionMessageType = SessionMessageTypeImage;
    chat14.headImage =[UIImage imageNamed:@"qh"];
    chat14.name = @"漂流瓶";
    chat14.isShowName =YES;
    chat14.messsageImage = [UIImage imageNamed:@"ws.jpg"];
    
    
    
    
    ChatModel * chat15 = [[ChatModel alloc]init];
    chat15.isFromMe =NO;
    chat15.sessionMessageType = SessionMessageTypeImage;
    chat15.headImage =[UIImage imageNamed:@"4.jpg"];
    chat15.name = @"w微信";
    chat15.isShowName =YES;
    chat15.messsageImage = [UIImage imageNamed:@"1.png"];
    
    
    ChatModel * chat16 = [[ChatModel alloc]init];
    chat16.sessionMessageType = SessionMessageTypeDate;
    chat16.systemDate =@"2013-08-19 01:40:46";


    
    
    
    
    
    
    self.chatArray  = [NSArray arrayWithObjects:chat2,chat3,chat8,chat4,chat16,chat5,chat15,chat6,chat9,chat7,chat10,chat11,chat1,chat12,chat13,chat14,nil];
    
    
    //        self.chatArray  = [NSArray arrayWithObjects:chat9,chat7,chat10,nil];
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //
    //        });
    //    });
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.messageSendToolBar];
}
-(void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    
}


#pragma mark  MessageToolBarDelegate
#pragma mark  其他功能按钮
-(void)showFunctionButtonView:(BOOL)showFunctionMenu{
    if (showFunctionMenu) {
        [self messageSendToolBarAnimation];
    }else{
        [self.messageSendToolBar.messageText becomeFirstResponder];
    }
    
}
#pragma mark  切换到录音隐藏所有弹出的视图view
-(void)hideViewToRecord:(UIButton *)button{
    if (button.selected) {
        [self messageSendToolBarAnimation];
    }else{
        [self.messageSendToolBar.messageText becomeFirstResponder];
    }
    
}


#pragma mark  Notification
#pragma mark  KeyboardNotification  输入键盘
-(void)keyBoardWillShow:(NSNotification*)notification{
    
    self.bottmHeight.constant=self.messageSendToolBar.toolbarHeight;
    self.topY.constant=0;
    if (self.view.window && [self.view.window isKeyWindow] && [self.messageSendToolBar.messageText isFirstResponder]) {
        NSDictionary * notifi = notification.userInfo;
        CGRect keyBoardFrame = [[notifi objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        keyBoardFrame = [self.view convertRect:keyBoardFrame fromView:nil];
        UIViewAnimationCurve curve = [[notifi objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
        CGFloat duration = [[notifi objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
        [UIView animateWithDuration:duration delay:0 options:(curve <<16) animations:^{
            CGFloat height = self.messageSendToolBar.toolbarHeight + keyBoardFrame.size.height;
            self.messageSendToolBar.frame = CGRectMake(self.messageSendToolBar.frame.origin.x, self.view.frame.size.height - height , self.messageSendToolBar.frame.size.width, self.messageSendToolBar.frame.size.height);
            
            if ([self isMoveUpTableView:height]) {
                [self scrollTableToBottomWithAnimated:NO];
                CGFloat moveHeight = MIN(keyBoardFrame.size.height,keyBoardFrame.size.height-(CGRectGetHeight(self.chatTabelView.frame)-self.chatTabelView.contentSize.height));
                
                self.bottmHeight.constant+=moveHeight;
                self.topY.constant-=moveHeight;
                [self.chatTabelView layoutIfNeeded];
            }
            
            
        } completion:^(BOOL finished) {
            
        }];
    }
}
-(void)keyBoardWillHide:(NSNotification*)notification{
    
    NSDictionary * notifi = notification.userInfo;
    UIViewAnimationCurve curve = [[notifi objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    CGFloat duration = [[notifi objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect keyBoardFrame = [[notifi objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyBoardFrame = [self.view convertRect:keyBoardFrame fromView:nil];
    [UIView animateWithDuration:duration delay:0 options:(curve <<16) animations:^{
        self.messageSendToolBar.frame = CGRectMake(self.messageSendToolBar.frame.origin.x, self.view.frame.size.height - self.messageSendToolBar.toolbarHeight, self.messageSendToolBar.frame.size.width, self.messageSendToolBar.frame.size.height);
        self.bottmHeight.constant=self.messageSendToolBar.toolbarHeight;
        self.topY.constant=0;
        [self.chatTabelView layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
}



#pragma mark  custom Action
-(void)collectionViewDidSelectItemAtIndexPath:(NSNotification*)note{
    CaptureVideoViewController * con = [[CaptureVideoViewController alloc]initWithNibName:@"CaptureVideoViewController" bundle:nil];
    [self.navigationController pushViewController:con animated:YES];
    
}

- (void)scrollTableToBottomWithAnimated:(BOOL)animated
{
    [self.chatTabelView setContentOffset:CGPointMake(0, MAX(self.chatTabelView.contentSize.height - self.chatTabelView.frame.size.height, 0)) animated:animated];
}


-(void)messageSendToolBarAnimation{
    
    CGFloat height =0 ;
    if (self.messageSendToolBar.isShowCollectioView) {
        height=self.messageSendToolBar.functionBackViewHeight;
    }
    [UIView animateWithDuration:.25 animations:^{
        [self.messageSendToolBar.messageText resignFirstResponder];
        [self.messageSendToolBar setFrame:CGRectMake(self.messageSendToolBar.frame.origin.x, self.view.frame.size.height - self.messageSendToolBar.toolbarHeight-height, self.messageSendToolBar.frame.size.width, self.messageSendToolBar.frame.size.height)];
        
        if(self.messageSendToolBar.isShowCollectioView && [self isMoveUpTableView:self.messageSendToolBar.functionBackViewHeight+self.messageSendToolBar.toolbarHeight]){
            CGFloat moveHeight = MIN(height,height-(CGRectGetHeight(self.chatTabelView.frame)-self.chatTabelView.contentSize.height));
            
            self.bottmHeight.constant += moveHeight;
            self.topY.constant -=moveHeight;
            [self scrollTableToBottomWithAnimated:NO];
        }else{
            self.bottmHeight.constant = self.messageSendToolBar.toolbarHeight;
            self.topY.constant = 0;
        }
        [self.chatTabelView layoutIfNeeded];
        
    }completion:^(BOOL finished){
    }];
}

-(BOOL)isMoveUpTableView:(CGFloat)h{
    if (self.chatTabelView.contentSize.height>self.chatTabelView.bounds.size.height-h) {
        return YES;
    }
    return NO;
}

#pragma mark  UIScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if ([self.messageSendToolBar.messageText isFirstResponder]) {
        [self.messageSendToolBar.messageText resignFirstResponder];
    }else{
        self.messageSendToolBar.isShowCollectioView = NO;
        [self messageSendToolBarAnimation];
        
    }
    
}




#pragma mark UITableViewDelegate,UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    if (self.chatTabelView.contentSize.height > self.chatTabelView.frame.size.height) {
    //        [self scrollTableToBottomWithAnimated:NO];
    //    }
    return self.chatArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * indentifier = @"cell";
    UIChatBaseCell * cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    ChatModel * chat = self.chatArray[indexPath.row];
    if (!cell) {
        cell = [UIChatBaseCell cellWithChat:chat reuseID:nil];
    }
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor clearColor];
    cell.alpha=0.1;
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatModel * chat = self.chatArray[indexPath.row];
    if (chat.sessionMessageType == SessionMessageTypeImage) {
        CGSize size = [UIChatImageCell imageViewSizeWithImage:chat.messsageImage];
        if (chat.isShowName) {
            return size.height+45;
        }
        return size.height+25;
    }else{
        self.chatTabelView.rowHeight = UITableViewAutomaticDimension;
        self.chatTabelView.estimatedRowHeight = 1000;
        return  self.chatTabelView.rowHeight;
    }
}




#pragma mark 加载更多(聊天记录)
-(void)refreshAction{
    
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
