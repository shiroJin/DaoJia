//
//  CycleScrollerView.m
//  AutoScrollerView
//
//  Created by Macx on 16/2/8.
//  Copyright © 2016年 jinquanbin. All rights reserved.
//

#import "CycleScrollerView.h"
#import "UIImageView+WebCache.h"

#define kWidth self.bounds.size.width
#define kHeight self.bounds.size.height
#define kImgWidth (self.bounds.size.width - self.separation * 2)
#define kImgHeight (self.bounds.size.height - self.separation * 2)

@interface CycleScrollerView ()

@property (nonatomic, assign) CGFloat separation;//间距 默认0；

@end

@implementation CycleScrollerView
{
    UIScrollView *scroller;
    UIPageControl *pageControl;
    UIImageView *leftImg;
    UIImageView *centerImg;
    UIImageView *rightImg;
    NSTimer *timer;
    NSArray *imagesArr;//图片数组
    NSInteger maxCount;//最大图片数
    NSInteger currentIndex;//当前位置
    BOOL isNetImage;//是否网络加载的图片
    BOOL isSpecial;//图片少于3张得情况
}

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame imgs:(NSArray *)imgArr isNetImage:(BOOL)isNet separation:(CGFloat)separationSize {
    
    self = [super initWithFrame:frame];
    if (self) {
        currentIndex = 0;
        maxCount = imgArr.count;
        
        //当图片少于3张时。
        if (maxCount == 2)
        {
            isSpecial = YES;
        }
        else if (maxCount == 1)
        {
            UIImageView *img = [[UIImageView alloc] initWithFrame:self.bounds];
            [img sd_setImageWithURL:[NSURL URLWithString:imgArr.firstObject]];
            [self addSubview:img];
            return self;
        }
        
        imagesArr = imgArr;
        isNetImage = isNet;
        self.separation = separationSize;
        [self setDefaultValue];
        [self createScrollerView];
        [self createPageControl];
        [self createImgViews];
        [self setUpTimer];
    }
    return self;
}

#pragma mark - 默认值设定

- (void)setDefaultValue {
    _isAutoCycle = YES;
    _timeInterval = 3;
    _indictorColor = [UIColor whiteColor];
    _currentIndictorColor = [UIColor blueColor];
    _scale = 1.0f;
}

#pragma mark - 创建子视图

//创建滑动视图
- (void)createScrollerView {
    scroller = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:scroller];
    scroller.scrollEnabled = YES;
    scroller.pagingEnabled = YES;
    scroller.showsHorizontalScrollIndicator = NO;
    scroller.showsVerticalScrollIndicator = NO;
    scroller.bounces = NO;
    scroller.contentSize = CGSizeMake(kWidth * 3, kHeight);
    scroller.delegate = self;
    [scroller addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImgViewAction)]];
}

//pageControl
- (void)createPageControl {
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, kWidth, 20)];
    [self addSubview:pageControl];
    pageControl.numberOfPages = maxCount;
    pageControl.pageIndicatorTintColor = self.indictorColor;
    pageControl.currentPageIndicatorTintColor = self.currentIndictorColor;
}

- (void)createImgViews {
    leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(_separation, _separation, kImgWidth, kImgHeight)];
    centerImg = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth + _separation, _separation, kImgWidth, kImgHeight)];
    rightImg = [[UIImageView alloc] initWithFrame:CGRectMake(kWidth * 2 + _separation, _separation, kImgWidth, kImgHeight)];
    
    leftImg.contentMode = UIViewContentModeScaleAspectFill;
    centerImg.contentMode = UIViewContentModeScaleAspectFill;
    rightImg.contentMode = UIViewContentModeScaleAspectFill;
    
    leftImg.clipsToBounds = YES;
    centerImg.clipsToBounds = YES;
    rightImg.clipsToBounds = YES;
    
    [scroller addSubview:leftImg];
    [scroller addSubview:centerImg];
    [scroller addSubview:rightImg];
    
    [self setImages];
}

#pragma mark - 子视图属性配置
- (void)setIndictorColor:(UIColor *)indictorColor {
    if (_indictorColor != indictorColor) {
        _indictorColor = indictorColor;
        
        pageControl.pageIndicatorTintColor = _indictorColor;
    }
}
- (void)setCurrentIndictorColor:(UIColor *)currentIndictorColor {
    if (_currentIndictorColor != currentIndictorColor) {
        _currentIndictorColor = currentIndictorColor;
        
        pageControl.currentPageIndicatorTintColor = _currentIndictorColor;
    }
}

