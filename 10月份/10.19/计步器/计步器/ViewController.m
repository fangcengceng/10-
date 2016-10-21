//
//  ViewController.m
//  计步器
//
//  Created by codygao on 16/10/18.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()
@property(nonatomic,strong)CMPedometer *pedometer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)pedometerfunc{
    self.pedometer = [[CMPedometer alloc] init];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    [self.view addSubview:label];
    
    [self.pedometer startPedometerUpdatesFromDate:[NSDate date] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        label.text = [NSString stringWithFormat:@"%d",[ pedometerData.numberOfSteps intValue]];
    }];
    
}



-(void)setpCount{
    CMStepCounter *count = [[CMStepCounter alloc] init];
    [count startStepCountingUpdatesToQueue:[NSOperationQueue mainQueue] updateOn:2 withHandler:^(NSInteger numberOfSteps, NSDate * _Nonnull timestamp, NSError * _Nullable error) {
        
        if (error){
            NSLog(@"计步器错误");
        }
        
        NSLog(@"%ld",(long)numberOfSteps);
    }];
}
@end
