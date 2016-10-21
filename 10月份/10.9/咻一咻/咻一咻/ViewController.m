//
//  ViewController.m
//  咻一咻
//
//  Created by codygao on 16/10/8.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import "咻一咻-swift.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *redView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    UIButton *button = [[UIButton alloc] init];
    [button addTarget:self action:@selector(xiuxiuAction:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:@"alipay_msp_op_success"] forState:UIControlStateNormal];
    [button sizeToFit];
    button.center = self.view.center;
    
    [self.view addSubview:button];
    
}

-(void)xiuxiuAction:(UIButton*)btn {
     __block int count = 0;
    btn.enabled = NO;
    
    
    for (int i = 0; i < 3; i++) {
        
        UIView * circleView = [self circle];
//        [self.view addSubview:circleView ];
        circleView.backgroundColor = [UIColor colorWithRed:70 / 255.0 green:105 / 255.0 blue:146 / 255.0 alpha:1.0];

        [self.view insertSubview:circleView atIndex:0];
     [UIView animateKeyframesWithDuration:3 delay:i options:0 animations:^{
         circleView.transform = CGAffineTransformMakeScale(8, 8);
         circleView.alpha = 0;

     } completion:^(BOOL finished) {
         [circleView removeFromSuperview];
         count++;
         if (count==2){
             btn.enabled = YES;
         }
         
         
     }];
        
        
    }
    
    
    
}


-(UIView*)circle{
    UIView *circleView = [[UIView alloc] init];
    circleView.center = self.view.center;
    circleView.bounds = CGRectMake(0, 0, 100, 100);
    circleView.layer.cornerRadius = 50;
    circleView.layer.masksToBounds = true;
      circleView.backgroundColor = [UIColor colorWithRed:85/255.0 green:166/255.0 blue:238/255.0 alpha:1];
    
    return circleView;
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [UIView animateWithDuration:8 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:1 options:0 animations:^{
        _redView.frame = CGRectMake(0, 0, 100, 100);
        
    } completion:^(BOOL finished) {
        [_redView removeFromSuperview];
        
    }];
    
  
}

@end
