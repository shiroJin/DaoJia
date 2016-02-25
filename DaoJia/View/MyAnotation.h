//
//  MyAnotation.h
//  DaoJia
//
//  Created by Macx on 16/2/19.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnotation : NSObject<MKAnnotation>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong)UIImage *image;

@end
