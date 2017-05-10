//
//  PLNetService.m
//  PetLite
//
//  Created by sawyer3x on 17/5/10.
//  Copyright © 2017年 sawyer3x. All rights reserved.
//

#import "PLNetService.h"

@implementation PLNetService

+ (instancetype)sharedService {
    static PLNetService *shareManager;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        shareManager = [[PLNetService alloc] init];
    });
     
    shareManager.client = [[PLNetHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:kServerUrl]];
    
    return shareManager;
}

- (void)cancelRequest:(NSString *)path
{
    [self.client cancelRequest:path];
}

- (NSString *)getAccessToken
{
    //    NSString *accessToken = [[NSUserDefaults standardUserDefaults] valueForKey:kAccessToken];
    //    if (![GXUtilities isEmpty:accessToken]) {
    //        return accessToken;
    //    }
    //    [self.client requestPath:kGetAccessTokenPath parameters:nil success:^(PLRequestBodyInfo *requestBodyInfo, AFHTTPRequestOperation *requestOP) {
    //        PetLog(@"%@",requestBodyInfo);
    //
    //    } failure:^(PLServiceStatus serviceCode, AFHTTPRequestOperation *requestOP, NSError *error) {
    //        PetLog(@"请求失败");
    //        ;
    //    }];
    //
    ////    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:kAccessToken];
    ////    [[NSUserDefaults standardUserDefaults] synchronize];
    return nil;
}

- (void)reSetAccessToken:(NSString *) accessToken
{
    if (!accessToken) {
        return;
    }
    [self.client setDefaultHeader:@"x-access-token" value:accessToken];
}

// 检测号码是否已注册
- (void)newcheckUserWithPhone:(NSString *)phone success:(void (^)(PLServiceStatus status, int phoneCheck))success failure:(PLHttpFailureBlock)failure{
    [self cancelRequest:[PLApiList getApiList].To_login_new];
    
    NSDictionary *params = @{@"phone":phone};
    
    [self.client postRequestPath:[PLApiList getApiList].To_login_new parameters:params success:^(PLRequestBodyInfo *requestBodyInfo, AFHTTPRequestOperation *requestOP) {
        int phoneCheck = -1;
        if (![GXUtilities isEmpty:requestBodyInfo]) {
            if ([requestBodyInfo.errorCode isEqualToString:@"PHONE_FORMART_ERROR"] ) {
                if (requestBodyInfo.errorMsg) {
                    kGXAlert(requestBodyInfo.errorMsg);
                }
            }else if(requestBodyInfo.requestCode == kPLServiceStatusNormal)
            {
                phoneCheck = 1;
            }else  if ([requestBodyInfo.errorCode isEqualToString:@"NO_REGISTER"] || ([requestBodyInfo.errorCode isEqualToString:@"NO_PASSWORD"]))//
            {
                phoneCheck = 0;
            }else
            {
                [GXUtilities hideLoding];
                if (requestBodyInfo.errorMsg) {
                    kGXAlert(requestBodyInfo.errorMsg);
                }
            }
        }
        success(YES,phoneCheck);
    } failure:^(PLServiceStatus serviceCode, AFHTTPRequestOperation *requestOP, NSError *error) {
        //        PetLog(@"请求失败");
        PetLog(@"请求失败");
        [GXUtilities hideLoding];
        failure(serviceCode,requestOP,error);
    }];
}

