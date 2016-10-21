//
//  ViewController.m
//  蓝牙
//
//  Created by codygao on 16/10/18.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>


@interface ViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate>
//创建一个中心管理者
@property(nonatomic,strong)CBCentralManager *mgr;
//扫面按钮
@property (weak, nonatomic) IBOutlet UIButton *button;
//连接的外设
@property(nonatomic,strong)CBPeripheral *peripheral;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.button.enabled = NO;
    
    //1、创建中心管理者
    self.mgr = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
    
}
//监听按钮的点击事件
- (IBAction)scanButton:(id)sender {
    
//    2、扫描外部设备
    [self.mgr scanForPeripheralsWithServices:nil options:nil];
    
}
#pragma   CBCentralManagerDelegate代理方法
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI{
    //3、有选择性的连接外设
    NSString *peripheralLocalName = advertisementData[CBAdvertisementDataLocalNameKey];
    //匹配需求的外设
    if([peripheralLocalName isEqualToString:@"外部设备"]){
        //连接设备
        [self.mgr connectPeripheral:peripheral options:nil];
        //进行连接操作，必须强引用需要连接的外设
        self.peripheral = peripheral;
    }
    
}

//4、已经连接到外设后调用的该方法
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    [peripheral discoverServices:nil];
    peripheral.delegate = self;
    
}



//作为中心的蓝牙设备已经更新状态后调用
-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    //蓝牙状态打开时才能扫面外部设备
    if (self.mgr.state == CBCentralManagerStatePoweredOn ){
        //
        self.button.enabled = YES;
    }
    
}


#pragma mark --CBPeripheralDelegate
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    //从外设的服务中匹配需求中的服务
    for (CBService *service in peripheral.services){
        //查找需求的服务中的特征
        [peripheral discoverCharacteristics:nil forService:service];
    }
    
}

//已经超照到服务中的特征调用
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    //查找服务中匹配的特征
    for(CBCharacteristic *characteristic in service.characteristics){
        if ([characteristic.UUID.UUIDString isEqualToString:@"B71E"]){
            //读取数据
            [peripheral readValueForCharacteristic:characteristic];
            
        }
    }
}
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    NSData *data = characteristic.value;
    NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    NSString *str = @"hello";

    //写入数据
    [peripheral writeValue:[str dataUsingEncoding:NSUTF8StringEncoding] forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
    
}

-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    if (error){
        NSLog(@"发送失败%@",error);
    }else{
        NSLog(@"发送成功");
    }
    
}

@end
