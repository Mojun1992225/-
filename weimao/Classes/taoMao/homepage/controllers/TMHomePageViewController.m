//
//  TMHomePageViewController.m
//  TaoMao
//
//  Created by mac on 14-4-16.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "TMHomePageViewController.h"
#import "TMClassicViewController.h"
#import "FCsetViewController.h"
#import "TMShopStoreDetailScrollController.h"
#import "TMThirdClassViewController.h"
#import "TMGoodsDetailsViewController.h"

#import "BRAdmobView.h"
#import "EBApiClient+Admob.h"

@interface TMHomePageViewController ()<UIScrollViewDelegate>
{
    UrlImageButton *btn;
    UILabel *label1;
    UrlImageButton *fourBtn;
    UILabel *fourLab;
    UIView *_view;
    UIScrollView *sc;
    UIImageView *imageView;
    NSInteger indexScoller;
}
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong) UIImageView *label;
@property(nonatomic, strong) UIView *banner;
@property(nonatomic, strong)UIPageControl *pageControl;
@property(strong,nonatomic) NSArray * array;
@property(nonatomic,assign)int pageIndex;
@property(nonatomic,strong) NSString* donwUrl;
@property(nonatomic,strong) NSString* tle;
@property(nonatomic,strong) NSString* date;
@property(nonatomic,strong) NSString* conent_simple;
@property(nonatomic,strong) NSString* conent;
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kAdmobHeight 130
#define kAdmobTag    100
#define kTabbarHeight 44
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@end

@implementation TMHomePageViewController

-(UIView*)initNavigationBar
{
    self.navigationController.navigationBarHidden = YES;
    UIView *view_bar =[[UIView alloc]init];
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>6.1)
    {
        view_bar .frame=CGRectMake(0, 0, self.view.frame.size.width, 44+20);
        UIImageView *imageV = [[UIImageView alloc]initWithImage:BundleImage(@"top.png")];
        [view_bar addSubview:imageV];
        [imageV release];
        
    }else{
        view_bar .frame=CGRectMake(0, 0, self.view.frame.size.width, 44);
        UIImageView *imageV = [[UIImageView alloc]initWithImage:BundleImage(@"top.png")];
        [view_bar addSubview:imageV];
        [imageV release];
    }
    view_bar.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview: view_bar];
    UILabel *title_label=[[UILabel alloc]initWithFrame:CGRectMake(65, view_bar.frame.size.height-44, self.view.frame.size.width-130, 44)];
    title_label.text=@"首页";
    title_label.font=[UIFont boldSystemFontOfSize:16.0f];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =[UIColor whiteColor];
    title_label.textAlignment=1;
    [view_bar addSubview:title_label];
 
//    UIButton*btnBack=[UIButton buttonWithType:0];
//    btnBack.frame=CGRectMake(self.view.frame.size.width-40, view_bar.frame.size.height-40, 35, 35);
//    [btnBack setImage:BundleImage(@"sy_setup.png") forState:0];
//    [btnBack addTarget:self action:@selector(btnSet:) forControlEvents:UIControlEventTouchUpInside];
//    [view_bar addSubview:btnBack];
//
    
    return view_bar;
}

-(void)btnSet:(id)sender
{
    FCsetViewController *set=[[FCsetViewController alloc]init];
      TMAppDelegate *appDelegate = (TMAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:set animated:YES];

}

