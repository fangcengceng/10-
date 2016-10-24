//
//  ViewController.m
//  coredata多表联动
//
//  Created by codygao on 16/10/21.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import "City+CoreDataClass.h"
#import "HMCoreDataManager.h"
#import "User+CoreDataClass.h"


@interface ViewController ()
@property(nonatomic,strong)NSFetchedResultsController *fectchResult;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self newCityData];
    NSLog(@"%@",NSHomeDirectory());
    [self loadData];

}

-(void)loadData{
    //查询请求
    NSFetchRequest *request = [User fetchRequest];
    NSManagedObjectContext *moc = [HMCoreDataManager sharedManager].moc;
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"username" ascending:YES]];
    request.predicate = [NSPredicate predicateWithFormat:@"city.cityName = %@",@"北京"];  
    //查询结果
    _fectchResult = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:moc sectionNameKeyPath:@"city.cityName" cacheName:nil];
    
    //执行查询
    [_fectchResult performFetch:nil];
    NSLog(@"%zd",_fectchResult.fetchedObjects.count);
    NSLog(@"%zd",_fectchResult.sections.count);
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _fectchResult.sections.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _fectchResult.sections[section].name;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_fectchResult.sections[section] numberOfObjects];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    // 没有分组 - 获取查询到的用户记录
    // User *user = _frc.fetchedObjects[indexPath.row];
    // 分组 - 获取查询到的用户记录
    User *user = [_fectchResult.sections[indexPath.section] objects][indexPath.row];
    
    cell.textLabel.text = user.username;
    
    return cell;
}


-(void)newCityData{
    
    //上下文管理
    NSManagedObjectContext *moc = [HMCoreDataManager sharedManager].moc;
    
    
    NSArray *cityArr = @[@"北京",@"上海",@"广州"];
    for (NSString *cityName in cityArr){
        
        //实例化city对象
        
        City *cityModel = [NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:moc];
        //设置城市属性
        cityModel.cityName = cityName;
        //添加多个用户
        NSInteger count = arc4random_uniform(10) + 5;
        for (NSInteger i = 0; i < count; i++) {
            
            //实例化用户对象
            User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:moc];
            
            //设置用户属性
            user.username = [cityName stringByAppendingFormat:@"%02zd",i];
            //设置城市
            user.city = cityModel;
        }
  
    }
    //事物保存数据
    [[HMCoreDataManager sharedManager] saveContext];
 
}

#pragma mark----UITableViewDatasource
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 1;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return nil;
//}

@end
