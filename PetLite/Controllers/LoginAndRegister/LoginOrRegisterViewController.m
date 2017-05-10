//
//  LoginOrRegisterViewController.m
//  PetLite
//
//  Created by sawyer3x on 17/5/6.
//  Copyright © 2017年 sawyer3x. All rights reserved.
//

#import "LoginOrRegisterViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface LoginOrRegisterViewController ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSString *lon;
@property (nonatomic, strong) NSString *lat;

@end

@implementation LoginOrRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
}

- (void)setupUI {
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(getH(90));
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(getW(232), getH(206)));
    }];
    imageView.image = [UIImage imageNamed:@"wx_login_green"];
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(getH(68));
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(getW(280), getH(50)));
    }];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:19];
    registerBtn.backgroundColor = [UIColor defalutTinColor];
    registerBtn.layer.cornerRadius = 4;
    [registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(registerBtn.mas_bottom).offset(getH(20));
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(getW(280), getH(50)));
    }];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor defalutTinColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:19];
    loginBtn.backgroundColor = [UIColor whiteColor];
    loginBtn.layer.cornerRadius = 4;
    loginBtn.layer.borderWidth = 1;
    loginBtn.layer.borderColor = [[UIColor defalutTinColor] CGColor];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark 注册
-(void)registerBtnClick
{
    RegisterVC *registerVC = [[RegisterVC alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

#pragma mark 登录
-(void)loginBtnClick
{
    LoginVC *loginVC = [[LoginVC alloc] init];
    loginVC.lat = self.lat;
    loginVC.lon = self.lon;
    [self.navigationController pushViewController:loginVC animated:YES];
}

@end
