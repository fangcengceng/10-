//
//  ZFBBusinessLayout.m
//  10.21
//
//  Created by codygao on 16/10/21.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ZFBBusinessLayout.h"
#define itemMargin  1
#define itemColum  4
#define itemRow 2


@implementation ZFBBusinessLayout

-(instancetype)init{
    if (self = [super init]){
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = 1;
    self.minimumInteritemSpacing = 1;
  
  
}

-(void)prepareLayout{
    [super prepareLayout];
//    self.itemSize = CGSizeMake(30, 30);
    CGFloat width = (self.collectionView.bounds.size.width - 3 * itemMargin) / itemColum ;
    CGFloat height = (self.collectionView.bounds.size.height - itemMargin) / itemRow ;
    
    self.itemSize = CGSizeMake(width, height);
    
    
}



@end
