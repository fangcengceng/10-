//
//  ViewController.m
//  新特性界面
//
//  Created by codygao on 16/10/12.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import "NewFeatureView.h"
@interface ViewController ()
@property(nonatomic,assign)BOOL hasNewfeature;
//@property(nonatomic,copy)

@end

@implementation ViewController{
    NSArray<UIImage*> *_imgArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _hasNewfeature = YES;
    [self loadImages];
    
    [self setupUI];
  
 
    
    }

    
    
-(void)setupUI{
    
    //添加主图
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cozy-control-car"]];
    img.frame = self.view.frame;
    [self.view addSubview:img];
    img.contentMode = UIViewContentModeScaleAspectFit;
    
    //添加新特性界面
    if (_hasNewfeature){
        NewFeatureView *featureview = [[NewFeatureView alloc] init];
        featureview.frame = self.view.frame;
        [self.view addSubview:featureview];
        featureview.imgArr = _imgArr;

      }


}

-(void)loadImages{
    
    NSMutableArray<UIImage*> *tempArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 4; i++){
        
        UIImage *image = [UIImage imageNamed:[ NSString stringWithFormat:@"common_h%ld",i+1]];
        
        
        //将图片添加到数组中去
        [tempArray addObject:image];
        
    }
    
    _imgArr = tempArray.copy;
    
    
    
}



@end
