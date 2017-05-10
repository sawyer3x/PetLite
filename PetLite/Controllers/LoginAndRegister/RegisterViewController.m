//
//  RegisterViewController.m
//  PetLite
//
//  Created by sawyer3x on 17/5/10.
//  Copyright © 2017年 sawyer3x. All rights reserved.
//

#import "RegisterViewController.h"

#define kTimeCountDown      60

@interface RegisterViewController ()<UITextFieldDelegate> {
    GXTextField *phoneNum;
    GXTextField *pwdNum;
    BOOL isRightPhoneNum;
    UIImageView *huskyHead;
    GXTextField *vCodeNum;
    GXButton *vCodeBtn;
    GXLabel *vCodeL;
}

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor whiteColor];

    [self addLeftNavItemWithPopSelector];
    
    [self setupUI];
    
    // 点击空白返回键盘
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
}

- (void)viewTapped:(UIGestureRecognizer *)tap
{
    [self.view endEditing:YES];
}

- (void)setupUI {
    UIView *head = [[UIView alloc] init];
    [self.view addSubview:head];
    [head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(kGSize.width, getH(200)));
    }];
    head.backgroundColor = [UIColor defalutTinColor];
    
    huskyHead = [[UIImageView alloc] init];
    [self.view addSubview:huskyHead];
    [huskyHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(getH(41));
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(getW(180), getH(180)));
    }];
    huskyHead.image = [UIImage imageNamed:@"husky_open_eyes"];
    
    phoneNum = [[GXTextField alloc] init];
    [self.view addSubview:phoneNum];
    [phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(head.mas_bottom).with.offset(getH(25));
        make.size.mas_equalTo(CGSizeMake(getW(315), getH(44)));
    }];
    phoneNum.layer.cornerRadius = 4;
    phoneNum.layer.borderWidth = 1;
    phoneNum.layer.borderColor = [[UIColor colorWithHexString:@"#c0c0c0"] CGColor];
    [GXTextField setLeftImg:[UIImage imageNamed:@"phoneno"] msg:@"输入手机号码" msgColor:[UIColor colorWithHexString:@"#a0a0a0"] view:phoneNum];
    phoneNum.keyboardType = UIKeyboardTypePhonePad;
    phoneNum.delegate = self;
    
    vCodeNum = [[GXTextField alloc] init];
    [self.view addSubview:vCodeNum];
    [vCodeNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneNum.mas_left);
        make.top.equalTo(phoneNum.mas_bottom).with.offset(getH(20));
        make.size.mas_equalTo(CGSizeMake(getW(210), getH(44)));
    }];
    vCodeNum.layer.cornerRadius = 4;
    vCodeNum.layer.borderWidth = 1;
    vCodeNum.layer.borderColor = [[UIColor colorWithHexString:@"#c0c0c0"] CGColor];
    [GXTextField setLeftImg:[UIImage imageNamed:@"vcode"] msg:@"验证码" msgColor:[UIColor colorWithHexString:@"#a0a0a0"] view:vCodeNum];
    vCodeNum.delegate = self;
    
    vCodeBtn = [[GXButton alloc] init];
    [self.view addSubview:vCodeBtn];
    [vCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(phoneNum.mas_right);
        make.top.equalTo(vCodeNum);
        make.size.mas_equalTo(CGSizeMake(getW(90), getH(44)));
    }];
    vCodeBtn.layer.cornerRadius = 4;
    vCodeBtn.backgroundColor = [UIColor defalutGreenColor];
    [vCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [vCodeBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    vCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [vCodeBtn addTarget:self action:@selector(vCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    pwdNum = [[GXTextField alloc] init];
    [self.view addSubview:pwdNum];
    [pwdNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(vCodeNum.mas_bottom).with.offset(getH(20));
        make.size.mas_equalTo(CGSizeMake(getW(315), getH(44)));
    }];
    pwdNum.layer.cornerRadius = 4;
    pwdNum.layer.borderWidth = 1;
    pwdNum.layer.borderColor = [[UIColor colorWithHexString:@"#c0c0c0"] CGColor];
    [GXTextField setLeftImg:[UIImage imageNamed:@"pwd"] msg:@"输入密码" msgColor:[UIColor colorWithHexString:@"#a0a0a0"] view:pwdNum];
    pwdNum.secureTextEntry = YES;
    pwdNum.delegate = self;
    
    UIButton *registerBtn = [[UIButton alloc] init];
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(pwdNum.mas_bottom).with.offset(getH(30));
        make.size.mas_equalTo(CGSizeMake(getW(315), getH(44)));
    }];
    registerBtn.layer.cornerRadius = 4;
    registerBtn.layer.borderWidth = 1;
    registerBtn.layer.borderColor = [[UIColor colorWithHexString:@"#c0c0c0"] CGColor];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor colorWithHexString:@"#404040"] forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - btn click
