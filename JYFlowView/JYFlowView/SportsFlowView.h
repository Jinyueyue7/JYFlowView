//
//  SportsFlowView.h
//  JYFlowView
//
//  Created by 伟运体育 on 2017/9/22.
//  Copyright © 2017年 伟运体育. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SportsFlowView : UIView

@property (nonatomic,strong)UICollectionView *collectionView;

//选中的项目
@property (nonatomic,copy)void (^selectSportBlock)(NSString *sport);

@property (copy, nonatomic) NSString * sportType;

//移动到固定位置
-(void)scrolllToIndex:(NSInteger)index;
@end
