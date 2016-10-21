//
//  GEOcodeController.m
//  地理编码
//
//  Created by codygao on 16/10/10.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "GEOcodeController.h"
#import <CoreLocation/CoreLocation.h>

@interface GEOcodeController ()
@property (weak, nonatomic) IBOutlet UITextField *inputText;
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation GEOcodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)codeButton:(UIButton *)sender {
    //创建地理编码者
    CLGeocoder *manager = [[CLGeocoder alloc] init];
    
    [manager geocodeAddressString:self.inputText.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        //判断是否有错误
        if (placemarks.count == 0 || error ){
            NSLog(@"%@",error);
            return ;
        }
        
        //获取地标对象,地标对象中有关于地理信息和人文信息的所有东西
        CLPlacemark *mark = placemarks.lastObject;
        
        self.latitudeLabel.text = @( mark.location.coordinate.latitude).description;
        self.longLabel.text = @(mark.location.coordinate.longitude).description;
        self.detailLabel.text = mark.name;
        
    }];
    
    
    
    
    
    
}




@end
