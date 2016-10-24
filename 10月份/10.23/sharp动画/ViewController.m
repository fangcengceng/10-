//
//  ViewController.m
//  sharp动画
//
//  Created by codygao on 16/10/23.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}
-(void)setupUI{
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    //绘制贝塞尔路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    CGPoint endPoint = CGPointMake(self.view.frame.size.width, self.view.frame.size.height);
    [path addLineToPoint:endPoint];
    
    //设置图层属性
    layer.path = path.CGPath;
    layer.lineWidth = 5;
    layer.strokeColor = [UIColor redColor].CGColor;
    //添加图形
    [self.view.layer addSublayer:layer];
    
    //图层动画不能使用块动画
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    anim.fromValue = @0;
    anim.toValue = @0.8;
    anim.duration = 2;
    anim.removedOnCompletion = NO;
    anim.fillMode = @"forwards";
    
    [layer addAnimation:anim forKey:nil];
    
    
    
}


@end