-(void)vCodeBtnClick{
    //手机号判断
    if ([GXUtilities isEmpty:phoneNum.text]) {
        kGXAlert(@"请填写手机号码");
        return;
    }
    if (isRightPhoneNum == NO) {
        kGXAlert(@"请填写正确的手机号码。");
        return;
    }
    [GXUtilities showLoding];
    [[PLNetService sharedService] newcheckUserWithPhone:phoneNum.text success:^(PetServiceStatus status, int phoneCheck) {
        [GXUtilities hideLoding];
        NSLog(@"sucess: %ld %d",(long)status,phoneCheck);
        if (phoneCheck == 0) {
            //用户未注册或没设置密码，发送验证码
            vCodeBtn.enabled = NO;
            vCodeL = [[CYLabel alloc] init];
            [self.view addSubview:vCodeL];
            [vCodeL mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(vCodeBtn);
                make.centerY.equalTo(vCodeBtn);
                make.size.mas_equalTo(CGSizeMake(getW(80), getH(40)));
            }];
            vCodeL.textAlignment = NSTextAlignmentCenter;
            [GXUtilities showLoding];
            [[PetNetService sharedService] reSendSecurityCodeWithPhone:phoneNum.text success:^(PetServiceStatus status, PetRequestBodyInfo *requestBodyInfo) {
                [GXUtilities hideLoding];
                if (status == kPetServiceStatusNormal) {
                    [self dateLimite];
                    vCodeBtn.enabled = NO;
                }else{
                    vCodeL.hidden = YES;
                    vCodeBtn.enabled = YES;
                }
                
            } failure:^(PetServiceStatus serviceCode, AFHTTPRequestOperation *requestOP, NSError *error) {
                vCodeL.hidden = YES;
                vCodeBtn.enabled = YES;
                [GXUtilities hideLoding];
            }];
            
        }else if(phoneCheck == 1)
        {
            [GXUtilities showNetErrorView:@"喵，该账号已注册"];
        }
    } failure:^(PetServiceStatus serviceCode, AFHTTPRequestOperation *requestOP, NSError *error) {
        [GXUtilities hideLoding];
        NSLog(@"failure%ld: %@ %@",(long)serviceCode,requestOP,error);
    }];
}

-(void)registerBtnClick{
    //注册
    if ([GXUtilities isEmpty:vCodeNum.text]) {
        kGXAlert(@"验证码不可为空");
        return;
    }
    if ([GXUtilities isEmpty:pwdNum.text]) {
        kGXAlert(@"密码不可为空,请正确填写登录密码");
        return;
    }
    if (pwdNum.text.length < 6||pwdNum.text.length > 20) {
        kGXAlert(@"请输入6~20个字符长度内的密码。");
        return;
    }
    
    [GXUtilities showLoding];
    [[PetNetService sharedService] userRegisterWithPhone:phoneNum.text securityCode:vCodeNum.text pwd:pwdNum.text success:^(PetServiceStatus status, PetRequestBodyInfo *requestBodyInfo) {
        [GXUtilities hideLoding];
        if (requestBodyInfo.requestCode == 0) {
            if (status == kPetServiceStatusNormal) {
                [self login];
            }
        }
    } failure:^(PetServiceStatus serviceCode, AFHTTPRequestOperation *requestOP, NSError *error) {
        [GXUtilities hideLoding];
        NSLog(@"请求失败");
    }];
}

#pragma mark - 短信倒计时
- (void)dateLimite{
    __block int timeout = kTimeCountDown;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        if (timeout <= 0) {
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                vCodeL.text = @"获取验证码";
                vCodeL.hidden = YES;
                //                vCodeBtn.hidden = NO;
                [vCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                vCodeBtn.backgroundColor = [UIColor defalutTinColor];
                vCodeBtn.enabled = YES;
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                vCodeL.hidden = NO;
                [CYLabel setLabel:vCodeL withText:[NSString stringWithFormat:@"剩余%dS", timeout]];
                vCodeBtn.backgroundColor = [UIColor colorWithHexString:@"#c0c0c0"];
                //                vCodeBtn.hidden = YES;
                [vCodeBtn setTitle:nil forState:UIControlStateNormal];
                timeout--;
            });
        }
    });
    dispatch_resume(timer);
}

