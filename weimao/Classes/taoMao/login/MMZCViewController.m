//
//  MMZCViewController.m
//  MMR
//
//  Created by qianfeng on 15/6/30.
//  Copyright © 2015年 MaskMan. All rights reserved.
//

#import "MMZCViewController.h"
#import "forgetPassWardViewController.h"
//#import "AppDelegate.h"
#import "MMZCHMViewController.h"

@interface MMZCViewController ()
{
    UIImageView *View;
    UIView *bgView;
    UITextField *pwd;
    UITextField *user;
    UIButton *QQBtn;
    UIButton *weixinBtn;
    UIButton *xinlangBtn;
}
@property(copy,nonatomic) NSString * accountNumber;
@property(copy,nonatomic) NSString * mmmm;
@property(copy,nonatomic) NSString * user;


@end

@implementation MMZCViewController

-(void)viewWillAppear:(BOOL)animated
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.view.backgroundColor=[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    //设置NavigationBar背景颜色
    View=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    View.backgroundColor=[UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1];
    View.image=[UIImage imageNamed:@"bg4"];
    [self.view addSubview:View];
    
//    UIImageView *nav_line=[self createImageViewFrame:CGRectMake(0, 65, self.view.frame.size.width, 1) imageName:nil color:[UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:1.0]];
//    [self.view addSubview:nav_line];
   
    //为了显示背景图片自定义navgationbar上面的三个按钮
    UIButton *but =[[UIButton alloc]initWithFrame:CGRectMake(5, 27, 35, 35)];
    [but setImage:[UIImage imageNamed:@"goback_back_orange_on"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(clickaddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    UIButton *zhuce =[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-60, 30, 50, 30)];
    [zhuce setTitle:@"注册" forState:UIControlStateNormal];
    [zhuce setTitleColor:[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1] forState:UIControlStateNormal];
    zhuce.font=[UIFont systemFontOfSize:17];
    [zhuce addTarget:self action:@selector(zhuce) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zhuce];
    
    
    UILabel *lanel=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-30)/2, 30, 50, 30)];
    lanel.text=@"登录";
    lanel.textColor=[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1];
    [self.view addSubview:lanel];

    
    [self createButtons];
    [self createImageViews];
    [self createTextFields];
    
    [self createLabel];
}

-(void)clickaddBtn:(UIButton *)button
{
//      [kAPPDelegate appDelegateInitTabbar];
    self.view.backgroundColor=[UIColor whiteColor];
    exit(0);
}


-(void)createLabel
{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-140)/2, 370, 140, 21)];
    label.text=@"第三方账号快速登录";
    label.textColor=[UIColor grayColor];
    label.textAlignment=UITextAlignmentCenter;
    label.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:label];
}

-(void)createTextFields
{
    CGRect frame=[UIScreen mainScreen].bounds;
    bgView=[[UIView alloc]initWithFrame:CGRectMake(10, 75, frame.size.width-20, 90)];
    bgView.layer.cornerRadius=3.0;
    bgView.alpha=0.7;
    bgView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:bgView];
    
    user=[self createTextFielfFrame:CGRectMake(60, 5, 271, 30) font:[UIFont systemFontOfSize:14] placeholder:@"请输入您手机号码"];
    //user.text=@"13419693608";
    user.keyboardType=UIKeyboardTypeNumberPad;
    user.clearButtonMode = UITextFieldViewModeWhileEditing;
   
    pwd=[self createTextFielfFrame:CGRectMake(60, 55, 271, 30) font:[UIFont systemFontOfSize:14]  placeholder:@"密码" ];
    pwd.clearButtonMode = UITextFieldViewModeWhileEditing;
    //pwd.text=@"123456";
    //密文样式
    pwd.secureTextEntry=YES;
    //pwd.keyboardType=UIKeyboardTypeNumberPad;

    
    UIImageView *userImageView=[self createImageViewFrame:CGRectMake(20, 5, 25, 25) imageName:@"ic_landing_nickname" color:nil];
    UIImageView *pwdImageView=[self createImageViewFrame:CGRectMake(20, 55, 25, 25) imageName:@"mm_normal" color:nil];
    UIImageView *line1=[self createImageViewFrame:CGRectMake(20, 45, bgView.frame.size.width-40, 1) imageName:nil color:[UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:.3]];
    
    [bgView addSubview:user];
    [bgView addSubview:pwd];
    
    [bgView addSubview:userImageView];
    [bgView addSubview:pwdImageView];
    [bgView addSubview:line1];
}


