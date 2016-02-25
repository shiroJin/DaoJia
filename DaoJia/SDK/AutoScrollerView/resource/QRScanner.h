//
//  QRScanner.h
//  QRScannerDemo
//
//  Created by Macx on 16/2/20.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QRCoderScannerDelegate <NSObject>

- (void)didFinshedScanningQRCode:(NSString *)result;

@end

@interface QRScanner : UIView

@property (nonatomic, strong)UIColor *scanningLineColor;//扫描线颜色
@property (nonatomic, strong)UIColor *connerLineColor;//边角颜色
@property (nonatomic, assign)CGSize *scannerSize;//扫描框大小

- (instancetype)initWithView:(UIView *)view;

+ (NSString *)QRForImg:(UIImage *)image;

@property (nonatomic,assign) id<QRCoderScannerDelegate>delegate;


@end
