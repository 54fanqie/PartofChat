//
//  FunctionCollectionView.m
//  Part of Chat
//
//  Created by macmini2 on 16/7/27.
//  Copyright © 2016年 emiage. All rights reserved.
//

#import "FunctionCollectionView.h"
#import "FunctionCollectionCell.h"

#define UIImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"imageSource.bundle/chatKeyboardImages/%@",imageName]]


@interface FunctionCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,assign) CGFloat collectionViewHeight;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)  NSArray * titiles ;
@end

@implementation FunctionCollectionView


#pragma mark  UICollectionViewDelegate,UICollectionViewDataSource
-(void)awakeFromNib{
    self.titiles= @[@"照片",@"相机",@"小视频",@"视频聊天",@"红包",@"转账",@"位置",@"收藏",@"联系人",@"发起语音",@"播放视频",@"表情商店",@"实时对话",@"播放视频",@"表情商店",@"实时对话",@"最后👄"];
    
    
    self.collectionViewHeight = self.bounds.size.height;
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView  setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self.collectionView registerNib:[UINib nibWithNibName:@"FunctionCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger num = 0;
    if (self.titiles.count%8!=0) {
        num = 8-self.titiles.count%8;
    }
    
    return self.titiles.count+num;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CellIdentifier = @"cell";
    FunctionCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (_titiles.count > indexPath.row) {
        NSString * imageName=[NSString stringWithFormat:@"FunctionImages/icon_messages_more_%ld.png",(long)indexPath.row];
        cell.functionImage.image = UIImage(imageName);
        cell.functionTitle.text = _titiles[indexPath.row];
    }else{
        cell.functionImage.image=nil;
        cell.functionImage.backgroundColor = [UIColor clearColor];
        cell.functionTitle.text = nil;
    }
    
    
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 0, 5, 0);
}
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(CGRectGetWidth(self.frame)/4, (self.collectionViewHeight-15)/2);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"functionCollectionViewDidSelectItem" object:indexPath];
}

@end