#pragma mark - UITextField delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    PetLog(@"%@",textField)
    if (textField == phoneNum) {
        if(textField.isFirstResponder)
            huskyHead.image = [UIImage imageNamed:@"husky_open_eyes"];
    }
    if (textField == vCodeNum) {
        if(textField.isFirstResponder)
            huskyHead.image = [UIImage imageNamed:@"husky_open_eyes"];
    }
    if (textField == pwdNum) {
        if(textField.isFirstResponder)
            huskyHead.image = [UIImage imageNamed:@"husky_close_eyes"];
    }
    
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![phoneNum isExclusiveTouch]) {
        [phoneNum resignFirstResponder];
    }
    if (![vCodeNum isExclusiveTouch]) {
        [vCodeNum resignFirstResponder];
    }
    if (![pwdNum isExclusiveTouch]) {
        [pwdNum resignFirstResponder];
        huskyHead.image = [UIImage imageNamed:@"husky_open_eyes"];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == phoneNum) {
        NSInteger strLength = textField.text.length - range.length + string.length;
        if (strLength > 11){
            return NO;
        }
        NSString *text = nil;
        //如果string为空，表示删除
        if (string.length > 0) {
            text = [NSString stringWithFormat:@"%@%@",textField.text,string];
        }else{
            text = [textField.text substringToIndex:range.location];
        }
        if ([self isValidatePhone:text]) {
            PetLog(@"手机号格式正确");
            isRightPhoneNum = YES;
        }else{
            PetLog(@"手机号格式错误");
            isRightPhoneNum = NO;
        }
    }
    return YES;
}

#pragma mark - methods
- (void)login {
    [GXUtilities showLoding];
    [[PetNetService sharedService] userLoginWithPhone:phoneNum.text pwd:pwdNum.text lon:nil lat:nil clientId:[[NSUserDefaults standardUserDefaults] valueForKey:kClientId] appType:@"1" success:^(PetServiceStatus status, PetRequestBodyInfo *requestBodyInfo) {
        [GXUtilities hideLoding];
        if (status == kPetServiceStatusNormal) {
            // self diss
            PetLog(@"登录成功===》%@",[[NSUserDefaults standardUserDefaults] valueForKey:kClientId]);
            NSLog(@"kAccessToken is %@",[[NSUserDefaults standardUserDefaults] objectForKey:kAccessToken([[NSUserDefaults standardUserDefaults] objectForKey:kUserPhoneNo])]);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadLoginStatus" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadLoginStatuss" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadLoginStatusss" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadPetInfo" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"setLoginBtn" object:nil];
            //====================
            //            [self dismissSelf];
            //            //登录成功
            //            TabBarViewController *tableBarVC = [[TabBarViewController alloc]initWithNibName:@"TabBarViewController" bundle:nil];
            //            [self presentViewController:tableBarVC animated:YES completion:nil];
            //====================跳信息完善页面
            
            NSDictionary *dicResultEntiy = [requestBodyInfo.requestBodyDic objectForKey:@"data"];
            NSString *userId = [dicResultEntiy valueForKey:@"userId"];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSString * nickIdString = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUserId]];
                //环信注册登录
                if (![EMClient sharedClient].isLoggedIn) {
                    [[PushEasePartObject sharedInstance]loginHuanxin:nickIdString];
                }else{
                    if (![[EMClient sharedClient].currentUsername isEqual:nickIdString]) {
                        EMError *error = [[EMClient sharedClient] logout:YES];
                        if (!error) {
                            [[PushEasePartObject sharedInstance]loginHuanxin:nickIdString];
                        }
                    }
                }
            });
            
            //注册成功登录之后完善信息
            FillTheUserInfomationViewController * vc = [[FillTheUserInfomationViewController alloc]init];
            vc.ifWxLogin = NO;
            vc.navigationItem.hidesBackButton = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else
        {
            PetLog(@"内部业务错误");
        }
    } failure:^(PetServiceStatus serviceCode, AFHTTPRequestOperation *requestOP, NSError *error) {
        [GXUtilities hideLoding];
        [GXUtilities showNetErrorView:kGXViewMgs];
    }];
}

/**
 *  手机号码验证
 *
 *  @param phone 传入的手机号码
 *
 *  @return 格式正确返回true  错误 返回fals
 */
-(BOOL)isValidatePhone:(NSString *)phone
{
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170
    //    测试号段:171
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[016-8])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:phone];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNav];
}

-(void)setNav
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

/**
 *  纯色生成图片
 *
 *  @param color 颜色
 *
 *  @return 图片
 */
-(UIImage*)createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)pop{
    [super pop];
}

@end