-(void)drawViewRect
{
    UIView*naviView=(UIView*) [self initNavigationBar];
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, naviView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-naviView.frame.size.height-49)];
    
    if (IS_IPHONE_5) {
        
        [_scrollView setContentSize:CGSizeMake(320, self.view.frame.size.height+15)];
    }else{
        [_scrollView setContentSize:CGSizeMake(320, self.view.frame.size.height+120)];
    }
    _scrollView.showsVerticalScrollIndicator=NO;
    _scrollView.backgroundColor=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    [self.view addSubview:_scrollView];
    
    //banner背景
    UIView *scroller=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 160)];
    scroller.backgroundColor=[UIColor clearColor];
    [_scrollView addSubview:scroller];
    
    //banner
    AdmobInfo * info1=[[AdmobInfo alloc] init];
    info1.defultImage=[UIImage imageNamed:@"2"];
    BRAdmobView * view=[[BRAdmobView alloc] initWithFrame:CGRectMake(0, 0, scroller.frame.size.width, scroller.frame.size.height) andData:@[info1] andInViewe:self.view];
    [view addPageControlViewWithSize:CGSizeMake(10, 10)];
    view.isAutoScoller=YES;
    view.allowSelect=YES;
    view.clipsToBounds=YES;
    [scroller addSubview:view];
    view.tag=kAdmobTag;

    __weak TMHomePageViewController * weakSelf=self;
    view.admobSelect=^(AdmobInfo* info,NSInteger index)
    {
        NSLog(@"banner点击事件");
        TMGoodsDetailsViewController *good=[[TMGoodsDetailsViewController alloc]init];
        TMAppDelegate *delegate=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
        [delegate.navigationController pushViewController:good animated:YES];
    };

   
    for (int i =0; i<3; i++)
    {
        btn=[[UrlImageButton alloc]initWithFrame:CGRectMake(12+i*100, scroller.frame.size.height+scroller.frame.origin.y+10, 95, 70)];
        [btn setImage:[UIImage imageNamed:@"default_02.png"] forState:0];
        [_scrollView addSubview:btn];
        [btn addTarget:self action:@selector(btnGoodsList:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor=[UIColor clearColor];
        
        label1=[[UILabel alloc]initWithFrame:CGRectMake(12+i*100, btn.frame.size.height+btn.frame.origin.y+5, 95, 20)];
        label1.text=@"新品装|New";
        label1.textColor=[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1.0];
        label1.font=[UIFont systemFontOfSize:12];
        label1.textAlignment=1;
        label1.backgroundColor=[UIColor clearColor];
 
        [_scrollView addSubview:label1];
       
    }
 
    UIImageView*img=[[UIImageView alloc]initWithFrame:CGRectMake(0,label1.frame.size.height+label1.frame.origin.y+6 , self.view.frame.size.width, 33)];
    img.image=BundleImage(@"titlebar.png");
    img.backgroundColor=[UIColor clearColor];
    [_scrollView addSubview:img];
    [img release];
    
  
    for (int i =0; i<4; i++)
    {
        fourBtn=[[UrlImageButton alloc]initWithFrame:CGRectMake(12+i*75, img.frame.size.height+img.frame.origin.y+8, 70, 70)];
        [fourBtn addTarget:self action:@selector(btnShopStore:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:fourBtn];
        [fourBtn setBackgroundImage: [UIImage imageNamed:@"default_02.png"] forState:0];
         [fourBtn setImage: [UIImage imageNamed:@"spic_01.png"] forState:0];
        fourLab=[[UILabel alloc]initWithFrame:CGRectMake(12+i*75, fourBtn.frame.size.height+fourBtn.frame.origin.y+8, 70, 20)];
        fourLab.text=@"都市韩风";
        fourLab.textColor=[UIColor grayColor];
        fourLab.font=[UIFont boldSystemFontOfSize:10];
        fourLab.textAlignment=1;
        fourLab.backgroundColor=[UIColor clearColor];
        [_scrollView addSubview:fourLab];
        
    }
    _view=[[UIView alloc]initWithFrame:CGRectMake(0, fourLab.frame.size.height+fourLab.frame.origin.y+10, 320, 170)];
    
    int imageCount=9;
    
    if (imageCount>8)
    {
        for (int i =0; i<7; i++)
        {
            
            _view.backgroundColor=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
            [_scrollView addSubview:_view];
            
            UrlImageButton *btnNine=[[UrlImageButton alloc]initWithFrame:CGRectMake((i%4)*75+12, floor(i/4)*75+10, 70, 70)];
            [btnNine setImage:[UIImage imageNamed:@"pic_02.png"] forState:0];
            btnNine.backgroundColor=[UIColor clearColor];
            [btnNine addTarget:self action:@selector(btnFenlei:) forControlEvents:UIControlEventTouchUpInside];
            [_view addSubview:btnNine];
            
            
            UrlImageButton *btn8=[[UrlImageButton alloc]initWithFrame:CGRectMake((7%4)*75+12, floor(7/4)*75+10, 70, 70)];
            [btn8 setImage:[UIImage imageNamed:@"pic_03.png"] forState:0];
            [_view addSubview:btn8];

            
            UrlImageView*image=[[UrlImageView alloc]initWithFrame:CGRectMake(2, 1, 70-5, 50)];
            [btnNine addSubview:image];
            [image setImage:[UIImage imageNamed:@"default_04.png"]];
            image.layer.borderWidth=1;
            image.layer.cornerRadius = 4;
            image.layer.borderColor = [[UIColor clearColor] CGColor];
            image.backgroundColor=[UIColor clearColor];
            
            UILabel *labelLine=[[UILabel alloc]initWithFrame:CGRectMake(2, 50+10, 70-4, 1)];
            labelLine.backgroundColor=[UIColor grayColor];
            [btnNine addSubview:labelLine];
            
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 20, 15)];
            label.font = [UIFont boldSystemFontOfSize:10.0f];  //UILabel的字体大小
            label.numberOfLines = 0;  //必须定义这个属性，否则UILabel不会换行
            label.textColor = [UIColor grayColor];
            label.textAlignment = NSTextAlignmentCenter;  //文本对齐方式
            [label setBackgroundColor:[UIColor whiteColor]];
            
            //高度固定不折行，根据字的多少计算label的宽度
            NSString *str = @"高度";
            CGSize size = [str sizeWithFont:label.font constrainedToSize:CGSizeMake(MAXFLOAT, label.frame.size.height)];
            //        NSLog(@"size.width=%f, size.height=%f", size.width, size.height);
            //根据计算结果重新设置UILabel的尺寸
            [label setFrame:CGRectMake((70-size.width)/2, 52, size.width+4, 15)];
            label.text = str;  
            
            [btnNine addSubview:label];
            [label release];
        }

    }
}

