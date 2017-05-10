//
//  PLNetService.h
//  PetLite
//
//  Created by sawyer3x on 17/5/10.
//  Copyright © 2017年 sawyer3x. All rights reserved.
//

#import "PLNetBaseService.h"

@interface PLNetService : PLNetBaseService

+ (instancetype)sharedService;

- (void)cancelRequest:(NSString *)path;

// 获取用户accessToken
-(NSString *) getAccessToken;

- (void)reSetAccessToken:(NSString *)accessToken;

// 检测号码是否已注册
- (void)newcheckUserWithPhone:(NSString *)phone success:(void (^)(PLServiceStatus status, int phoneCheck))success failure:(PLHttpFailureBlock)failure;

// 用户注册
- (void)userRegisterWithPhone:(NSString *)phone securityCode:(NSString *)secrutityCode pwd:(NSString *)password success:(void (^)(PLServiceStatus status, PLRequestBodyInfo *requestBodyInfo))success failure:(PLHttpFailureBlock)failure;

// 用户掉线？？
-(void) userOutLogin;

// 用户登录
- (void)userLoginWithPhone:(NSString *)phone pwd:(NSString *)password lon:(NSString *)lon lat:(NSString *)lat clientId:(NSString *)cid appType:(NSString *)appType success:(void (^)(PLServiceStatus status, PLRequestBodyInfo *requestBodyInfo))success failure:(PLHttpFailureBlock)failure;

// 重发验证码
- (void)reSendSecurityCodeWithPhone:(NSString *)phone success:(void (^)(PLServiceStatus status, PLRequestBodyInfo *requestBodyInfo))success failure:(PLHttpFailureBlock)failure;
@end
