//
//  AroundMapViewController.m
//  DaoJia
//
//  Created by Macx on 16/2/19.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "AroundMapViewController.h"
#import <MapKit/MapKit.h>
#import "MyAnotation.h"


@interface AroundMapViewController () <MKMapViewDelegate>
{
    MKMapView *_mapView;
    NSMutableArray *_coordinateArr;
    BOOL isCenterSelf;
}
@end

@implementation AroundMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isCenterSelf = YES;
    // Do any additional setup after loading the view.
    
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    _mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    _mapView.mapType = MKMapTypeStandard;
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];

    [self request];
}

#pragma mark - 地图代理
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    //第一次定位到自己
    if (!isCenterSelf) {
        MKCoordinateSpan span=MKCoordinateSpanMake(0.01, 0.01);
        MKCoordinateRegion region=MKCoordinateRegionMake(userLocation.location.coordinate, span);
        [_mapView setRegion:region animated:YES];
        isCenterSelf = !isCenterSelf;
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MyAnotation class]]) {
        static NSString *key = @"annotation1";
        MKAnnotationView *annotationView = [_mapView dequeueReusableAnnotationViewWithIdentifier:key];
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:key];
            annotationView.canShowCallout=YES;//允许交互点击
            annotationView.calloutOffset=CGPointMake(0, 1);//定义详情视图偏移量
            annotationView.leftCalloutAccessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ico_auxiliary_city_on"]];//定义详情左侧视图
        }
        
        annotationView.annotation=annotation;
        annotationView.image= [UIImage imageNamed:@"ico_auxiliary_city_on"]; //设置大头针视图的图片
        
        return annotationView;
    }else {
        return nil;
    }
}

#pragma mark - 请求数据
- (void)request {
    NSDictionary *params = @{
                             @"city_id" : @"600010000",
                             @"cat_ids" : @"326",
                             @"location" : [NSString stringWithFormat:@"%lf,%lf", self.longitude, self.latitude],
                             @"radius" : @"3000"
                             };
    [RequestManager requestNuomiWithURL:@"http://apis.baidu.com/baidunuomi/openapi/searchdeals" params:[params mutableCopy] success:^(id result) {
        [self parseResult:result];
    }];
}

#pragma mark - 数据解析
- (void)parseResult:(id)result {
//    if (!_coordinateArr) {
//        _coordinateArr = [NSMutableArray array];
//    }
    
    NSDictionary *resultDic = result[@"data"];
    NSArray *arr = resultDic[@"deals"];
    for (NSDictionary *dic in arr) {
        
        NSString *title = dic[@"title"];
        NSString *score = [NSString stringWithFormat:@"%@", dic[@"score"]];
        
        NSDictionary *shop = [dic[@"shops"] firstObject];
        double longitude = [[shop objectForKey:@"longitude"] doubleValue];
        double latitude = [[shop objectForKey:@"latitude"] doubleValue];
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        
        MyAnotation *anotation = [[MyAnotation alloc] init];
        anotation.coordinate = coordinate;
        anotation.title = title;
        anotation.subTitle = score;
        [_mapView addAnnotation:anotation];
    }
    
    [_mapView reloadInputViews];
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
