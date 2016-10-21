//
//  ViewController.m
//  coredata版本兼容最终版
//
//  Created by codygao on 16/10/20.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import "City+CoreDataClass.h"
#import "HMCoreDataManager.h"

@interface ViewController ()<NSFetchedResultsControllerDelegate>
@property(nonatomic,strong)HMCoreDataManager *mgr;
@property(nonatomic,strong)NSFetchedResultsController *fecthRequestController;

@end

@implementation ViewController

-(HMCoreDataManager *)mgr{
    if (_mgr == nil){
        _mgr = [HMCoreDataManager sharedManager];
    }
    return _mgr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSFetchRequest *request = [City fetchRequest];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"cityname" ascending:YES ]];
    
   self.fecthRequestController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.mgr.moc sectionNameKeyPath:nil cacheName:nil];
    [self.fecthRequestController performFetch:NULL];
    self.fecthRequestController.delegate = self;
    
}


-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    [self.tableView reloadData];
}




- (IBAction)newCity:(id)sender {
    
    UIAlertController *ctr = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [ctr addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入城市名";
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
    return _fecthRequestController.fetchedObjects.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    City *city = self.fecthRequestController.fetchedObjects[indexPath.row];
    
    cell.textLabel.text = city.cityname;

    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    City *city = self.fecthRequestController.fetchedObjects[indexPath.row];
    city.cityname = @"beijing";
    [self.mgr saveContext];
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete){
        City *city = self.fecthRequestController.fetchedObjects[indexPath.row];
        [self.mgr.moc deleteObject:city];
        [self.mgr saveContext];
        
    }
    
    
}


@end
