//
//  UIChatAudioCell.h
//  Part of Chat
//
//  Created by macmini2 on 16/9/19.
//  Copyright © 2016年 emiage. All rights reserved.
//


#import "UIChatBaseCell.h"

@interface UIChatAudioCell : UIChatBaseCell
@property (weak, nonatomic) IBOutlet UIImageView * otherHeadImageIV;
@property (weak, nonatomic) IBOutlet UIImageView * myHeadImageIV;
@property (weak, nonatomic) IBOutlet UILabel *personName;
@property (weak, nonatomic) IBOutlet UIImageView *leftAudioPlay;
@property (weak, nonatomic) IBOutlet UIImageView *leftAudioIV;
@property (weak, nonatomic) IBOutlet UIImageView *rightAudioIV;
@property (weak, nonatomic) IBOutlet UIImageView *rightAudioPlay;

@end
