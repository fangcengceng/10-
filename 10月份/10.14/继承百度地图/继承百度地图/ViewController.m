//
//  ViewController.m
//  继承百度地图
//
//  Created by codygao on 16/10/14.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "ViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入搜索功能所有的头文件

@interface ViewController ()<BMKMapViewDelegate, BMKPoiSearchDelegate>


@end

@implementation ViewController{
    BMKMapView *_mapView;
    BMKPoiSearch *_searcher;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    self.view = _mapView;
    //POI查询的前提是必须加载完成地图，解决办法是设置延时或者设置响应时间
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        //初始化检索对象
        _searcher = [[BMKPoiSearch alloc] init];
        _searcher .delegate = self;
        //发起检索
         BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    
        //分页索引
        option.pageIndex = 0;
        option.pageCapacity = 10;
        option.location = CLLocationCoordinate2DMake(39, 116);
        option.keyword = @"小吃";
        BOOL flag = [_searcher poiSearchNearBy:option];
        if (flag){
            NSLog(@"周边搜索发送成功");
            
        }else{
            NSLog(@"周边搜索失败");
        }

    
    });
    
}
//实现POIsearchDelegate回调
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        //        NSLog(@"%d", poiResultList.currPoiNum);
        for (BMKPoiInfo *info in poiResultList.poiInfoList) {
            BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
            annotation.coordinate = info.pt;
            annotation.title = info.name;
            [_mapView addAnnotation:annotation];
        }
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
    } else {
        NSLog(@"抱歉，未找到结果");
    }
}

- (void)viewDidAppear:(BOOL)animated {
    // 添加一个PointAnnotation
    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = 39.915;
    coor.longitude = 116.404;
    annotation.coordinate = coor;
    annotation.title = @"这里是北京";
    [_mapView addAnnotation:annotation];
}

//设置大透头枕颜色
// Override
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注滑落动作
        return newAnnotationView;
    }
    return nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _searcher.delegate = nil;
    _mapView.delegate = nil; // 不用时，置nil
}


@end