-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [user resignFirstResponder];
    [pwd resignFirstResponder];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [user resignFirstResponder];
    [pwd resignFirstResponder];
}

-(void)createImageViews
{
    //    UIImageView *userImageView=[self createImageViewFrame:CGRectMake(25, 10, 25, 25) imageName:@"ic_landing_nickname" color:nil];
    //    UIImageView *pwdImageView=[self createImageViewFrame:CGRectMake(25, 60, 25, 25) imageName:@"ic_landing_password" color:nil];
    //    UIImageView *line1=[self createImageViewFrame:CGRectMake(25, 50, 260, 1.5) imageName:nil color:[UIColor lightGrayColor]];
    //
    //    //UIImageView *line2=[self createImageViewFrame:CGRectMake(88, 210, 280, 1) imageName:nil color:[UIColor grayColor]];
    
    UIImageView *line3=[self createImageViewFrame:CGRectMake(2, 380, 90, 1) imageName:nil color:[UIColor lightGrayColor]];
    UIImageView *line4=[self createImageViewFrame:CGRectMake(self.view.frame.size.width-90-4, 380, 90, 1) imageName:nil color:[UIColor lightGrayColor]];
    
    //    [bgView addSubview:userImageView];
    //    [bgView addSubview:pwdImageView];
    //    [bgView addSubview:line1];
    //[self.view addSubview:line2];
    [self.view addSubview:line3];
    [self.view addSubview:line4];
    
}


-(void)createButtons
{
    UIButton *landBtn=[self createButtonFrame:CGRectMake(10, 190, self.view.frame.size.width-20, 37) backImageName:nil title:@"登录" titleColor:[UIColor whiteColor]  font:[UIFont systemFontOfSize:19] target:self action:@selector(landClick)];
    landBtn.backgroundColor=[UIColor colorWithRed:248/255.0f green:144/255.0f blue:34/255.0f alpha:1];
    landBtn.layer.cornerRadius=5.0f;
    
    UIButton *newUserBtn=[self createButtonFrame:CGRectMake(5, 235, 70, 30) backImageName:nil title:@"快速注册" titleColor:[UIColor grayColor] font:[UIFont systemFontOfSize:13] target:self action:@selector(registration:)];
    //newUserBtn.backgroundColor=[UIColor lightGrayColor];
    
    UIButton *forgotPwdBtn=[self createButtonFrame:CGRectMake(self.view.frame.size.width-75, 235, 60, 30) backImageName:nil title:@"找回密码" titleColor:[UIColor grayColor] font:[UIFont systemFontOfSize:13] target:self action:@selector(fogetPwd:)];
    //fogotPwdBtn.backgroundColor=[UIColor lightGrayColor];
  
    
      #define Start_X 60.0f           // 第一个按钮的X坐标
      #define Start_Y 440.0f           // 第一个按钮的Y坐标
      #define Width_Space 50.0f        // 2个按钮之间的横间距
      #define Height_Space 20.0f      // 竖间距
      #define Button_Height 50.0f    // 高
      #define Button_Width 50.0f      // 宽


    
    //微信
    weixinBtn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-45)/2, 420, 45, 45)];
    //weixinBtn.tag = UMSocialSnsTypeWechatSession;
    weixinBtn.layer.cornerRadius=22.5;
    weixinBtn=[self createButtonFrame:weixinBtn.frame backImageName:@"ic_landing_wechat" title:nil titleColor:nil font:nil target:self action:@selector(onClickWX:)];
    //qq
    QQBtn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-45)/2-100, 420, 45, 45)];
    //QQBtn.tag = UMSocialSnsTypeMobileQQ;
    QQBtn.layer.cornerRadius=22.5;
    QQBtn=[self createButtonFrame:QQBtn.frame backImageName:@"ic_landing_qq" title:nil titleColor:nil font:nil target:self action:@selector(onClickQQ:)];
    
    //新浪微博
    xinlangBtn=[[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width-45)/2+100, 420, 45, 45)];
    //xinlangBtn.tag = UMSocialSnsTypeSina;
    xinlangBtn.layer.cornerRadius=22.5;
    xinlangBtn=[self createButtonFrame:xinlangBtn.frame backImageName:@"ic_landing_microblog" title:nil titleColor:nil font:nil target:self action:@selector(onClickSina:)];
    
    [self.view addSubview:weixinBtn];
    [self.view addSubview:QQBtn];
    [self.view addSubview:xinlangBtn];
    [self.view addSubview:landBtn];
    [self.view addSubview:newUserBtn];
    [self.view addSubview:forgotPwdBtn];

    
}


