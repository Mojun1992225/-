//
//  MineViewController.m
//  weimao
//
//  Created by mj on 16/2/1.
//  Copyright © 2016年 mj. All rights reserved.
//

#import "MineViewController.h"
#import "FCsetViewController.h"
@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableview;
    NSArray *image_arr;
    NSArray *title_arr;
    NSArray *title_arr1;
    NSArray *title_arr2;
}

@end

@implementation MineViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self initNavigationBar];
    [self createTableView];
    [self createUI];
}


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
    title_label.text=@"个人中心";
    title_label.font=[UIFont boldSystemFontOfSize:16.0f];
    title_label.backgroundColor=[UIColor clearColor];
    title_label.textColor =[UIColor whiteColor];
    title_label.textAlignment=1;
    [view_bar addSubview:title_label];
    
    UIButton*btnBack=[UIButton buttonWithType:0];
    btnBack.frame=CGRectMake(self.view.frame.size.width-40, view_bar.frame.size.height-40, 35, 35);
    [btnBack setImage:BundleImage(@"sy_setup.png") forState:0];
    [btnBack addTarget:self action:@selector(btnSet:) forControlEvents:UIControlEventTouchUpInside];
    [view_bar addSubview:btnBack];
    return view_bar;
}

-(void)createTableView
{
    tableview=[[UITableView alloc]initWithFrame:CGRectMake(0,64, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    tableview.delegate=self;
    tableview.dataSource=self;
    tableview.backgroundColor=[UIColor colorWithRed:255/255.0f green:101/255.0f blue:153/255.0f alpha:1];
    tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
}

-(void)createUI
{
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, tableview.frame.size.width, 50)];
    bgView.backgroundColor=[UIColor colorWithRed:255/255.0f green:101/255.0f blue:153/255.0f alpha:1];
    [tableview addSubview:bgView];
    
    UIButton *image_bg=[[UIButton alloc]initWithFrame:CGRectMake(10,(bgView.frame.size.height-40)/2, 40, 40)];
    [image_bg setImage:[UIImage imageNamed:@"head"] forState:UIControlStateNormal];
    [image_bg.layer setMasksToBounds:YES];
    image_bg.backgroundColor=[UIColor clearColor];
    image_bg.layer.cornerRadius=20.0f;
    [bgView addSubview:image_bg];
    
    UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(image_bg.frame.size.width+bgView.frame.origin.x+30,10 , 120, 25)];
    name.text=@"mojun882013";
    name.font=[UIFont systemFontOfSize:15.0f];
    name.textColor=[UIColor whiteColor];
    [bgView addSubview:name];
    
    UIButton *image_number=[[UIButton alloc]initWithFrame:CGRectMake(tableview.frame.size.width-80,(bgView.frame.size.height-40)/2, 80, 40)];
    [image_number setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [image_number.layer setMasksToBounds:YES];
    [image_number setTitle:@"黄金会员" forState:UIControlStateNormal];
    image_number.font=[UIFont systemFontOfSize:16.0f];
    image_number.backgroundColor=[UIColor clearColor];
    [bgView addSubview:image_number];
    
    
    UIView *bgView1=[[UIView alloc]initWithFrame:CGRectMake(0, bgView.frame.size.height+bgView.frame.origin.y+5, tableview.frame.size.width, 100)];
    bgView1.backgroundColor=[UIColor whiteColor];
    [tableview addSubview:bgView1];
    
    //我的订单
    UILabel *list=[[UILabel alloc]initWithFrame:CGRectMake(10,7 , 120, 25)];
    list.text=@"我的订单";
    list.font=[UIFont systemFontOfSize:15.0f];
    list.textColor=[UIColor blackColor];
    [bgView1 addSubview:list];
    
    //全部订单
    UIButton *all=[[UIButton alloc]initWithFrame:CGRectMake(tableview.frame.size.width-150,7, 150, 25)];
    [all setImage:[UIImage imageNamed:@"gbt_04_"] forState:UIControlStateNormal];
    [all setImageEdgeInsets:UIEdgeInsetsMake(0,100 ,0 , -100)];
    [all.layer setMasksToBounds:YES];
    [all setTitle:@"查看全部订单" forState:UIControlStateNormal];
    [all setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    all.font=[UIFont systemFontOfSize:13.0f];
    [all setTitleColor:[UIColor colorWithRed:210/255.0f green:210/255.0f blue:210/255.0f alpha:1] forState:UIControlStateNormal];
    [all addTarget:self action:@selector(allSall) forControlEvents:UIControlEventTouchUpInside];
    [bgView1 addSubview:all];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 35, self.view.frame.size.width, 1)];
    line.backgroundColor=[UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1];
    [bgView1 addSubview:line];
    
    title_arr=@[@"待付款",@"待发货",@"待收货",@"待评价",@"退款/售后"];
    image_arr=@[@"ic_dot_normal",@"ic_dot_normal",@"ic_dot_normal",@"ic_dot_normal",@"ic_dot_normal"];
    
    for (int i=0; i<5; i++)
    {
        UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake(6+i*62, line.frame.size.height+line.frame.origin.y+6, 60, 50)];
        but.font=[UIFont systemFontOfSize:11];
        [but setTitle:title_arr[i] forState:UIControlStateNormal];
        [but setTitleEdgeInsets:UIEdgeInsetsMake(12, -10, -12, 10)];
        [but setImageEdgeInsets:UIEdgeInsetsMake(-10, 15, 10, -15)];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [but setImage:[UIImage imageNamed:image_arr[i]] forState:UIControlStateNormal];
        but.tag=100+i;
        [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView1 addSubview:but];
    }

    UIView *bgView2=[[UIView alloc]initWithFrame:CGRectMake(0, bgView1.frame.size.height+bgView1.frame.origin.y+5, tableview.frame.size.width, 200)];
    bgView2.backgroundColor=[UIColor whiteColor];
    [tableview addSubview:bgView2];
    
    title_arr1=@[@"收藏夹",@"足迹",@"福利淘",@"我的资产",@"卡券包",@"我要开店",@"帮助/反馈",@"摇一摇"];
    for (int i =0; i<8; i++)
    {
         UIButton  *fourBtn=[[UIButton alloc]initWithFrame:CGRectMake(12+(i%4)*75,floor(i/4)*100, 70, 70)];
        [fourBtn addTarget:self action:@selector(btnShopStore:) forControlEvents:UIControlEventTouchUpInside];
        [bgView2 addSubview:fourBtn];
        fourBtn.backgroundColor=[UIColor clearColor];
        [fourBtn setBackgroundImage: [UIImage imageNamed:@"default_02.png"] forState:0];
        [fourBtn setImage: [UIImage imageNamed:@"spic_01.png"] forState:0];
        fourBtn.tag=200+i;
        UILabel  *fourLab=[[UILabel alloc]initWithFrame:CGRectMake(12+(i%4)*75, floor(i/4)+fourBtn.frame.size.height+fourBtn.frame.origin.y, 70, 20)];
        fourLab.text=title_arr1[i];
        fourLab.textColor=[UIColor grayColor];
        fourLab.font=[UIFont boldSystemFontOfSize:10];
        fourLab.textAlignment=1;
        [bgView2 addSubview:fourLab];
    }
    
    UIView *bgView3=[[UIView alloc]initWithFrame:CGRectMake(0, bgView2.frame.size.height+bgView2.frame.origin.y+5, tableview.frame.size.width, 200)];
    bgView3.backgroundColor=[UIColor whiteColor];
    [tableview addSubview:bgView3];
    
    title_arr2=@[@"试妆台",@"有好货",@"淘生活",@"爱逛家",@"卡券包",@"购物车",@"帮助/反馈",@"摇一摇"];
    for (int i =0; i<8; i++)
    {
        UIButton  *fourBtn=[[UIButton alloc]initWithFrame:CGRectMake(12+(i%4)*75,floor(i/4)*100, 70, 70)];
        [fourBtn addTarget:self action:@selector(btnShopStore:) forControlEvents:UIControlEventTouchUpInside];
        [bgView3 addSubview:fourBtn];
        fourBtn.backgroundColor=[UIColor clearColor];
        [fourBtn setBackgroundImage: [UIImage imageNamed:@"default_02.png"] forState:0];
        [fourBtn setImage: [UIImage imageNamed:@"spic_01.png"] forState:0];
        UILabel  *fourLab=[[UILabel alloc]initWithFrame:CGRectMake(12+(i%4)*75, floor(i/4)+fourBtn.frame.size.height+fourBtn.frame.origin.y, 70, 20)];
        fourLab.text=title_arr2[i];
        fourLab.textColor=[UIColor grayColor];
        fourLab.font=[UIFont boldSystemFontOfSize:10];
        fourLab.textAlignment=1;
        [bgView3 addSubview:fourLab];
    }

    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(0, bgView2.frame.size.height/2-5, self.view.frame.size.width, 1)];
    line1.backgroundColor=[UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1];
    [bgView2 addSubview:line1];
    
    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(bgView2.frame.size.width/2-75, 0, 1, 200)];
    line2.backgroundColor=[UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1];
    [bgView2 addSubview:line2];
    
    UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(bgView2.frame.size.width/2, 0, 1, 200)];
    line3.backgroundColor=[UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1];
    [bgView2 addSubview:line3];
    
    UIView *line4=[[UIView alloc]initWithFrame:CGRectMake(bgView2.frame.size.width/2+75, 0, 1, 200)];
    line4.backgroundColor=[UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1];
    [bgView2 addSubview:line4];
    
}

