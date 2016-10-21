//
//  ViewController.m
//  音效播放
//
//  Created by codygao on 16/10/17.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
@property(nonatomic,strong)NSMutableDictionary *soudIdCache;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self playSystemSoundWithFileName:@"buyao.caf"];
    
}

-(void)playSystemSoundWithFileName:(NSString*)fileName{
    
    //从系统该内存中取出声音
    SystemSoundID systemId = [[self.soudIdCache valueForKey:fileName] unsignedIntValue];
    if (systemId == 0){
//        
       NSString *filepath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
        NSURL *url = [NSURL fileURLWithPath:filepath];
//        
            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &systemId);
//            
           [self.soudIdCache setValue:@(systemId) forKey:fileName];
  }
    AudioServicesPlayAlertSound(systemId);
  

    
}

-(void)didReceiveMemoryWarning{
    //销毁存放在内存的系统音效释放
    for(NSNumber *number in self.soudIdCache.allValues){
        AudioServicesDisposeSystemSoundID([number unsignedIntValue]);
    }
    self.soudIdCache = nil;
}

-(NSMutableDictionary *)soudIdCache{
    if (_soudIdCache == nil){
        _soudIdCache = [NSMutableDictionary dictionary];
    }
    return  _soudIdCache;
}

@end
