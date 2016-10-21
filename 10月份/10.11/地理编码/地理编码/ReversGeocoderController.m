//
//  ReversGeocoderController.m
//  地理编码
//
//  Created by codygao on 16/10/10.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ReversGeocoderController.h"
#import <CoreLocation/CoreLocation.h>

@interface ReversGeocoderController ()
@property (weak, nonatomic) IBOutlet UITextField *longtext;
@property (weak, nonatomic) IBOutlet UITextField *latitudeText;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation ReversGeocoderController

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (IBAction)decodeButton:(UIButton *)sender {
    //创建地理编码管理者
    CLGeocoder *manager = [[CLGeocoder alloc] init];
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:[self.latitudeText.text floatValue] longitude:[self.longtext.text doubleValue]];

    
    //调用反编码方法
    [manager reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
       
//        判断地理坐标数组不存在就返回
        if (placemarks.count == 0 || error){
            NSLog(@"%@",error);
            return ;
        }
        
        
        //创建地标对象
        CLPlacemark *mark = placemarks.lastObject;
        
        NSString * text = [NSString stringWithFormat:@"%@   %@",mark.name,mark.thoroughfare];
        self.addressLabel.text = text;
        
        
        
        
    }];
    
    
    
    
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