-(void)btnShopStore:(UIButton *)but
{
    if (but.tag==200)
    {
        NSLog(@"收藏夹");
    }
    else if (but.tag==201)
    {
        NSLog(@"足迹");
    }
    else if (but.tag==202)
    {
        NSLog(@"福利淘");
    }
    else if (but.tag==203)
    {
        NSLog(@"我的资产");
    }
    else if (but.tag==204)
    {
        NSLog(@"卡券包");
    }
    else if (but.tag==205)
    {
        NSLog(@"我要开店");
    }
    else if (but.tag==206)
    {
        NSLog(@"帮助/反馈");
    }
    else
    {
        NSLog(@"摇一摇");
    }

}

-(void)butClick:(UIButton *)but
{
    if (but.tag==100)
    {
        NSLog(@"待付款");
    }
    else if (but.tag==101)
    {
        NSLog(@"待发货");
    }
    else if (but.tag==102)
    {
        NSLog(@"待收货");
    }
    else if (but.tag==103)
    {
        NSLog(@"待评价");
    }
    else
    {
        NSLog(@"退款/售后");
    }
}

-(void)allSall
{
    NSLog(@"查看全部订单");
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = nil;
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier: SimpleTableIdentifier];
    }
    cell.backgroundColor=[UIColor colorWithRed:235/255.0f green:235/255.0f blue:235/255.0f alpha:1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType=UITableViewCellAccessoryNone;
    return  cell;
}

-(void)btnSet:(id)sender
{
    FCsetViewController *set=[[FCsetViewController alloc]init];
    TMAppDelegate *appDelegate = (TMAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.navigationController pushViewController:set animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
