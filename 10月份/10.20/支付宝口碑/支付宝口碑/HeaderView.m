//
//  HeaderView.m
//  支付宝口碑
//
//  Created by codygao on 16/10/20.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "HeaderView.h"
@interface HeaderView()
@property(nonatomic,weak)UIImageView *imgV;

@end

@implementation HeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){

    }
    return  self;
}

-(void)setImgArr:(NSArray *)imgArr{
    _imgArr = imgArr;
    
    for (NSInteger i = 0; i<4; i++) {
        
        UIImage *imge = imgArr[i];
        CGFloat height = self.frame.size.width * (imge.size.height/ imge.size.width );
        
        UIImageView *img = [[UIImageView alloc] initWithImage:imgArr[i]];
        img.frame = CGRectMake(0, i*height,self.frame.size.width,height);
        img.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:img];
    }
 
}




@end
