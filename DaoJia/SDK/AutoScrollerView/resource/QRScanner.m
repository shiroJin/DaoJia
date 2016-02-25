//
//  QRScanner.m
//  QRScannerDemo
//
//  Created by Macx on 16/2/20.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "QRScanner.h"
#import <AVFoundation/AVFoundation.h>

#define kScreenBounds [UIScreen mainScreen].bounds
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


@interface QRScanner () <AVCaptureMetadataOutputObjectsDelegate>
{
    AVCaptureDevice *_device;
    AVCaptureDeviceInput *_input;
    AVCaptureMetadataOutput *_output;
    AVCaptureSession *_session;
    AVCaptureVideoPreviewLayer *_preview;
    CGRect _parentBounds;
}

@end

@implementation QRScanner

#pragma mark - 初始化方法
- (instancetype)initWithView:(UIView *)view {
    QRScanner *scanner = [[QRScanner alloc] initWithFrame:view.frame];
    [scanner initDataWithView:view];
    return scanner;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark  - 从图片中读取二维码
+ (NSString *)QRForImg:(UIImage *)QRImage {
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    CIImage *image = [CIImage imageWithCGImage:QRImage.CGImage];
    NSArray *features = [detector featuresInImage:image];
    CIQRCodeFeature *feature = [features firstObject];
    NSString *result = feature.messageString;
    
    return result;
}

- (void)initDataWithView:(UIView *)parentView {
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:nil];
    _output = [[AVCaptureMetadataOutput alloc] init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //session
    _session = [[AVCaptureSession alloc] init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([_session canAddInput:_input]) {
        [_session addInput:_input];
    }
    
    if ([_session canAddOutput:_output]) {
        [_session addOutput:_output];
    }
    
    //设置条码类型
    _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    _preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResize;
    _preview.frame = parentView.bounds;
    [parentView.layer insertSublayer:_preview atIndex:0];

    [_session startRunning];
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    [_session stopRunning];
    [_preview removeFromSuperlayer];
    
    //设置界面显示扫描结果
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        
        if ([self.delegate respondsToSelector:@selector(didFinshedScanningQRCode:)]) {
            [self.delegate didFinshedScanningQRCode:obj.stringValue];
        }
        else{
            NSLog(@"没有收到扫描结果，看看是不是没有实现协议！");
        }
        
        NSLog(@"扫描结束%@", obj.stringValue);
        
    }
    [self removeFromSuperview];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
//     Drawing code
    CGContextRef context  = UIGraphicsGetCurrentContext();
    [self addScreenFillRect:context rect:kScreenBounds];
}

- (void)addScreenFillRect:(CGContextRef)ctx rect:(CGRect)rect {
    CGContextSetRGBFillColor(ctx, 40 / 255.0, 40 / 255.0, 40 / 255.0, 0.2);
    CGContextFillRect(ctx, rect);   //draw the transparent layer
    
    CGContextClearRect(ctx, CGRectMake((kScreenWidth - 200) / 2, (kScreenHeight - 200) / 2, 200, 200));
}


@end