-(void)btnGoodsList:(id)sender
{

    TMThirdClassViewController *third=[[TMThirdClassViewController alloc]init];
    TMAppDelegate *app=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [app.navigationController pushViewController:third animated:YES];
    [third release];
}
-(void)btnShopStore:(id)sender
{
    TMShopStoreDetailScrollController *shopStore=[[TMShopStoreDetailScrollController alloc]init];
    TMAppDelegate *appDelegate = (TMAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:shopStore animated:YES];
}

-(void)btnFenlei:(id)sender
{
    TMClassicViewController*classIC=[[TMClassicViewController alloc]initWithWhere:@"first"];
    TMAppDelegate *delegate=(TMAppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.navigationController pushViewController:classIC animated:YES];
}

-(void)viewDidLoad
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self drawViewRect];
    //获取首页banner图
    //[self getAdmobList];
}


#define kAdmobTag    100
-(void)getAdmobList
{
    BRAdmobView * adnvo=(BRAdmobView*)[self.view viewWithTag:kAdmobTag];
    [[EBApiClient sharedEBApiClient] quaryAdmobWithOther:nil success:^(BOOL success, NSArray *other, NSString *alter)
     {
         if (other.count>0) {
             __block NSMutableArray * temp=[NSMutableArray array];
             [other enumerateObjectsUsingBlock:^(Admob *obj, NSUInteger idx, BOOL *stop) {
                 AdmobInfo * info1=[[AdmobInfo alloc] init];
                 //轮播图赋值
                 info1.content=obj.href;
                 info1.url=obj.image;
                 info1.type=obj.type;
                 info1.admobName=obj.name;
                 info1.defultImage=[UIImage imageNamed:@"003.jpg"];
                 [temp addObject:info1];
                 
                 NSLog(@"======banner====%@=============",obj.type);
             }];
             adnvo.dataArray=temp;
             [adnvo reloadDataAndReloadPageControl:YES];
         }
     } failse:^(BOOL failse, id other) {
         
     }];
}

//#pragma mark - ImageScrollViewDelegate
//-(void)didSelectImageAtIndex:(NSInteger)index
//{
//    NSLog(@"图index:%ld",(long)index);
//}
//
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (alertView.tag==100) {
//        
//        NSURL * url=[NSURL URLWithString:self.donwUrl];
//        if ([[UIApplication sharedApplication] canOpenURL:url]) {
//            
//            [[UIApplication sharedApplication] openURL:url];
//            
//            exit(0);
//        }
//    }
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
