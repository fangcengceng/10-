//
//  MainController.m
//  支付宝口碑
//
//  Created by codygao on 16/10/20.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "MainController.h"
#import "YYModel.h"
#import "BusinessModel.h"
#import "HeaderView.h"
#import "FooterView.h"
#import "ZFBTableViewCell.h"
@interface MainController ()
@property(nonatomic,strong)NSArray *headerArr;

@end

@implementation MainController{
    NSArray<BusinessModel*> *_arrayList;
}
//懒加载headerArr
-(NSArray *)headerArr{
    
    if (_headerArr == nil){
        
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSInteger i = 1; i<5; i++){

            UIImage *imge = [UIImage imageNamed:[NSString stringWithFormat:@"business_ad_%03zd",i]];
           
            
            [tempArr addObject:imge];
            
        }
        
        _headerArr = tempArr;
        
        
   }
    return _headerArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付宝";

    [self loadData];

    [self setupUI];

}
-(void)setupUI{
    
    
    [self.tableView registerClass:[ZFBTableViewCell class] forCellReuseIdentifier:@"cell"];
    //头部试图
    HeaderView *headerV = [[HeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1000)];
    headerV.imgArr = self.headerArr;
    
    self.tableView.tableHeaderView = headerV;
    
    //尾部视图
    FooterView *footerV = [[FooterView alloc] init];
    footerV.bounds = CGRectMake(0, 0, 0, 40);
    self.tableView.tableFooterView = footerV;
    
    footerV.myBlock = ^{
        NSLog(@"我是闭包回调过来的");
    };

}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _arrayList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     ZFBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    BusinessModel *model = _arrayList[indexPath.row];
    [cell setBusinessmodel:model];
    
    return cell;
}



//加载数据
-(void)loadData{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"business.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    _arrayList = [NSArray yy_modelArrayWithClass:[BusinessModel class] json:array];
    
}




@end
