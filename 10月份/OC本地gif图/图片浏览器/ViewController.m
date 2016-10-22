//
//  ViewController.m
//  图片浏览器
//
//  Created by codygao on 16/10/9.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import "FCCPicture.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *indexLabel;

@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageVIew;

@end

@implementation ViewController{
    NSArray<FCCPicture*> * _arrayList;
    NSInteger _index;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    _index = 0;
    //一开始就要让东西显示
    [self setupUI];
    
    
    
}

-(void)setupUI{
    
    //给imgeView设置图片
    [self loadImageArr:_arrayList[_index].icon count:[_arrayList[_index].count integerValue]];
    
    //给indexLabel设置内容
    
    
    self.indexLabel.text = [NSString stringWithFormat:@"%zd / %zd",_index, _arrayList.count];
    
    //给描述text设置文字
    self.desLabel.text = [NSString stringWithFormat:@"%@",_arrayList[_index].desc];
    
    
    
    
}


- (IBAction)nextLabel:(UIButton*)sender {
    sender.enabled = (_index != _arrayList.count - 1);
    
    [self setupUI];
   
    _index++;
    
    
    
    
    
    
}
- (IBAction)previouseButton:(UIButton*)sender {
    _index--;

    sender.enabled = _index != 0;
    [self setupUI];
}

-(void)loadData{
    //加载plist路径两种方法
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"images.plist" withExtension:nil];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"images.plist" ofType:nil];
    
    //将路径中的内容转化歘来两种方法
    NSArray *pathArr = [NSArray arrayWithContentsOfFile:path];
    NSArray *urlArr = [NSArray arrayWithContentsOfURL:url];
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:pathArr.count];
    
    //遍历数组
    for ( NSDictionary *dic  in pathArr) {
        FCCPicture *picture = [FCCPicture pictureWithDic:dic];
        
        [tempArray addObject:picture];

    
    }
    _arrayList = tempArray;
  
}

//加载gif图片;
-(void)loadImageArr:(NSString*)preName count:(NSInteger)count{
    
    NSMutableArray *tempImages = [NSMutableArray arrayWithCapacity:count];
    for(NSInteger i = 0; i<count; i++){
        //获取本地图片路径
        NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@%03zd",preName,i+1] ofType:@"png"];
        //根据路径转化为imge图片
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        //将单张图片存储到数组中
        
        [tempImages addObject:image];
        
        //将图片数组转化为一张图片
        UIImage *gifImage = [UIImage animatedImageWithImages:tempImages duration:count*0.1];
        
        //将图片赋值给imgeView
        self.imageVIew.image = gifImage;
        
    }
    
    
}






@end
