//
//  ViewController.m
//  获取通讯录
//
//  Created by codygao on 16/10/14.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <ContactsUI/ContactsUI.h>

@interface ViewController ()<CNContactPickerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //获取系统通讯录
    CNContactPickerViewController *contact = [[CNContactPickerViewController alloc] init];
    contact.delegate = self;
    [self presentViewController:contact animated:YES completion:nil];

}


//代理
-(void)contactPickerDidCancel:(CNContactPickerViewController *)picker{
    NSLog(@"%s",__func__);
}
-(void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
    NSLog(@"%s",__func__);
    //获取姓名
    NSString *givenName = contact.givenName;
    //获取电话
    for (CNLabeledValue *value in contact.phoneNumbers){
        CNPhoneNumber *phone = value.value;
        NSLog(@"%@",phone.stringValue);
    }
    
    
    

}
//-(void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty{
//    
//    NSLog(@"%s",__func__);
//    CNPostalAddress *address = contactProperty.value;
//    NSLog(@"%@",address);
//    
//    NSLog(@"%@",[contactProperty.value class]);
////    NSLog(@"%@",contactProperty.contact);
////    NSLog(@"%@",contactProperty.key);
//    
//    
//
//}
//-(void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact *> *)contacts{
//    NSLog(@"%s",__func__);
//
//}
//-(void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperties:(NSArray<CNContactProperty *> *)contactProperties{
//    NSLog(@"%s",__func__);
//
//}
@end
