//
//  ViewController.m
//  版本兼容
//
//  Created by codygao on 16/10/20.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import "HMCoreDataManager.h"
#import "City+CoreDataClass.h"

@interface ViewController ()<NSFetchedResultsControllerDelegate>
@property(nonatomic,strong)HMCoreDataManager *mgr;
@property(nonatomic,strong)NSFetchedResultsController *fetchedResultsController;
@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    self.mgr = [HMCoreDataManager sharedManager];

    NSFetchRequest *request = [City fetchRequest];
    
    request.sortDescriptors =@[ [NSSortDescriptor sortDescriptorWithKey:@"cityname" ascending:YES]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.mgr.moc sectionNameKeyPath:nil cacheName:nil];
    
    [self.fetchedResultsController performFetch:nil];
    
    self.fetchedResultsController.delegate = self;


}
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    
    [self.tableView reloadData];
}


- (IBAction)newCity:(id)sender {
    
    UIAlertController *ctr = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [ctr addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        NSLog(@"请输入城市名");
    }];
    
    [ctr addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [ctr addAction:[UIAlertAction actionWithTitle:@"save" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        City *city = [NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:self.mgr.moc];
        
        city.cityname = ctr.textFields.lastObject.text;
        
        [self.mgr saveContext];

    }]];
    [self presentViewController:ctr animated:YES completion:nil];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.fetchedResultsController.fetchedObjects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    City *city = self.fetchedResultsController.fetchedObjects[indexPath.row];
    cell.textLabel.text = city.cityname;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    City *city = self.fetchedResultsController.fetchedObjects[indexPath.row];
    city.cityname = @"北京";
    [self.mgr saveContext]; 
}


@end
