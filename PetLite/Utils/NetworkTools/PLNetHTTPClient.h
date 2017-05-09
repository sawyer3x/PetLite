//
//  PLNetHTTPClient.h
//  PetLite
//
//  Created by sawyer3x on 17/5/9.
//  Copyright © 2017年 sawyer3x. All rights reserved.
//

#import "AFHTTPClient.h"
#import "PLRequestBodyInfo.h"

#define kPetServiceResponseCode            @"level"         // 状态
#define kPetServiceResponseData            @"data"          // 返回数据DataKey

#ifdef DEBUG
#   define PetHttpLog(fmt, ...)            NSLog((fmt), ##__VA_ARGS__);
#else
#   define PetHttpLog(...)
#endif

typedef NS_ENUM(NSInteger, PLServiceStatus) {
    kPetServiceStatusNormal = 0,                            // 正常返回
    kPetServiceStatusBusinessError = 1,                     // 业务错误
    //    kPetServiceStatusLogicError = 2,                        // 內部逻辑错误，如出现此处错误 应联系后台
    //    kPetServiceStatusAuthorizeError = 10,                   // 未授权
    //    kPetServiceStatusAccessDeniedError = 11,                // 访问拒绝(非法访问, 比如非手机客户端访问)
    //    kPetServiceStatusVersionLowerError = 20,                // 版本过低
    kPetServiceStatusDataEmpty = 300,                       // 接口数据为空
    kPetServiceStatusJSONDataError,                         // 接口数据JSON格式错误
    kPetServiceStatusNotModified = 304,                     // 304 数据无修改
    kPetServiceStatusOther                                  // 其他错误
};

/**
 *  请求正确(非网络错误)block
 *
 *  @param requestBodyInfo  封装result状态码
 *  @param requestOP    请求OP
 */
typedef void(^PLHttpSuccessBlock)(PLRequestBodyInfo *requestBodyInfo, AFHTTPRequestOperation *requestOP);

/**
 *  请求错误block 主要应该是网络错误
 *
 *  @param serviceCode 封装result状态码
 *  @param requestOP   请求OP
 *  @param error       错误Error
 */
typedef void(^PLHttpFailureBlock)(PLServiceStatus serviceCode, AFHTTPRequestOperation *requestOP, NSError *error);

/**
 *  上传图片block
 *
 *  @param uploadingRate xxx
 */
typedef void(^PLHttpUploadingBlock)(float uploadingRate);

@interface PLNetHTTPClient : AFHTTPClient

@property (nonatomic, strong) NSString *cookie;                     // cookie
@property (nonatomic, assign) NSTimeInterval timeoutInterval;       // 超时时间

/**
 *  取消请求
 *
 */
- (void)cancelRequest:(NSString *)requestPath;

/**
 *  异步Post请求
 *
 */
- (void)postRequestPath:(NSString *)path
         parameters:(id)parameters
            success:(PLHttpSuccessBlock)success
            failure:(PLHttpFailureBlock)failure;

/**
 *  异步Get请求
 *
 */
- (void)getRequestPath:(NSString *)path
         parameters:(id)parameters
            success:(PLHttpSuccessBlock)success
            failure:(PLHttpFailureBlock)failure;

/**
 *上传图片请求
 *
 */
/**
 *上传图片请求
 *
 */
- (void)upLoadImageRequestPath:(NSString *)path parameters:(id)parameters imageData:(NSData *)imageData dataName:(NSString *)dataName success:(PLHttpSuccessBlock)success failure:(PLHttpFailureBlock)failure;

//上传图片+进度条
- (void)upLoadImageRequestPath:(NSString *)path parameters:(id)parameters imageData:(NSData *)imageData dataName:(NSString *)dataName success:(PLHttpSuccessBlock)success failure:(PLHttpFailureBlock)failure complain:(PLHttpUploadingBlock)complain;

@end
