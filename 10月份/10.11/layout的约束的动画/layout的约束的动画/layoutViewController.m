//
//  layoutViewController.m
//  layout的约束的动画
//
//  Created by codygao on 16/10/11.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "layoutViewController.h"

@interface layoutViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLayout;

@end

@implementation layoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftLayout.constant = 20;
    
    [UIView animateWithDuration:1 animations:^{
        [self.view layoutIfNeeded];
    }];






}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
