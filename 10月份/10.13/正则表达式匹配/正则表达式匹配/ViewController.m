//
//  ViewController.m
//  正则表达式匹配
//
//  Created by codygao on 16/10/14.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //匹配格式
    //    [self abc];
    //    [self demo1];
    //    [self deom2];
    //    [self demo3];
    //    [self demo4];
    //    [self demo5];
    //    [self demo6];

//截取字符串
    [self substring];
    
}
//匹配
-(void)substring{
    //    练习8:
    //    <html><title>hello</title><img>baby.jpg</img></html>
    //    找寻出 <img> 标签.可以匹配任意字符,*表示匹配任意位,?表示匹配一位
    
    NSString *pattern = @"<img>(.*)</img>";
    NSString *contact = @"<html><title>hello</title><img>baby.jpg</img></html>";
    
    NSRegularExpression *experssion = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSArray *array = [experssion matchesInString:contact options:0 range:NSMakeRange(0, contact.length)];
    NSLog(@"%ld",array.count);
    
    //遍历结果
    for (NSTextCheckingResult *text in array) {
        NSLog(@"%@",text);
        //截取字符串，截取的是contact中的内容
        NSString *str = [contact substringWithRange:NSMakeRange(text.range.location + 5, text.range.length - 11)];
        NSLog(@"%@",str);
        
        
        
    }
    
    
    

}

-(void)demo6{
    //
    //    练习7:手机号码匹配
    //    1.以13/15/17/18
    //    2.长度是11
    //
    //    ^[1][3578][0-9]{9}$
    //    
    //
}

-(void)demo5{
    //
    //    练习6:QQ匹配
    //    1. 5~12位
    //    2. 纯数字
    //    使用$表示匹配的是最后一位,其前边最后一个条件表示最后一位的匹配条件     ^[1-9][0-9]{4,11}$
    NSString *pattern  = @"^[1-9][0-9]{4,10}$";
    NSString *contact = @"123458";
    NSRegularExpression *experrion = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSArray *array = [experrion matchesInString:contact options:0 range:NSMakeRange(0, contact.length)];
    NSLog(@"%ld",array.count);

}

-(void)demo4{
    //
    //    练习5:不能是数字开头
    //
    //    在[]中添加^表示条件取反   ^[^0-9]
    
    NSString *patten = @"^[^0-9]";
    NSString *contact = @"skkk";
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:patten options:0 error:nil];
    NSArray *array = [expression matchesInString:contact options:0 range:NSMakeRange(0, contact.length)];
    NSLog(@"%ld",array.count);
    
}

-(void)demo3{
    //
    //    练习4:必须第一个是字母,字母后面跟上4~9个数字
    //
    //    使用{}表示匹配的范围,{}前边最后一个条件是该范围内数据的要求格式    ^[a-zA-Z][0-9]{4,9}
    NSString *patten = @"^[a-zA-Z][0-9]{4,9}";
    NSString *contact = @"aff222299jhjj00000";
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:patten options:0 error:nil];
    NSArray *array = [expression matchesInString:contact options:0 range:NSMakeRange(0, contact.length)];
    NSLog(@"%@,%ld",array,array.count);
    
    
    
}


-(void)deom2{
    //
    //    练习3:必须第一个是字母,第二个必须是数字
    //
    //    使用^表示匹配的第一位数据   ^[a-zA-Z][0-9]
    NSString *patten = @"^[a-zA-Z][0-9]";
    NSRegularExpression *expession = [NSRegularExpression regularExpressionWithPattern:patten options:0 error:nil];
    
    NSString *contact = @"a2skkk";
    NSArray<NSTextCheckingResult*> *array = [expession matchesInString:contact options:0 range:NSMakeRange(0, contact.length)];
    NSLog(@"%@",array);
    
    NSLog(@"%ld",array.count);
    
    
}


-(void)demo1{
    //
    //    练习2:包含一个小写a~z,后面必须是0~9
    //
    //    使用[]表示一位数据的条件  [a-z][0-9]
    NSString *patten = @"[a-zA-Z][0-9]";
    NSRegularExpression *experssion = [NSRegularExpression regularExpressionWithPattern:patten options:0 error:nil];
    //配匹配的内容
    NSString *contact = @"sldfjdfjlskdjcf9skdfj0djfl9";
    NSArray *array = [experssion matchesInString:contact options:0 range:NSMakeRange(0, contact.length)];
    NSLog(@"%@----%ld",array,array.count);
    
    
    
}



-(void)abc{
    //    练习1:匹配abc
    //
    //    abc
    NSString *patten = @"abc";
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:patten options:0 error:nil];
    NSString *contact = @"sbabcdesf";
    
    NSArray *result = [expression matchesInString:contact options:0 range:NSMakeRange(0, contact.length)];
    NSLog(@"%@---%ld",result,result.count);
    

}

@end