// 用户注册
-(void) userRegisterWithPhone:(NSString *)phone securityCode:(NSString *) secrutityCode pwd:(NSString *)password success:(void (^)(PLServiceStatus status, PLRequestBodyInfo *requestBodyInfo))success failure:(PLHttpFailureBlock)failure
{
    [self cancelRequest:[PLApiList getApiList].Register];
    
    NSDictionary *params = @{@"phone":phone,
                             @"password":password,
                             @"securityCode":secrutityCode};
    [self.client postRequestPath:[PLApiList getApiList].Register parameters:params success:^(PLRequestBodyInfo *requestBodyInfo, AFHTTPRequestOperation *requestOP) {
        PetLog(@"请求成功");
        //access_token  &  userId
        if (![GXUtilities isEmpty:requestBodyInfo]) {
            if (requestBodyInfo.requestCode == kPLServiceStatusNormal) {
                NSDictionary *dicResultEntiy = [requestBodyInfo.requestBodyDic objectForKey:@"data"];
                NSString *accessToken = [dicResultEntiy valueForKey:@"access_token"];
                [[PLGModel sharePLGModel] setAccessToken:accessToken];
                [self reSetAccessToken:accessToken];
                
                NSString *userId = [dicResultEntiy valueForKey:@"userId"];
                [[PLGModel sharePLGModel] setUserId:userId];
                
                // 手机号 密码
                [[NSUserDefaults standardUserDefaults] setValue:phone forKey:kUserPhoneNo];
                [[NSUserDefaults standardUserDefaults] setValue:password forKey:kUserPhonePwd(phone)];
                [[NSUserDefaults standardUserDefaults] setObject:userId forKey:kUserId];
                [[NSUserDefaults standardUserDefaults] setObject:[[PLGModel sharePLGModel] accessToken] forKey:kAccessToken(phone)];
                [[NSUserDefaults standardUserDefaults] synchronize];
                success(kPLServiceStatusNormal,requestBodyInfo);
            }else{
                [GXUtilities hideLoding];
                if (requestBodyInfo.errorMsg) {
                    kGXAlert(requestBodyInfo.errorMsg);
                }
            }
        }
    } failure:^(PLServiceStatus serviceCode, AFHTTPRequestOperation *requestOP, NSError *error) {
        [GXUtilities hideLoding];
        failure(serviceCode,requestOP,error);
    }];
}

// 用户掉线？？
- (void)userOutLogin
{
    // 清除登录信息
    NSString *phone = [[PLGModel sharePLGModel] userInfo].phone;
    //    NSLog(@"%@,%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUserId],[[NSUserDefaults standardUserDefaults] objectForKey:kAccessToken(phone)]);
    //清理手机数据
    [[UserProfileManager sharedInstance]deleteUserData];
    [[EMClient sharedClient].chatManager deleteConversations:[[EMClient sharedClient].chatManager loadAllConversationsFromDB] deleteMessages:YES];
    
    [[PLGModel sharePLGModel] setAccessToken:nil];
    [[PLGModel sharePLGModel] setUserId:nil];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserPhoneNo];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserPhonePwd(phone)];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAccessToken(phone)];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserId];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:UserFansMessageCountAmount];
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:UserFriendsMessageCountAmount];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[WarningWhenWalkingDogPart shareWarning]pauseTimer];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //退出环信
        EMError *error = [[EMClient sharedClient] logout:YES];
        if (!error) {
            NSLog(@"退出成功");
        }
    });
}