- (void)setPageControlMode:(PageControlMode)pageControlMode {
    if (_pageControlMode != pageControlMode) {
        _pageControlMode = pageControlMode;
        
        if (_pageControlMode == PageControlTop) {
            pageControl.frame = CGRectMake(0, 0, pageControl.bounds.size.width, pageControl.bounds.size.height);
        }else {
            pageControl.frame = CGRectMake(0, self.bounds.size.height - pageControl.bounds.size.height, pageControl.bounds.size.width, pageControl.bounds.size.height);
        }
    }
}

- (void)setScale:(CGFloat)scale {
    if (_scale != scale) {
        _scale = scale;
        
        if (self.scale > 1 || self.scale <= 0) {
            self.scale = 1;
        }
        leftImg.transform = CGAffineTransformMakeScale(self.scale, self.scale);
        centerImg.transform = CGAffineTransformMakeScale(self.scale, self.scale);
        rightImg.transform = CGAffineTransformMakeScale(self.scale, self.scale);
    }
}

- (void)setIsAutoCycle:(BOOL)isAutoCycle {
    if (_isAutoCycle != isAutoCycle) {
        _isAutoCycle = isAutoCycle;
        [self stopTimer];
        [self setUpTimer];
    }
}

#pragma mark - 加载图片

- (void)setImages {
    
    if (isSpecial) {
        if (currentIndex == 0) {
            [self setImagesWithLeft:1 center:0 right:1];
        }else {
            [self setImagesWithLeft:0 center:1 right:0];
        }
    }
    else
    {
        //加载图片
        if (currentIndex == 0) {
            [self setImagesWithLeft:maxCount - 1 center:currentIndex right:currentIndex  + 1];
        }
        else if (currentIndex < maxCount - 1) {
            [self setImagesWithLeft:currentIndex - 1 center:currentIndex right:currentIndex + 1];
        }
        else if (currentIndex >= maxCount - 1) {
            [self setImagesWithLeft:currentIndex - 1 center:currentIndex right:0];
        }
    }
    
    [scroller setContentOffset:CGPointMake(kWidth, 0)];
}


- (void)setImagesWithLeft:(NSInteger)left center:(NSInteger)center right:(NSInteger)right {
    //本地加载
    if (!isNetImage) {
        leftImg.image = [UIImage imageNamed:imagesArr[left]];
        centerImg.image = [UIImage imageNamed:imagesArr[center]];
        rightImg.image = [UIImage imageNamed:imagesArr[right]];
    }//网络加载
    else if (isNetImage) {
        [leftImg sd_setImageWithURL:imagesArr[left]];
        [centerImg sd_setImageWithURL:imagesArr[center]];
        [rightImg sd_setImageWithURL:imagesArr[right]];
    }
}

#pragma mark - 图片点击事件
- (void)tapImgViewAction {
    if (self.tapImgBlock) {
        _tapImgBlock(currentIndex);
    }
}

#pragma mark - 设置滑动事件间隔
- (void)setTimeInterval:(CGFloat)timeInterval {
    if (_timeInterval != timeInterval) {
        _timeInterval = timeInterval;
        [self stopTimer];
        [self setUpTimer];
    }
}

- (void)setUpTimer {
    if (!self.isAutoCycle) {
        return;
    }
    
    timer = nil;
    timer = [NSTimer timerWithTimeInterval:_timeInterval target:self selector:@selector(scroll) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    if (timer == nil) {
        return;
    }
    [timer invalidate];
}

- (void)scroll {
    [scroller setContentOffset:CGPointMake(scroller.contentOffset.x + kWidth, 0) animated:YES];
}

#pragma mark - 滑动视图代理
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self setUpTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scroller.contentOffset.x;
    
    if (offsetX == kWidth * 2) {
        currentIndex++;
        if (currentIndex == maxCount) {
            currentIndex = 0;
        }
        [self setImages];
    }
    else if (offsetX == 0) {
        currentIndex--;
        if (currentIndex < 0) {
            currentIndex = maxCount - 1;
        }
        [self setImages];
    }
    
    pageControl.currentPage = currentIndex;
}


@end