- (void)onClickQQ:(UIButton *)button
{
}

- (void)onClickWX:(UIButton *)button
{
}


- (void)onClickSina:(UIButton *)button
{
    
}

                     
-(UITextField *)createTextFielfFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder
{
    UITextField *textField=[[UITextField alloc]initWithFrame:frame];
    
    textField.font=font;
    
    textField.textColor=[UIColor grayColor];
    
    textField.borderStyle=UITextBorderStyleNone;
    
    textField.placeholder=placeholder;
    
    return textField;
}

-(UIImageView *)createImageViewFrame:(CGRect)frame imageName:(NSString *)imageName color:(UIColor *)color
{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:frame];
    
    if (imageName)
    {
        imageView.image=[UIImage imageNamed:imageName];
    }
    if (color)
    {
        imageView.backgroundColor=color;
    }
    
    return imageView;
}

-(UIButton *)createButtonFrame:(CGRect)frame backImageName:(NSString *)imageName title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font target:(id)target action:(SEL)action
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    if (imageName)
    {
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    if (font)
    {
        btn.titleLabel.font=font;
    }
    
    if (title)
    {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (color)
    {
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
    if (target&&action)
    {
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}


//登录
-(void)landClick
{
    if ([user.text isEqualToString:@""])
    {
        ShowMessage(@"亲,请输入用户名");
        return;
    }
    else if (user.text.length <11)
    {
        ShowMessage(@"您输入的手机号码格式不正确");
        return;
    }
    else if ([pwd.text isEqualToString:@""])
    {
        ShowMessage(@"亲,请输入密码");
        return;
    }
    else if (pwd.text.length <6)
    {
        ShowMessage(@"亲,密码长度至少六位");
        return;
    }
    else{
        [[NSUserDefaults standardUserDefaults]setObject:@"islogin" forKey:@"islogin"];
        FCTabBarController *view1 = [[FCTabBarController alloc] init];
        [self.navigationController pushViewController:view1 animated:YES];
        
    }
    
}

//注册
-(void)zhuce
{
    [self.navigationController pushViewController:[[MMZCHMViewController alloc]init] animated:YES];
}

-(void)registration:(UIButton *)button
{
   [self.navigationController pushViewController:[[MMZCHMViewController alloc]init] animated:YES];
}

-(void)fogetPwd:(UIButton *)button
{
   [self.navigationController pushViewController:[[forgetPassWardViewController alloc]init] animated:YES];
}

#pragma mark - 工具
//手机号格式化
-(NSString*)getHiddenStringWithPhoneNumber:(NSString*)number middle:(NSInteger)countHiiden{
    // if (number.length>6) {
    
    if (number.length<countHiiden) {
        return number;
    }
    NSInteger count=countHiiden;
    NSInteger leftCount=number.length/2-count/2;
    NSString *xings=@"";
    for (int i=0; i<count; i++) {
        xings=[NSString stringWithFormat:@"%@%@",xings,@"*"];
    }
    
    NSString *chuLi=[number stringByReplacingCharactersInRange:NSMakeRange(leftCount, count) withString:xings];
    // chuLi=[chuLi stringByReplacingCharactersInRange:NSMakeRange(number.length-count, count-leftCount) withString:xings];
    
    return chuLi;
}

//手机号格式化后还原
-(NSString*)getHiddenStringWithPhoneNumber1:(NSString*)number middle:(NSInteger)countHiiden{
    // if (number.length>6) {
    if (number.length<countHiiden) {
        return number;
    }
    NSString *xings=@"";
    for (int i=0; i<1; i++) {
        //xings=[NSString stringWithFormat:@"%@",[CheckTools getUser]];
    }
    
    NSString *chuLi=[number stringByReplacingCharactersInRange:NSMakeRange(0, 0) withString:@""];
    // chuLi=[chuLi stringByReplacingCharactersInRange:NSMakeRange(number.length-count, count-leftCount) withString:xings];
    
    return chuLi;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