// 用户登录
-(void) userLoginWithPhone:(NSString *)phone pwd:(NSString *)password lon:(NSString *)lon lat:(NSString *)lat clientId:(NSString *)cid appType:(NSString *)appType success:(void (^)(PLServiceStatus status, PLRequestBodyInfo *requestBodyInfo))success failure:(PLHttpFailureBlock)failure
{
    [self cancelRequest:[PLApiList getApiList].Login];
    
    
    NSDictionary *params = @{@"phone":phone,
                             @"password":password,
                             @"cid":cid,
                             @"appType":appType
                             };
    
    [self.client postRequestPath:[PLApiList getApiList].Login parameters:params success:^(PLRequestBodyInfo *requestBodyInfo, AFHTTPRequestOperation *requestOP) {
        PetLog(@"请求成功");
        //access_token  &  userId
        if (![GXUtilities isEmpty:requestBodyInfo]) {
            if (requestBodyInfo.requestCode == kPLServiceStatusNormal) {
                // access_token
                NSDictionary *dicResultEntiy = [requestBodyInfo.requestBodyDic objectForKey:@"data"];
                NSString *accessToken = [dicResultEntiy valueForKey:@"access_token"];
                PetLog(@"=====accessToken %@",accessToken);
                [[PLGModel sharePLGModel] setAccessToken:accessToken];
                // 重新设置一次
                [self reSetAccessToken:accessToken];
                
                NSString *userId = [dicResultEntiy valueForKey:@"userId"];
                [[PLGModel sharePLGModel] setUserId:userId];
                
                // 手机号 密码
                [[NSUserDefaults standardUserDefaults] setValue:phone forKey:kUserPhoneNo];
                [[NSUserDefaults standardUserDefaults] setValue:password forKey:kUserPhonePwd(phone)];
                [[NSUserDefaults standardUserDefaults] setObject:[[PLGModel sharePLGModel] accessToken] forKey:kAccessToken(phone)];
                [[NSUserDefaults standardUserDefaults] setObject:userId forKey:kUserId];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                PetLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:kUserId]);
                
                [self saveCidWithCidPart:cid userId:userId appType: @"1" sucess:^(PLServiceStatus status, PLRequestBodyInfo *requestBodyInfo) {
                    PetLog(@"======》保存成功")
                    
                } failure:^(PLServiceStatus serviceCode, AFHTTPRequestOperation *requestOP, NSError *error) {
                    PetLog(@"======》保存失败")
                }];
                
                [self getDetailWithUserId:userId success:^(PLServiceStatus status, PLUserInfo *userInfo, PLRequestBodyInfo *requestBodyInfo) {
                    PetLog(@"请求成功");
                    PLUserInfo *userInfos;
                    if (![GXUtilities isEmpty:requestBodyInfo]) {
                        if (requestBodyInfo.requestCode == 0) {
                            NSDictionary *dicResultEntiy = [requestBodyInfo.requestBodyDic objectForKey:@"data"];
                            userInfos= [dicResultEntiy returnPLUserInfo];
                            [[NSUserDefaults standardUserDefaults] setValue:userInfos.nickName forKey:@"nickName"];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                        }else{
                            //                [GXUtilities hideLoding];
                            [self requestNoNormal:requestBodyInfo];
                        }
                    }
                } failure:^(PLServiceStatus serviceCode, AFHTTPRequestOperation *requestOP, NSError *error) {
                    ;
                }];
                
                success(kPLServiceStatusNormal,requestBodyInfo);
            }else
            {
                success(kPLServiceStatusOther,nil);
                [self requestNoNormal:requestBodyInfo];
                //                kGXAlert(@"内部业务错误，请联系客服");
            }
        }else
        {
            success(kPLServiceStatusOther,nil);
            [self requestNoNormal:requestBodyInfo];
        }
    } failure:^(PLServiceStatus serviceCode, AFHTTPRequestOperation *requestOP, NSError *error) {
        ;
    }];
}

- (void)requestNoNormal:(PLRequestBodyInfo *)requestBodyInfo
{
    [GXUtilities hideLoding];
    if([requestBodyInfo.errorCode isEqualToString:@"INVALID_ACCESS_TOKEN"])
    {
        [self postCallLogin];
    }else if (requestBodyInfo.errorMsg) {
        if ([requestBodyInfo.errorMsg containsString:@"网络繁忙"] || [requestBodyInfo.errorMsg containsString:@"网络不给力"]) {
            return;
        }
        [GXUtilities showNetErrorView:requestBodyInfo.errorMsg];
    }else{
        PetLog(@"PQS---ERR MSG = NULL");
    }
}

-(void) postCallLogin
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotiShowLoginVC object:nil];
}

// 重发验证码
-(void) reSendSecurityCodeWithPhone:(NSString *) phone success:(void (^)(PLServiceStatus status, PLRequestBodyInfo *requestBodyInfo))success failure:(PLHttpFailureBlock)failure
{
    [self cancelRequest:[PLApiList getApiList].Re_send_security_code];
    
    NSDictionary *params = @{@"phone":phone};
    [self.client postRequestPath:[PLApiList getApiList].Re_send_security_code parameters:params success:^(PLRequestBodyInfo *requestBodyInfo, AFHTTPRequestOperation *requestOP) {
        if (![GXUtilities isEmpty:requestBodyInfo]) {
            if(requestBodyInfo.requestCode == kPLServiceStatusNormal)
            {
                success(kPLServiceStatusNormal,requestBodyInfo);
            }else
            {
                [self requestNoNormal:requestBodyInfo];
            }
        }
    } failure:^(PLServiceStatus serviceCode, AFHTTPRequestOperation *requestOP, NSError *error) {
        PetLog(@"请求失败");
        failure(serviceCode,requestOP,error);
    }];
}

@end
