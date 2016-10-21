//
//  ViewController.m
//  HearoList
//
//  Created by codygao on 16/10/19.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import "HearoList.h"
#import "YYModel.h"

static NSString *cellId = @"cellid";
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak)UITableView *tv;

@end

@implementation ViewController{
    NSArray<HearoList*> *_arrayList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self setupUI];





}
//界面搭建
-(void)setupUI{
    
    UITableView *tv = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [tv registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    
    [self.view addSubview:tv];
    self.tv = tv;
    tv.delegate = self;
    tv.dataSource = self;

}

#pragma mark ---UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrayList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    cell.textLabel.text = _arrayList[indexPath.row].name;
    cell.detailTextLabel.text = _arrayList[indexPath.row].intro;
    cell.imageView.image = [UIImage imageNamed:_arrayList[indexPath.row].icon];
    return cell;
    
}
//加载数据
-(void)loadData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"heros.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
//    yymodel 方法字典转模型
//    NSArray *yyArr = [NSArray yy_modelArrayWithClass:[HearoList class] json:array];
//    NSLog(@"%lu",(unsigned long)yyArr.count);
    
    
    //字典转模型
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:array.count];

    for (NSDictionary *dic in array){
        HearoList *hero = [[HearoList alloc] initWithDic:dic];
        [tempArr addObject:hero];
        
    }
    _arrayList = tempArr.copy;
}



@end
