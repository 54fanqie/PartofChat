//
//  EmojiListView.h
//  CollectionView
//
//  Created by macmini2 on 16/7/18.
//  Copyright © 2016年 emiage. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EmojiInfo;
@protocol InsertEmojiDelegate <NSObject>

-(void)insertEmoji:(EmojiInfo *)emoji;

@end
@interface EmojiListView : UIView
@property (weak,nonatomic) id<InsertEmojiDelegate>delegate;
@property (nonatomic,assign) CGRect emojiViewFrame;
@end
