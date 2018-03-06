//
//  UIRecordHUD.h
//  Part of Chat
//
//  Created by macmini2 on 16/7/7.
//  Copyright © 2016年 emiage. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, UIRecordStatus) {
    UIRecordStatusNone,
    UIRecordStatusRecording,
    UIRecordStatusCancel,
    UIRecordStatusTooShort
};

@interface UIRecordHUD : UIWindow


-(void)showWithStatus:(UIRecordStatus)status;
-(void)dismiss;

@end
