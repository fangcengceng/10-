//
//  ZFBBusinessCollectionViewCell.h
//  10.21
//
//  Created by codygao on 16/10/22.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BusinessModel;
@class ZFBBusinessCollectionViewCell;


@interface ZFBBusinessCollectionViewCell : UICollectionViewCell

//接受外界传来的模型，填充子控件
@property(nonatomic,strong)BusinessModel *businessModel;



@end
