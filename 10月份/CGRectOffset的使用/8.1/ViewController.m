//
//  ViewController.m
//  8.1
//
//  Created by codygao on 16/10/8.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,weak) UIView* centerbutton;
@property(nonatomic,weak)UIImageView *pictureImag;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建imgage图片
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"father001"]];
    imgView.frame = CGRectMake(0, 0, 100, 100);
    [self.view addSubview:imgView];
    self.pictureImag = imgView;
    

    //创建中心按钮
//    1、确定中心点
    CGPoint btnCenter = CGPointMake(imgView.center.x, imgView.center.y + 200);
    UIView *redView = [[UIView alloc] init];
    redView.frame = CGRectMake(btnCenter.x, btnCenter.y, 40, 40);
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    self.centerbutton = redView;
    
    //创建按钮
    
    [self addchildButton:@"right_normal" offsetX:40 offsetY:0 tag:1];
    [self addchildButton:@"left_normal" offsetX:-40 offsetY:0 tag:2];
    
    [self addchildButton:@"top_normal" offsetX:0 offsetY:-40 tag:3];
    [self addchildButton:@"bottom_normal" offsetX:0 offsetY:40 tag:4];
    
}

-(void)addchildButton:(NSString*)imgeName offsetX:(CGFloat)x offsetY:(CGFloat)y tag:(int)tag{
    UIButton * button = [[UIButton alloc] init];
    //添加点击事件
    [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [button setImage:[UIImage imageNamed:imgeName] forState:UIControlStateNormal];
    button.frame = CGRectOffset(self.centerbutton.frame, x, y);
    button.tag = tag;
    
    [self.view addSubview:button];
    
    
    
    
}
-(void)btnAction:(UIButton*)btn{
    
    
    switch (btn.tag) {
        case 1:
            self.pictureImag.transform = CGAffineTransformTranslate(self.pictureImag.transform, 20, 0);
            break;
            
        case 2:
            self.pictureImag.transform = CGAffineTransformTranslate(self.pictureImag.transform, -20, 0);
            break;
        case 3:
            btn.transform = CGAffineTransformTranslate(btn.transform, 0, -20);
            break;
        case 4:
            btn.transform = CGAffineTransformTranslate(btn.transform, 0, 20);
            break;
            
        default:
            [UIView animateWithDuration:0.3 animations:^{
                
//                self.pictureImag.transform = CGAffineTransformTranslate(self.pictureImag.transform, 0, 20);
            } completion:^(BOOL finished) {
                [self.pictureImag removeFromSuperview];
                
            }];
            break;
    }
}


@end
