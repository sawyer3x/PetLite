//
//  PLApiList.h
//  PetLite
//
//  Created by sawyer3x on 17/5/10.
//  Copyright © 2017年 sawyer3x. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLApiList : NSObject

@property (readonly, strong) NSString *ToLogin;//注册/登录前置
@property (readonly, strong) NSString *To_login_new;//注册检测
@property (readonly, strong) NSString *Re_send_security_code;//重发验证码
@property (readonly, strong) NSString *Login;//登录
@property (readonly, strong) NSString *Register;//注册
@property (readonly, strong) NSString *Forget_password;//忘记密码 获取验证码
@property (readonly, strong) NSString *Reset_password;//找回密码

+ (PLApiList *)getApiList;

+ (void)destoryInstance;

@end
