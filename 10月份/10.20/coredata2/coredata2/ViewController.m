//
//  ViewController.m
//  coredata2
//
//  Created by codygao on 16/10/19.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import "Person+CoreDataProperties.h"
#import "AppDelegate.h"

@interface ViewController ()<NSFetchedResultsControllerDelegate>
@property(nonatomic,weak)AppDelegate *appdelegate;
@property(nonatomic,strong)NSFetchedResultsController *fetchedResultsController;

@end


@implementation ViewController

-(AppDelegate *)appdelegate{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSFetchRequest *request = [Person fetchRequest];
    
    //查询请求的排序字段
    NSManagedObjectContext *context = self.appdelegate.persistentContainer.viewContext;
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    
    //查询数据
    [self.fetchedResultsController performFetch:nil];
    
    //查询代理
    self.fetchedResultsController.delegate = self;

}

#pragma mark ----NSFetchedResultsControllerDelegate
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView reloadData];
}



//创建person事件
- (IBAction)newPeron:(id)sender {
    
    UIAlertController *ctr = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    //增减输入框
    [ctr addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入姓名";
    }];
    [ctr addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入电话";
    }];
    
    [ctr addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [ctr addAction:[UIAlertAction actionWithTitle:@"save" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        //创建person
        NSManagedObjectContext *context = self.appdelegate.persistentContainer.viewContext;
        
        Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
        person.name = ctr.textFields[0].text;
        person.age = ctr.textFields[1].text.intValue;
        
        [self.appdelegate saveContext];
        
    }]];
    
    [self presentViewController:ctr animated:YES completion:nil];
    

}


#pragma mark ------datasource 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _fetchedResultsController.fetchedObjects.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Person *p = _fetchedResultsController.fetchedObjects[indexPath.row];
    cell.textLabel.text = p.name;
    return  cell;
}

//选中某一行后修改
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Person *person = self.fetchedResultsController.fetchedObjects[indexPath.row];
    person.name = [NSString stringWithFormat:@"zhangsan%zd",arc4random_uniform(100)];
    [self.tableView reloadData];
    
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        //管理上下文删除对象
        Person *p = self.fetchedResultsController.fetchedObjects[indexPath.row];
        
        NSManagedObjectContext *moc = self.appdelegate.persistentContainer.viewContext;
        
        [moc deleteObject:p];
        [self.appdelegate saveContext];
        
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
