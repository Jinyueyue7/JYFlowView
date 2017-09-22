//
//  SportsFlowView.m
//  JYFlowView
//
//  Created by 伟运体育 on 2017/9/22.
//  Copyright © 2017年 伟运体育. All rights reserved.
//

#import "SportsFlowView.h"
#import "JYLineLayout.h"
#import "SportsFlowCell.h"

@interface SportsFlowView ()<UICollectionViewDataSource, UICollectionViewDelegate,UIScrollViewDelegate>


@property (nonatomic,strong)NSIndexPath *currentIndexPath;

@property (nonatomic,strong)NSIndexPath *centerIndexPath;

@property (nonatomic,strong)NSArray *dataArray;

@property (nonatomic,strong)NSArray *hightDataArray;

@property (nonatomic,strong)NSArray *titleArray;

@end

@implementation SportsFlowView

static NSString * const CYPhotoId = @"sport";

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        // 创建布局
        JYLineLayout *layout = [[JYLineLayout alloc] init];
        layout.itemSize = CGSizeMake(75, 110);
        
        // 创建CollectionView
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.delegate = self;
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:collectionView];
        
        self.collectionView = collectionView;
        
        // 注册
        [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([SportsFlowCell class]) bundle:nil] forCellWithReuseIdentifier:CYPhotoId];
    }
    return self;
}
-(void)setSportType:(NSString *)sportType
{
    _sportType = sportType;
    NSInteger index = 2 ;
    for (NSInteger i = 0; i<self.titleArray.count; i++) {
        NSString * title = self.titleArray[i];
        if ([title isEqualToString:self.sportType]) {
            index = i;
        }
    }
    NSIndexPath * tempIndexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self collectionView:self.collectionView didSelectItemAtIndexPath:tempIndexPath];
}

-(void)scrolllToIndex:(NSInteger)index
{
    //默认状态
    SportsFlowCell *oldCell = (SportsFlowCell *)[self.collectionView cellForItemAtIndexPath:self.currentIndexPath];
    oldCell.imageV.image = [UIImage imageNamed:self.dataArray[self.currentIndexPath.item]];
    oldCell.label.font = [UIFont systemFontOfSize:12];;
    oldCell.label.textColor = [UIColor darkTextColor];
    
    //选中状态
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    SportsFlowCell *cell = (SportsFlowCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    cell.imageV.image = [UIImage imageNamed:self.hightDataArray[self.centerIndexPath.item]];
    cell.label.font = [UIFont systemFontOfSize:14];;
    cell.label.textColor = [UIColor redColor];
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    self.currentIndexPath = indexPath;
    
    if (self.selectSportBlock) {
        self.selectSportBlock(cell.label.text);
    }
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SportsFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CYPhotoId forIndexPath:indexPath];

    //默认状态
    cell.imageV.image = [UIImage imageNamed:self.dataArray[indexPath.item]];
    cell.label.text = self.titleArray[indexPath.item];
    cell.label.font = [UIFont systemFontOfSize:12];;
    cell.label.textColor = [UIColor darkTextColor];
    
    CGPoint pInView = [self convertPoint:self.collectionView.center toView:self.collectionView];
    // 获取这一点的indexPath
    NSIndexPath *indexPathNow = [self.collectionView indexPathForItemAtPoint:pInView];
    if (indexPath == indexPathNow) {
        
        // 选中状态
        cell.imageV.image = [UIImage imageNamed:self.hightDataArray[indexPath.item]];
        cell.label.font = [UIFont systemFontOfSize:14];;
        cell.label.textColor = [UIColor redColor];
        
        self.currentIndexPath = indexPath;
        
        if (self.selectSportBlock) {
            self.selectSportBlock(cell.label.text);
        }
    }else if (self.currentIndexPath == indexPath){
        // 选中状态
        cell.imageV.image = [UIImage imageNamed:self.hightDataArray[indexPath.item]];
        cell.label.font = [UIFont systemFontOfSize:14];;
        cell.label.textColor = [UIColor redColor];
        
        self.currentIndexPath = indexPath;
        
        if (self.selectSportBlock) {
            self.selectSportBlock(cell.label.text);
        }
    }
    
    if (indexPath.row==2) {
        self.centerIndexPath = indexPath;
    }
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"------%zd", indexPath.item);
    
    //默认状态
    SportsFlowCell *oldCell = (SportsFlowCell *)[self.collectionView cellForItemAtIndexPath:self.currentIndexPath];
    oldCell.imageV.image = [UIImage imageNamed:self.dataArray[self.currentIndexPath.item]];
    oldCell.label.font = [UIFont systemFontOfSize:12];;
    oldCell.label.textColor = [UIColor darkTextColor];
    
    //选中状态
    SportsFlowCell *cell = (SportsFlowCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    cell.imageV.image = [UIImage imageNamed:self.hightDataArray[indexPath.item]];
    cell.label.font = [UIFont systemFontOfSize:14];;
    cell.label.textColor = [UIColor redColor];
    
    self.currentIndexPath = indexPath;
    
    //滑动到中间
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    if (self.selectSportBlock) {
        self.selectSportBlock(cell.label.text);
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 将collectionView在控制器view的中心点转化成collectionView上的坐标
    CGPoint pInView = [self convertPoint:self.collectionView.center toView:self.collectionView];
    // 获取这一点的indexPath
    NSIndexPath *indexPathNow = [self.collectionView indexPathForItemAtPoint:pInView];
    
//    //默认状态
//    SportsFlowCell *oldCell = (SportsFlowCell *)[self.collectionView cellForItemAtIndexPath:self.currentIndexPath];
//    oldCell.imageV.image = [UIImage imageNamed:self.dataArray[self.currentIndexPath.item]];
//    oldCell.label.font = [UIFont systemFontOfSize:12];
//    oldCell.label.textColor = Color_DarkGrayColor;
//    
//    //选中状态
//    SportsFlowCell *cell = (SportsFlowCell *)[self.collectionView cellForItemAtIndexPath:indexPathNow];
//    cell.imageV.image = [UIImage imageNamed:self.hightDataArray[indexPathNow.item]];
//    cell.label.font = [UIFont systemFontOfSize:14];
//    cell.label.textColor = [UIColor redColor];
    
    [self.collectionView reloadData];

    self.currentIndexPath = indexPathNow;
    
//    if (self.selectSportBlock) {
//        self.selectSportBlock(cell.label.text);
//    }
}

-(NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = @[@"篮球选项_",@"乒乓球选项_",@"网球选项_",@"羽毛球选项_",@"足球选项_"];
    }
    return _dataArray;
}

-(NSArray *)hightDataArray
{
    if (!_hightDataArray) {
        _hightDataArray = @[@"篮球选中_",@"乒乓球选中_",@"网球选中_",@"羽毛球选中_",@"足球选中_"];
    }
    return _hightDataArray;
}

-(NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = @[@"篮球",@"乒乓球",@"网球",@"羽毛球",@"足球"];
    }
    return _titleArray;
}

@end
