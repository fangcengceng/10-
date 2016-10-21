//
//  ViewController.m
//  CarsGroup
//
//  Created by codygao on 16/10/15.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import "AppCarsGroup.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import <StoreKit/StoreKit.h>

static NSString *cellid = @"cell";
@interface ViewController ()<UITableViewDataSource>//<SKProductsRequestDelegate>

@end

@implementation ViewController{
    NSArray<AppCarsGroup*> *_arrayList;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadData];
    [self setupUI];
    
}
-(void)setupUI{
    UITableView *tv = [[UITableView alloc] init];
    tv.frame = self.view.frame;
    [self.view addSubview:tv];
    tv.dataSource = self;
    [tv registerClass:[UITableViewCell class] forCellReuseIdentifier:cellid];

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _arrayList[section].cars.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _arrayList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        
    }
    cell.textLabel.text = _arrayList[indexPath.section].cars[indexPath.row];
//    cell.detailTextLabel.text = _arrayList[indexPath.row].desc;
    
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _arrayList[section].title;
}
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return  _arrayList[section].desc;
}

-(void)loadData{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"cars_simple.plist" withExtension:nil];
    
    NSArray *array = [NSArray arrayWithContentsOfURL:url];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        AppCarsGroup *cars = [[AppCarsGroup alloc] initWithDic:dic];
        
        [tempArray  addObject:cars];
    }
    
    _arrayList = tempArray.copy;
    
}

@end
/*
 //应用内购
 -(void)demo1{
 NSString *filePaht =[[NSBundle mainBundle] pathForResource:@"" ofType:nil];
 NSData *data = [NSData dataWithContentsOfFile:filePaht];
 
 NSArray *prodacuts = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
 
 
 //    1、kvc可以获取集合中某个键的数据
 NSArray *product = [prodacuts valueForKeyPath:@"prouductIDs"];
 
 //提交给苹果
 SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithArray:product]];
 [request start];
 request.delegate = self;
 
 
 
 
 }
 
 
 
 
 
 
 
 
 
 
 //指纹识别
 -(void)demo{
 LAContext *context = [[LAContext alloc] init];
 
 if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:
 nil]){
 
 
 [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"申请指纹认证" reply:^(BOOL success, NSError * _Nullable error) {
 if (success){
 NSLog(@"指纹识别成功");
 }else{
 NSLog(@"指纹识别失败");
 }
 
 }];
 }else{
 NSLog(@"机器不支持指纹识别");
 }
 }
 
 
 //指纹识别
 -(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
 //    //创建指纹上线文
 //    LAContext *context = [[LAContext alloc] init];
 //    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil]){
 //
 //
 //    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"sss" reply:^(BOOL success, NSError * _Nullable error) {
 //
 //        if (success){
 //            NSLog(@"指纹识别成功");
 //        }else{
 //            NSLog(@"指纹识别失败");
 //
 //        }
 //
 //       }];
 //
 //
 //    }
 //
 
 }
 
 

 
 
 
 
 
 */




