//
//  PLApiList.m
//  PetLite
//
//  Created by sawyer3x on 17/5/10.
//  Copyright © 2017年 sawyer3x. All rights reserved.
//

#import "PLApiList.h"

static PLApiList *api = nil;

@interface PLApiList()

- (void)setupApi;

@end

@implementation PLApiList

- (id)init {
    self = [super init];
    if (self) {
        [self setupApi];
    }
    return self;
}

- (void)setupApi {
    _ToLogin = [NSString stringWithFormat:@"%@",@"/api/v01/user/to_login"];
    _To_login_new = [NSString stringWithFormat:@"%@",@"/api/v01/user/to_login_new"];
    _Re_send_security_code = [NSString stringWithFormat:@"%@",@"/api/v01/user/re_send_security_code"];
    _Login = [NSString stringWithFormat:@"%@",@"/api/v01/user/login"];
    _Register = [NSString stringWithFormat:@"%@",@"/api/v01/user/register"];
    _Forget_password = [NSString stringWithFormat:@"%@",@"/api/v01/user/send_code_forget_psw"];
    _Reset_password = [NSString stringWithFormat:@"%@",@"/api/v01/user/reset_password"];
}

@end
