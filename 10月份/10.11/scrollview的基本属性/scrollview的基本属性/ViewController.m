//
//  ViewController.m
//  scrollview的基本属性
//
//  Created by codygao on 16/10/11.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,weak)UIScrollView *scrView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //scrollview的创建
    UIScrollView *scrView = [[UIScrollView alloc] init];
    
    scrView.frame = self.view.frame;
    
    [self.view addSubview:scrView];
    self.scrView = scrView;
    
    //创建图片对象
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"001"]];
    [scrView addSubview:img];
    scrView.contentSize = img.frame.size;
    
    //创建button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.center = self.view.center;
    [self.view addSubview:button];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];


    //设置scrollview的内边距
    scrView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
   NSLog(@"%@",NSStringFromCGRect(self.scrView.bounds));



}

-(void)click:(UIButton*)sender{
    self.scrView.contentOffset = CGPointMake(300, 300);
    NSLog(@"%@",NSStringFromCGRect(self.scrView.bounds));

//    2016-10-11 23:15:59.628 scrollview的基本属性[704:22226] {{0, 0}, {414, 736}}
//    {{300, 300}, {414, 736}}
}



@end
