//
//  ViewController.m
//  coredata快速体验1
//
//  Created by codygao on 16/10/19.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Person.h"

@interface ViewController ()
//
@property(nonatomic,weak)AppDelegate *delegate;

//查询结果控制器
@property(nonatomic,strong)NSFetchedResultsController *fetchedResultController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;

    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person" ];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    self.fetchedResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.delegate.managedObjectContext sectionNameKeyPath:nil cacheName:nil];



}
- (IBAction)newPerson:(id)sender {
    
    
    UIAlertController *ctr = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [ctr addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入姓名";
    }];
    [ctr addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入电话";
    }];
    
    [ctr addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [ctr addAction:[UIAlertAction actionWithTitle:@"save" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        NSManagedObjectContext *context = self.delegate.managedObjectContext;
        
        Person *p = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:context];
        p.name = @"zhangsan";
        p.age = @(12);
        
        [self.delegate saveContext];
        [self.tableView reloadData];
 
        
    }]];
    
    
    [self presentViewController:ctr animated:YES completion:nil];
    
}


#pragma mark 代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _fetchedResultController.fetchedObjects.count;
  
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    

    Person *person = _fetchedResultController.fetchedObjects[indexPath.row];
    
    cell.textLabel.text = person.name;
    return  cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
