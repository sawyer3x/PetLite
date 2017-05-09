//
//  MainTabBarViewController.m
//  PetLite
//
//  Created by sawyer3x on 17/5/6.
//  Copyright © 2017年 sawyer3x. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "MainNavigationViewController.h"
#import "PetViewController.h"
#import "FriendsViewController.h"
#import "MineViewController.h"

@interface MainTabBarViewController ()<UITabBarDelegate, UITabBarControllerDelegate> {
  
    MainNavigationViewController *petNC;
    MainNavigationViewController *friendNC;
    MainNavigationViewController *mineNC;
    
}

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addAllControllers];
}

- (void)addAllControllers {
    //遛宠
    PetViewController *petVC = [[PetViewController alloc] init];
    petVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"遛宠" image:[[UIImage imageNamed:@"walkdog_unsel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"walkdog_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    petNC = [[MainNavigationViewController alloc] initWithRootViewController:petVC];
    
    //好友
    FriendsViewController * friendsVC = [[FriendsViewController alloc]init];
    friendsVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"好友" image:[[UIImage imageNamed:@"credit_unsel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"credit_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    friendNC = [[MainNavigationViewController alloc] initWithRootViewController:friendsVC];
    
    //我的
    MineViewController * mineVC = [[MineViewController alloc]init];
    mineVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[[UIImage imageNamed:@"mine_unsel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"mine_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    mineNC = [[MainNavigationViewController alloc] initWithRootViewController:mineVC];
    
    [[UITabBar appearance] setTintColor:[UIColor defalutTinColor]];
    self.viewControllers = @[petNC, friendNC, mineNC];
    self.delegate = self;
}

@end
