//
//  NewFeatureView.m
//  新特性界面
//
//  Created by codygao on 16/10/12.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "NewFeatureView.h"
#define kCount  4
#import "Masonry.h"

@interface NewFeatureView ()<UIScrollViewDelegate>
@property(nonatomic,weak)UIScrollView *scrollView;
@property(nonatomic,weak)UIPageControl *pageCtr;

@end

@implementation NewFeatureView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
//    添加scrollview;
    UIScrollView *scrollview = [[UIScrollView alloc] init];
    scrollview.frame = self.bounds;
    scrollview.pagingEnabled = YES;
    scrollview.showsVerticalScrollIndicator = NO;
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.bounces = NO;
    scrollview.delegate = self;
    self.scrollView = scrollview;

    [self addSubview:scrollview];

    //添加pageControl
    UIPageControl *ctr = [[UIPageControl alloc] init];
    ctr.currentPageIndicatorTintColor = [UIColor redColor];
    ctr.pageIndicatorTintColor = [UIColor yellowColor];
    
    [self addSubview:ctr];
    self.pageCtr = ctr;
    [ctr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(30);
    }];
    

}


-(void)setImgArr:(NSArray *)imgArr{
    _imgArr = imgArr;
    
    for (NSInteger i = 0; i<_imgArr.count ; i++) {
        
        UIImageView *img = [[UIImageView alloc] initWithImage:_imgArr[i]];
        img.contentMode = UIViewContentModeScaleAspectFit;
//        [self.scrollView addSubview:img];
        img.frame = CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
    
    [self.scrollView insertSubview:img atIndex:0];
    

    //添加加载更多按钮
    UIButton *moreButton = [[UIButton alloc]
                            init];
    [moreButton setImage:[UIImage imageNamed:@"common_more_black"] forState:UIControlStateNormal];
    [moreButton setImage:[UIImage imageNamed:@"common_more_white"] forState:UIControlStateHighlighted];
    [self.scrollView addSubview:moreButton];
    [moreButton addTarget:self action:@selector(clickMore) forControlEvents:UIControlEventTouchUpInside];
        
        [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(img).offset(-20);
            make.bottom.equalTo(img).offset(-40);
            make.size.mas_equalTo(CGSizeMake(100, 40));
        }];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.bounds.size.width * (kCount + 1), 0);

    self.pageCtr.numberOfPages = _imgArr.count;
}

-(void)clickMore{
    
    //放大着缩小
    [UIView animateWithDuration:3 animations:^{
        self.transform = CGAffineTransformMakeScale(2, 2);
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self.scrollView removeFromSuperview];

    }];
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //计算偏移量获取当前显示的页数
    CGFloat offsetx = scrollView.contentOffset.x;
    CGFloat page = offsetx / self.frame.size.width;
    self.pageCtr.currentPage = (NSInteger)page + 0.5;
    
    //当处于最后一页的时候隐藏
    self.pageCtr.hidden = (NSInteger)page == _imgArr.count;
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //结束滚动并且是最后一页的时候移除视图
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat page = offsetX / self.bounds.size.width;
    NSLog(@"%f",page);
    
    if (page == _imgArr.count){
    
    [self.scrollView removeFromSuperview];
    }
}

@end
