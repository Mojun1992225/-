//
//  FCTabBarController.m
//  
//
//  Created by  on 13-4-17.
//  Copyright (c) 2013年 chen wei. All rights reserved.
//

#import "FCTabBarController.h"
#import "LTKNavigationViewController.h"
#import "TMHomePageViewController.h"
#import "TMClassicViewController.h"
#import "TMShopCarViewController.h"
#import "TMBuildShopStoreViewController.h"
#import "TMMySotreViewController.h"
#import "LTKSeachViewController.h"
#import "MineViewController.h"

@implementation FCTabBarController

-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability* curReach=[note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    NetworkStatus status=[curReach currentReachabilityStatus];
    if (status==NotReachable) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"当前没有网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    
}
-(void)viewWillAppear:(BOOL)animated
{
   
    [super viewWillAppear:animated];
         self.navigationController.navigationBarHidden=YES;
   
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    CGRect screenRect = [[UIScreen mainScreen] bounds];



    
   TMHomePageViewController  *daoHangViewController= [[TMHomePageViewController alloc] init];
    UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@""]tag:-300];
    daoHangViewController.tabBarItem = item1;
    
    TMClassicViewController *homeViewController = [[TMClassicViewController alloc]init];
    UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@""]tag:-301];
    homeViewController.tabBarItem = item2;

    LTKSeachViewController  *gongying = [[LTKSeachViewController alloc] initSeachKeyWord:nil];
    UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@""]tag:-302];
    gongying.tabBarItem = item3;

    TMShopCarViewController *shoppingViewController= [[TMShopCarViewController alloc]initWithTabbar:YES];
    UITabBarItem *item4 = [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@""]tag:-303];
    shoppingViewController.tabBarItem = item4;
    
    MineViewController *mineViewController = [[MineViewController alloc]init];
    UITabBarItem *item5= [[UITabBarItem alloc] initWithTitle:@"" image:[UIImage imageNamed:@""]tag:-304];
    mineViewController.tabBarItem = item5;


    LTKNavigationViewController*navigationController1= [[LTKNavigationViewController alloc] initWithRootViewController:daoHangViewController];
    LTKNavigationViewController *navigationController2 = [[LTKNavigationViewController alloc] initWithRootViewController:homeViewController];
    
    LTKNavigationViewController *navigationController4=[[LTKNavigationViewController alloc]initWithRootViewController:gongying];
    LTKNavigationViewController*navigationController5= [[LTKNavigationViewController alloc] initWithRootViewController:shoppingViewController];
    
    LTKNavigationViewController *navigationController3 = [[LTKNavigationViewController alloc] initWithRootViewController:mineViewController];
//
    NSArray *viewArray = [NSArray arrayWithObjects:navigationController1,navigationController2, navigationController4,navigationController5,navigationController3, nil];

    self.viewControllers = viewArray;

}



-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [viewController viewWillAppear:animated];
}

-(void)btnPress:(id)sender
{


}

-(void)dealloc
{
//    [tabBarArrow release];
    [super dealloc];
}
@end
