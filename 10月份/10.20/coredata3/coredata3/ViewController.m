//
//  ViewController.m
//  coredata3
//
//  Created by codygao on 16/10/19.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Person+CoreDataClass.h"

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
    NSManagedObjectContext *moc = self.appdelegate.persistentContainer.viewContext;
    //指定查询的排序字段
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    

    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:moc sectionNameKeyPath:nil cacheName:nil];

    //开始查询
    [self.fetchedResultsController performFetch:NULL];
    //查询代理
    self.fetchedResultsController.delegate = self;
    
    
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView reloadData];
}



//创建联系人
- (IBAction)newPerson:(id)sender {
    UIAlertController *ctr = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [ctr addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入联系人";
    }];
    [ctr addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入电话";
    }];
    [ctr addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    
    [ctr addAction:[UIAlertAction actionWithTitle:@"save" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //上下文
        NSManagedObjectContext *moc = self.appdelegate.persistentContainer.viewContext;
        Person *p = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:moc];
        
        p.name = ctr.textFields[0].text;
        p.age = ctr.textFields[1].text.intValue;
        
        //保存到数据库
        [self.appdelegate saveContext];
        NSString *path = NSHomeDirectory();
        NSLog(@"%@",path);

    }]];
    
    [self presentViewController:ctr animated:YES completion:nil];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.fetchedResultsController.fetchedObjects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    Person *p = self.fetchedResultsController.fetchedObjects[indexPath.row];
    cell.textLabel.text = p.name;
    return cell;
}

//选中某一行修改
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Person *p = self.fetchedResultsController.fetchedObjects[indexPath.row];
    p.name = [NSString stringWithFormat:@"zhangsan--%zd",arc4random_uniform(100)];
    
    [self.appdelegate saveContext];
}

//删除某一行
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        Person *p = self.fetchedResultsController.fetchedObjects[indexPath.row];
        [self.appdelegate.persistentContainer.viewContext deleteObject:p];
        [self.appdelegate saveContext];
    }
    
    
    
}



@end
