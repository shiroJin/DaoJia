//
//  ScreenScroller.m
//  DaoJia
//
//  Created by Macx on 16/2/16.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "ScreenScroller.h"
#import "MBProgressHUD.h"

@interface ScreenScroller () <UIScrollViewDelegate, UIAlertViewDelegate>
{
    NSInteger _maxIndex;
    NSInteger _currentIndex;
    UIAlertView *_alert;
}

@property (nonatomic, strong)UIScrollView *scroller;
@property (nonatomic, strong)UIImageView *leftImg;
@property (nonatomic, strong)UIImageView *centerImg;
@property (nonatomic, strong)UIImageView *rightImg;
@property (nonatomic, strong)UIPageControl *pageControl;
@property (nonatomic, copy)NSArray *imgArr;

@end

@implementation ScreenScroller

- (instancetype)initWithImgs:(NSArray *)imgArr currentIndex:(NSInteger)currentIndex
{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        //init
        _currentIndex = currentIndex;
        _maxIndex = imgArr.count - 1;
        _imgArr = [imgArr copy];
        [self createScroller];
        [self createSubviews];
        [self setImg:_currentIndex];
    }
    return self;
}

//添加事件
- (void)addAction {
    [_scroller addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [_scroller addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(saveImg)]];
}

- (void)back {
    [self removeFromSuperview];
}

- (void)saveImg {
//    if (!_alert) {
//        _alert = [UIAlertController alertControllerWithTitle:@"" message:@"保存图片到相册?" preferredStyle:UIAlertControllerStyleActionSheet];
//    }
//    
//    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        UIImage *img = [UIImage imageNamed:@"add_success"];
//        UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
//    }];
//    UIAlertAction *no = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleCancel handler:NULL];
//    
//    [_alert addAction:yes];
//    [_alert addAction:no];
//    
//    [((UIWindow *)self.superview).rootViewController presentViewController:_alert animated:YES completion:NULL];
    
    if (!_alert) {
    _alert = [[UIAlertView alloc] initWithTitle:@"" message:@"保存图片到相册" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
    }
    [_alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        //下载图片
        UIImage *img = _centerImg.image;
        UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

    }
}

- (void)image:(UIImage *)img didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    //PUD
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.labelText = @"保存成功";
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark"]];
    [hud hide:YES afterDelay:3.5];
}

#pragma mark - 滑动视图创建
- (void)createScroller {
    _scroller = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _scroller.backgroundColor = [UIColor blackColor];
    _scroller.contentSize = CGSizeMake(kScreenWidth * 3, kScreenHeight);
    _scroller.delegate = self;
    _scroller.scrollEnabled = YES;
    _scroller.pagingEnabled = YES;
    [self addSubview:_scroller];
    [self addAction];
}

- (void)createSubviews
{
    _leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _leftImg.contentMode = UIViewContentModeScaleAspectFit;
    [_scroller addSubview:_leftImg];
    
    _centerImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight)];
    _centerImg.contentMode = UIViewContentModeScaleAspectFit;
    [_scroller addSubview:_centerImg];
    
    _rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth * 2, 0, kScreenWidth, kScreenHeight)];
    _rightImg.contentMode = UIViewContentModeScaleAspectFit;
    [_scroller addSubview:_rightImg];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, kScreenHeight - 20, kScreenWidth, 20)];
    _pageControl.numberOfPages = _maxIndex + 1;
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    [self addSubview:_pageControl];
}

//设置图片
- (void)setImg:(NSInteger)index {
    NSInteger leftIndex, centerIndex, rightIndex;
    if (index == 0) {
        leftIndex = _maxIndex;
        centerIndex = 0;
        rightIndex = 1;
    }
    else if (index < _maxIndex) {
        leftIndex = index - 1;
        centerIndex = index;
        rightIndex = index + 1;
    }else {
        leftIndex = _maxIndex - 1;
        centerIndex = _maxIndex;
        rightIndex = 0;
    }
    
    [_leftImg sd_setImageWithURL:[NSURL URLWithString:_imgArr[leftIndex]]];
    [_centerImg sd_setImageWithURL:[NSURL URLWithString:_imgArr[centerIndex]]];
    [_rightImg sd_setImageWithURL:[NSURL URLWithString:_imgArr[rightIndex]]];
    
    [_scroller setContentOffset:CGPointMake(kScreenWidth, 0) animated:NO];
}


#pragma mark - 滑动代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = _scroller.contentOffset.x;
    if (offsetX == kScreenWidth * 2) {
        _currentIndex++;
        if (_currentIndex > _maxIndex) {
            _currentIndex = 0;
        }
        
        _pageControl.currentPage = _currentIndex;
        [self setImg:_currentIndex];
    }
    if (offsetX == 0) {
        _currentIndex--;
        if (_currentIndex == -1) {
            _currentIndex = _maxIndex;
        }
        _pageControl.currentPage = _currentIndex;
        [self setImg:_currentIndex];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
