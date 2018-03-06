//
//  UIRecordHUD.m
//  Part of Chat
//
//  Created by macmini2 on 16/7/7.
//  Copyright © 2016年 emiage. All rights reserved.
//

#import "UIRecordHUD.h"
#import "HUDView.h"

#define HudViewW  175
#define HudViewH 185
#define UIImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"imageSource.bundle/chatKeyboardImages/%@",imageName]]


@interface UIRecordHUD ()
@property (nonatomic,strong) HUDView * hudView;
@end

@implementation UIRecordHUD

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor clearColor];
        [self loadHudView];
    }
    return self;
}
-(void)dismiss{
   self.hidden = YES;
}

#pragma mark 弹出视图
-(void)loadHudView{
    NSArray * nib = [[NSBundle mainBundle]loadNibNamed:@"HUDView" owner:self options:nil];
    self.hudView = [nib objectAtIndex:0];
    self.hudView.frame = CGRectMake(0, 0, HudViewW, HudViewH);
    self.hudView.center = self.center;
    self.hudView.autoresizingMask = UIViewAutoresizingNone;
    [self addSubview:self.hudView];
    //初始状态
    self.hudView.recordImage.image = UIImage(@"VoiceImages/msg_ic_audio1");
    self.hudView.promptTitle.text  = @"手指上划,取消发送";
}

-(void)showWithStatus:(UIRecordStatus)status
{
    @autoreleasepool
    {
        UIImage * image;
        NSString * title;
        [self makeKeyAndVisible];
        switch (status) {
            case UIRecordStatusRecording:
                image = UIImage(@"VoiceImages/msg_ic_audio1@2x");
                title  = @"手指上划,取消发送";
                break;
            case UIRecordStatusCancel:
                image = UIImage(@"VoiceImages/RecordCancel@2x");
                title  = @"松开手指,取消发送";
                break;
            case UIRecordStatusTooShort:
                image = UIImage(@"VoiceImages/MessageTooShort@2x");
                title  = @"录音时间太短";
                break;
            default:
                break;
        }
        self.hudView.recordImage.image = image;
        self.hudView.promptTitle.text = title;
    
    }

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
