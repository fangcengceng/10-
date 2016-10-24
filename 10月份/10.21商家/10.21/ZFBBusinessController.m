//
//  ZFBBusinessController.m
//  10.21
//
//  Created by codygao on 16/10/21.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ZFBBusinessController.h"
#import "YYModel.h"
#import "BusinessModel.h"
#import "ZFBBusinessView.h"

@interface ZFBBusinessController ()<ZFBBusinessViewDelegate>

@end

@implementation ZFBBusinessController{
    NSArray *_businessList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self  loadData];
    [self setupUI];
    
}

-(void)setupUI{
    
    ZFBBusinessView *view = [[ZFBBusinessView alloc] init];
    view.frame = CGRectMake(0, 0, self.view.bounds.size.width, 128);
    view.delegate = self;
    view.array = _businessList;
    [self.view addSubview:view];

}

-(void)loadData{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"businessType.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    _businessList = [NSArray yy_modelArrayWithClass:[BusinessModel class] json:array];
    
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSDictionary *dic in array){
        BusinessModel *model = [[BusinessModel alloc] initWithDic:dic];
        [tempArr addObject:model];
    }
    
}

#pragma mark ---执行代理方法
-(void)DidselectModel:(ZFBBusinessView *)view model:(BusinessModel *)model{
    
    NSLog(@"%@",model.name);
}

@end
