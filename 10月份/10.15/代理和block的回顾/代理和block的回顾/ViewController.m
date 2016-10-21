//
//  ViewController.m
//  代理和block的回顾
//
//  Created by codygao on 16/10/14.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import "HMAppView.h"
#import "HMApp.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSArray<HMApp*> *_arrayList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    HMAppView *appView = [HMAppView appView];
    appView.frame = CGRectMake(0, 0, 100, 100);
    appView.center = self.view.center;
    [self.view addSubview:appView];
    
    [self loadDic];
    appView.app = _arrayList[0];
    appView.myblock = ^(HMApp *model,UIButton *button){
        NSLog(@"正在下载%@",model.name);
        button.enabled = NO;
        [button setTitle:@"下载完成" forState:UIControlStateNormal];
        
    };
    
    
    

}

-(void)loadDic{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"apps.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray<HMApp*> *tempArr = [NSMutableArray array];
    //遍历数组转模型
    for (NSDictionary *dic  in array) {
        
        HMApp *model = [[HMApp alloc] initWithDic:dic];
        [tempArr addObject:model];
    }
    _arrayList = tempArr.copy;
    
    
}

@end
