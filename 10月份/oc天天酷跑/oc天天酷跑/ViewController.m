//
//  ViewController.m
//  oc天天酷跑
//
//  Created by codygao on 16/10/10.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import "Hmapps.h"
#import "HMappView.h"

@interface ViewController ()

@end

@implementation ViewController{
    //保存模型数组
    NSArray<Hmapps*> *_arrList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];

    [self setupUI];
    
}

-(void)setupUI{

    CGFloat width = 60;
    CGFloat height = 110;
    NSInteger column = 3;   //总列数
    
    CGFloat xMargin = 10;  //水平间距
    CGFloat yMaring = 10;  //垂直间距
    CGFloat topMarin = 20;  //上间距
    
    //左间距 ＝（屏幕的宽度 - 3*appView宽度 - 2*水平间距）/2
    CGFloat leftMargin = (self.view.frame.size.width - column * width - (column - 1) * xMargin) / 2;
    for (NSInteger i = 0; i < _arrList.count -1; i++) {
     
       
        

        //列数 ＝ i % column
        NSInteger col = i % column;
        
        //x = 左间距 + （宽度 + 水平间距）*列数
        CGFloat x = leftMargin + (width + xMargin) * col;
        
        //行号 ＝ i / column;
        NSInteger row = i /column;
        
        //y = 上间距 + (高度 + 垂直间距) * 行号
        CGFloat y = topMarin + (height + yMaring) *row;
        
        //设置控件的frame
          HMappView *view = [HMappView appView];
        view.frame = CGRectMake(x, y, width, height);

        
        
        
        
      
        [self.view addSubview:view];
        Hmapps *model = _arrList[i];
        view.appmodel = model;
        
        
    }
    
    
   

}


- (void)loadData {
    //生成路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"apps.plist" ofType:nil];
    
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray *temparr = [NSMutableArray arrayWithCapacity:arr.count];
    //遍历数组
    for (NSDictionary *dic in arr) {
        Hmapps *model = [Hmapps appWithDic:dic];
        
        [temparr addObject:model];
        _arrList = temparr;
    }
   
    
    

    
}


@end
