//
//  MapViewController.m
//  DaoJia
//
//  Created by Macx on 16/2/19.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "DealModel.h"
#import "MyAnotation.h"

@interface MapViewController () <MKMapViewDelegate>

@end

@implementation MapViewController
{
    MKMapView *_mapView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)];
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    _mapView.mapType = MKMapTypeStandard;
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    MKCoordinateSpan span=MKCoordinateSpanMake(0.01, 0.01);
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([self.deal.shop.latitude doubleValue], [self.deal.shop.longitude doubleValue]);
    MKCoordinateRegion region=MKCoordinateRegionMake(coordinate, span);
    [_mapView setRegion:region animated:YES];
    
    
    MyAnotation *anotation = [[MyAnotation alloc] init];
    anotation.title = self.deal.title;
    anotation.subTitle = self.deal.min_title;
    anotation.coordinate = coordinate;
    
    [_mapView addAnnotation:anotation];
    
}

#pragma mark - 地图代理
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
//    MKCoordinateSpan span=MKCoordinateSpanMake(0.01, 0.01);
//    MKCoordinateRegion region=MKCoordinateRegionMake(userLocation.location.coordinate, span);
//    [_mapView setRegion:region animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *key = @"anotation";
    //    if ([annotation isKindOfClass:[MyAnotation class]]) {
    //        static NSString *key = @"anotation";
    //        MKAnnotationView *annotationView = [_mapView dequeueReusableAnnotationViewWithIdentifier:key];
    //        if (!annotationView) {
    //            annotationView=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:key];
    //            annotationView.canShowCallout=YES;//允许交互点击
    //            annotationView.calloutOffset=CGPointMake(0, 1);//定义详情视图偏移量
    //            annotationView.leftCalloutAccessoryView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_nav_end"]];//定义详情左侧视图
    //        }
    //        annotationView.annotation = annotation;
    //        annotationView.image = [UIImage imageNamed:@"add_success"];
    //        return annotationView;
    //    }else {
    //        return nil;
    //    }
    MKPinAnnotationView *view = [_mapView dequeueReusableAnnotationViewWithIdentifier:key];
    if (!view) {
        view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:key];
        
        //是否选择从天而降
        view.animatesDrop = YES;
        
        view.pinTintColor = [UIColor cyanColor];
    }
    
    return view;
    
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
