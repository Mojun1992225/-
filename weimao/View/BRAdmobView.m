//
//  BRAdmobView.m
//  BRAdmob
//
//  Created by gitBurning on 15/4/13.
//  Copyright (c) 2015年 BR. All rights reserved.
//

#import "BRAdmobView.h"
#import "AdmobCollectionViewCell.h"
#import "Admob.h"
#import "UrlImageView.h"
#import "UrlImageButton.h"
#define kIndexCell @"AdmobCollectionViewCell"
#define kAdmobScreenWidth [UIScreen mainScreen].bounds.size.width

#define kDefaultTime 5

#define AdmobUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface BRAdmobView()
@property(assign,nonatomic) float admobWidth;
@property(assign,nonatomic) float admobHeight;
@property(assign,nonatomic) CGSize pageControlSize;
@end
@implementation BRAdmobView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame andData:(NSArray *)data andInViewe:(UIView *)view{
    
    
    if ([super initWithFrame:frame]) {
        
        self.admobWidth=CGRectGetWidth(frame);
        self.admobHeight=CGRectGetHeight(frame);
        self.dataArray=data;
        [self addColletionViewInView:view];
        
        self.backgroundColor=[UIColor redColor];
    }
    
    return self;
}

-(void)addColletionViewInView:(UIView*)view{
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing=0.f;//左右间隔
    flowLayout.minimumLineSpacing=0.f;
    flowLayout.itemSize=CGSizeMake(self.admobWidth, self.admobHeight);
    flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0,0,self.admobWidth,160) collectionViewLayout:flowLayout];
    
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.backgroundColor=[UIColor blackColor];
    self.collectionView.showsHorizontalScrollIndicator=NO;
    UINib *nib=[UINib nibWithNibName:kIndexCell bundle:nil];
    
    [self.collectionView registerNib: nib forCellWithReuseIdentifier:kIndexCell];

    [self addSubview:self.collectionView];
    self.collectionView.pagingEnabled=YES;
    self.collectionView.bounces=NO;

    self.collectionView.backgroundColor=[UIColor whiteColor];
    
    
    self.titileView=[[UIView alloc] initWithFrame:CGRectMake(0, self.admobHeight-32, self.admobWidth, 32)];
    [self addSubview:self.titileView];
    self.titileView.backgroundColor=[[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    _titileLabel=[[UILabel alloc] initWithFrame:CGRectMake(5, 6, self.admobWidth-10, self.titileView.frame.size.height-6*2)];
    [_titileView addSubview:_titileLabel];
    _titileLabel.textAlignment=NSTextAlignmentCenter;
    //0,6,192,21;
}
-(void)addPageControlViewWithSize:(CGSize)size
{
    if (self.pageControl) {
        [self.pageControl removeFromSuperview];
    }
    self.pageControlSize=size;
    
    float margin=10;
    float witdth=size.width* self.dataArray.count + margin*(self.dataArray.count-1);
    float height=size.height;
    
    self.pageControl=[[UIPageControl alloc] initWithFrame:CGRectMake((self.admobWidth-witdth)/2, 20, witdth, height)];
    self.pageControl.numberOfPages=self.dataArray.count;
    self.pageControl.currentPage=0;
    //    view.pageControl.currentPageIndicatorTintColor=UIColorFromRGB(0x2da7e0);

    self.pageControl.currentPageIndicatorTintColor=AdmobUIColorFromRGB(0x2da7e0);
    self.pageControl.pageIndicatorTintColor=[[UIColor lightGrayColor] colorWithAlphaComponent:0.6];
    [self addSubview:self.pageControl];
    
    self.pageControl.selected=NO;
}

-(void)setIsBounces:(BOOL)isBounces{
    _isBounces=isBounces;
    self.collectionView.bounces=isBounces;
}
-(void)setIsPagingEnabled:(BOOL)isPagingEnabled{
    _isPagingEnabled=isPagingEnabled;
    self.collectionView.pagingEnabled=isPagingEnabled;
}
-(void)reloadDataAndReloadPageControl:(BOOL)pageControl{
    [self.collectionView reloadData];
    if (pageControl) {
        [self addPageControlViewWithSize:self.pageControlSize];

    }
}



#pragma mark---顶部的滑动试图
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    // return allSpaces.count;
    return self.dataArray.count *100;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (!self.allowSelect) {
        return;
    }
    AdmobInfo *info=self.dataArray[indexPath.row];

    if (self.admobSelect) {
        self.admobSelect(info,indexPath.row);
    }
    else{
        
        if (self.selectDelegate) {
            [self.selectDelegate admobView:self SelectIndex:indexPath.row andOther:info];
        }
    }
    
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AdmobCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:kIndexCell forIndexPath:indexPath];
    
    AdmobInfo *info=self.dataArray[indexPath.row % self.dataArray.count];
    if (info.admobName.length<=0) {
        self.titileView.hidden=YES;
    }else{
        self.titileLabel.text=info.admobName;
        
        self.titileView.hidden=NO;
        
    }
    //图片（注意被封装过）
    [cell.admobImage setImageWithURL:[NSURL URLWithString:info.url] placeholderImage:info.defultImage];
    return cell;
}


#pragma mark--计算 pageConrtoll

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
NSInteger index=(int)(scrollView.contentOffset.x/self.admobWidth)%self.dataArray.count;
    NSLog(@"-----%li",(long)index);
    
    self.pageControl.currentPage=index;
    indexScoller=index+1;
}
/**
 *  延迟 定时器
 */
-(void)deleyTime{
    [self stopTimer:NO];

}

-(void)setIsAutoScoller:(BOOL)isAutoScoller{
    if (isAutoScoller) {
        
        self.timer=[NSTimer timerWithTimeInterval:self.autoTime target:self selector:@selector(autoScrollView) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
        [self.timer fire];
        
        
    }
}

/**
 *  是否暂停
 *
 *  @param isStop <#isStop description#>
 */
-(void)stopTimer:(BOOL)isStop{
    if (!isStop) {
        [self.timer setFireDate:[NSDate distantPast]];

    }
    else{
        [self.timer setFireDate:[NSDate distantFuture]];

    }
}
-(void)autoScrollView{
    
    BOOL isAnmiation=YES;
    if (indexScoller>=self.dataArray.count) {
        indexScoller=1;
        isAnmiation=NO;
    }
    else{
        indexScoller++;
    }
  //  NSLog(@"idnex%ld",indexScoller);
    
     [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:indexScoller-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:isAnmiation];
    
    self.pageControl.currentPage=indexScoller-1;
    
}

-(NSInteger)autoTime{
    
    if (_autoTime<=0) {
        _autoTime=kDefaultTime;
    }
    return _autoTime;
}

-(void)dealloc{
    [self.timer invalidate];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];

}
@end



@implementation AdmobInfo



@end
