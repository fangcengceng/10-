//
//  HMPreviouView.m
//  二维码边框
//
//  Created by codygao on 16/10/18.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "HMPreviouView.h"

@interface HMPreviouView ()
//边框视图
@property(nonatomic,weak)UIImageView *imgView;
//直线视图
@property(nonatomic,weak)UIImageView *lineView;
//定时器
@property(nonatomic,strong)NSTimer *timer;


@end

@implementation HMPreviouView
//类方法，替代返回的主layer
+(Class)layerClass{
    
    return [AVCaptureVideoPreviewLayer class];
}

-(void)setSession:(AVCaptureSession *)session{
    _session = session;
    
    AVCaptureVideoPreviewLayer *layer = (AVCaptureVideoPreviewLayer*)self.layer;
    layer.session = session;

}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self setupUI];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]){
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pick_bg"]];
    imgV.frame = CGRectMake(self.frame.size.width*0.5-140, self.frame.size.height*0.5-140, 280, 280);
    [self addSubview:imgV];
    self.imgView = imgV;
    
    UIImageView *lineV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
    lineV.frame = CGRectMake(30, 10, 220, 10);
    
    [self addSubview:lineV];
    self.lineView = lineV;
    
    //添加NSTimer
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(animationClick) userInfo:nil repeats:YES];
    
    
}

-(void)animationClick{
    
    [UIView animateWithDuration:1 animations:^{
        _lineView.frame = CGRectMake(30, 280, 220, 10);
        
    } completion:^(BOOL finished) {
        _lineView.frame = CGRectMake(30, 10, 220, 10);
    }];
    
    
}


@end
