//
//  ViewController.m
//  CarsListOC
//
//  Created by codygao on 16/10/20.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import "YYModel.h"
#import "CarsModel.h"
#import "DeatailCars.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSArray<CarsModel*> *_carsList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  _carsList.count;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _carsList[section].cars.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];

    NSArray<DeatailCars*> *array = _carsList[indexPath.section].cars;

    cell.imageView.image = [UIImage imageNamed:array[indexPath.row].icon];
    cell.textLabel.text = array[indexPath.row].name;
    return cell;
}
//组头
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    CarsModel *model = _carsList[section];
    return model.title;
    
}
//右侧索引
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [_carsList valueForKey:@"title"];
}


-(void)loadData{

    NSString *path = [[NSBundle mainBundle] pathForResource:@"cars_total.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    
    NSArray *tempArr = [NSArray yy_modelArrayWithClass:[CarsModel class] json:array];
    _carsList = tempArr;
    
}




@end
