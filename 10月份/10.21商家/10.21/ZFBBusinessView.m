//
//  ZFBBusinessView.m
//  10.21
//
//  Created by codygao on 16/10/21.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ZFBBusinessView.h"
#import "Masonry.h"
#import "ZFBBusinessLayout.h"
#import "BusinessModel.h"
#import "ZFBBusinessCollectionViewCell.h"

static NSString *cellId = @"cellId";
@interface ZFBBusinessView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,weak)UIPageControl *pageCtr;

@end

@implementation ZFBBusinessView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self setupUI];
    }
    return self;
}


-(void)setupUI{
    ZFBBusinessLayout *layout = [[ZFBBusinessLayout alloc] init];
    
    UICollectionView *view = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    view.backgroundColor = [UIColor whiteColor];
    view.showsHorizontalScrollIndicator = NO;
    view.pagingEnabled = YES;
    view.bounces = NO;
    [view registerClass:[ZFBBusinessCollectionViewCell class] forCellWithReuseIdentifier:cellId];
    [self addSubview:view];
    view.dataSource = self;
    view.delegate = self;
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-20);
      
    }];
    
    
    UIPageControl *pageCtr = [[UIPageControl alloc] init];
    pageCtr.currentPageIndicatorTintColor = [UIColor yellowColor];
    pageCtr.pageIndicatorTintColor = [UIColor redColor];
//    pageCtr.numberOfPages = 2;如果需要根据_array的数量来设置，按钮需要设置在setArray方法中。设置在这里，显示不出来
    [self addSubview:pageCtr];
    self.pageCtr = pageCtr;
    [pageCtr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(10);
        
    }];
    
}

#pragma mark ----pageCtr 的显示页数计算
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat pageNum = offsetX / self.frame.size.width;
    pageNum = pageNum + 0.5;
    self.pageCtr.currentPage = pageNum;
}

-(void)setArray:(NSArray *)array{
    _array = array;
    self.pageCtr.numberOfPages = 2;
}

#pragma mark -----UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _array.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZFBBusinessCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];

    cell.businessModel = _array[indexPath.item];
    return cell;
    
}

#pragma mark 选中对应的item时 执行代理方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BusinessModel *model = _array[indexPath.row];
  
    if ([self.delegate respondsToSelector:@selector(DidselectModel:model:)]){
        [self.delegate DidselectModel:self model:model];
    }
    
    
}


    




@end
