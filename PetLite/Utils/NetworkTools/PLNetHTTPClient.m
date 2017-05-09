//
//  PLNetHTTPClient.m
//  PetLite
//
//  Created by sawyer3x on 17/5/9.
//  Copyright © 2017年 sawyer3x. All rights reserved.
//

#import "PLNetHTTPClient.h"
#import "AFHTTPRequestOperation.h"

NSString * const AFHTTPClientErrorDomain = @"com.tongbanjie.httpClient";
NSInteger const AFHTTPClientBackgroundTaskExpiredError = -1001;

@implementation PLNetHTTPClient

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    
    [self setDefaultHeader:@"MDevice" value:@"IPHONE"];
    [self setDefaultHeader:@"CVersion" value:kBundleVersion];
    [self setDefaultHeader:@"ChannelName" value:kChannel];
    [self setDefaultHeader:@"x-access-token" value:[[NSUserDefaults standardUserDefaults] objectForKey:kAccessToken([[NSUserDefaults standardUserDefaults] objectForKey:kUserPhoneNo])]];
    NSLog(@"x-access-token is %@",[[NSUserDefaults standardUserDefaults] objectForKey:kAccessToken([[NSUserDefaults standardUserDefaults] objectForKey:kUserPhoneNo])]);
    [self setDefaultHeader:@"Authorization" value:@"IPHONE"];
    [self setParameterEncoding:AFFormURLParameterEncoding];
    
    _timeoutInterval = 20;

    return self;
}

#pragma mark - Authorization
- (NSString *)Authorization {
    return [self defaultValueForHeader:@"Authorization"] ? : @"";
}

- (void)setAuthorization:(NSString *)authorization {
    if (authorization.length > 0) {
        [self setDefaultHeader:@"Authorization" value:authorization];
    }
}

- (void)cancelRequest:(NSString *)requestPath
{
    [self cancelAllHTTPOperationsWithMethod:@"POST" path:requestPath];
}

/**
 *异步post请求
 *
 */
-(void)postRequestPath:(NSString *)path parameters:(id)parameters success:(PLHttpSuccessBlock)success failure:(PLHttpFailureBlock)failure {
#if DEBUG
    if (![[self.baseURL absoluteString] hasPrefix:kServerUserUrl ]) {
        PetHttpLog(@"\n===================================\
                   \npath: %@\nparams: %@\
                   \n===================================",
                   [self.baseURL URLByAppendingPathComponent:path], (parameters ?: @""));
    }
#endif
    
    [super postPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, NSData * responseData) {
        if (responseData.length > 0) {
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
            
            if (responseDic) {
                PLRequestBodyInfo *requestBodyInfo = [responseDic returnRequestBodyInfo];
                
                if (requestBodyInfo.requestCode != kPetServiceStatusNormal || requestBodyInfo.errorCode) {
                    PetHttpLog(@"\n===================================\
                               \npath: %@\nparams: %@\
                               \n\U0001F621\U0001F622\U0001F622\U0001F622\U0001F621:\
                               \nserviceCode: %@\
                               \nErrorMsg: %@\
                               \n===================================",
                               operation.request.URL, (parameters ?: @""), requestBodyInfo.errorCode, requestBodyInfo.errorMsg);
                }
                if (success) {
                    GXHandleBlock(success, requestBodyInfo, operation)
                }
            } else {
                GXHandleBlock(failure, kPetServiceStatusJSONDataError, operation, nil);
            }
        } else {
            GXHandleBlock(failure, kPetServiceStatusDataEmpty, operation, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error.code != NSURLErrorCancelled) {
            PetHttpLog(@"\n===================================\
                       \npath: %@\nparams: %@\
                       \n\U0001F621\U0001F621: %@\
                       \n===================================",
                       operation.request.URL, (parameters ?: @""), [error localizedDescription]);
            NSInteger httpCode = operation.response.statusCode;
            if (httpCode != kPetServiceStatusNotModified) {
                GXHandleBlock(failure, kPetServiceStatusOther, operation, error);
            } else {
                GXHandleBlock(success, [[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kPetServiceStatusNotModified] forKey:kPetServiceResponseCode] returnRequestBodyInfo], operation);
            }
        }
    }];
}

/**
 *异步get请求
 *
 */
- (void)getRequestPath:(NSString *)path parameters:(id)parameters success:(PLHttpSuccessBlock)success failure:(PLHttpFailureBlock)failure {
#if DEBUG
    if (![[self.baseURL absoluteString] hasPrefix:kServerUserUrl ]) {
        PetHttpLog(@"\n===================================\
                   \npath: %@\nparams: %@\
                   \n===================================",
                   [self.baseURL URLByAppendingPathComponent:path], (parameters ?: @""));
    }
#endif
    
    [super getPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, NSData *responseData) {
        if (responseData.length > 0) {
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
            if (responseDic) {
                PLRequestBodyInfo *requestBofyInfo = [responseDic returnRequestBodyInfo];
                
                if (requestBofyInfo.requestCode != kPetServiceStatusNormal || requestBofyInfo.errorCode) {
                    PetHttpLog(@"\n===================================\
                               \npath: %@\nparams: %@\
                               \n\U0001F621\U0001F621\U0001F621\U0001F621\U0001F621:\
                               \nserviceCode: %@\
                               \nErrorMsg: %@\
                               \n===================================",
                               operation.request.URL, (parameters ?: @""), requestBofyInfo.errorCode, requestBofyInfo.errorMsg);
                }
                
                if (success) {
                    GXHandleBlock(success, requestBofyInfo, operation);
                }
            } else {
                GXHandleBlock(failure, kPetServiceStatusJSONDataError, operation, nil);
            }
        } else {
            GXHandleBlock(failure, kPetServiceStatusDataEmpty, operation, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (error.code != NSURLErrorCancelled) {
            PetHttpLog(@"\n===================================\
                       \npath: %@\nparams: %@\
                       \n\U0001F621\U0001F621\U0001F621\U0001F621\U0001F621: %@\
                       \n===================================",
                       operation.request.URL, (parameters ?: @""), [error localizedDescription]);
            NSInteger httpCode = operation.response.statusCode;
            if (httpCode != kPetServiceStatusNotModified) {
                GXHandleBlock(failure, kPetServiceStatusOther, operation, error);
            } else {
                GXHandleBlock(success, [[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kPetServiceStatusNotModified] forKey:kPetServiceResponseCode] returnRequestBodyInfo], operation);
            }
        }
    }];
}

//上传图片
- (void)upLoadImageRequestPath:(NSString *)path parameters:(id)parameters imageData:(NSData *)imageData dataName:(NSString *)dataName success:(PLHttpSuccessBlock)success failure:(PLHttpFailureBlock)failure
{
#if DEBUG
    if (![[self.baseURL absoluteString] hasPrefix:kServerUserUrl ]) {
        PetHttpLog(@"\n===================================\
                   \npath: %@\nparams: %@\
                   \n===================================",
                   [self.baseURL URLByAppendingPathComponent:path], (parameters ?: @""));
    }
#endif

    NSURLRequest *request =  [super multipartFormRequestWithMethod:@"POST" path:path parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png",str];
        [formData appendPartWithFileData:imageData name:dataName fileName:fileName mimeType:@"image/png"];
    }];
    
    AFHTTPRequestOperation *op =[super HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *responseData=responseObject;
        
        if (responseData.length > 0) {
            //解析数据
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
            if (responseDic) { //如果有数据
                //数据解析
                PLRequestBodyInfo *requestBofyInfo = [responseDic returnRequestBodyInfo];
                if (requestBofyInfo.requestCode != kPetServiceStatusNormal || requestBofyInfo.errorCode) {
                    PetHttpLog(@"\n===================================\
                               \npath: %@\nparams: %@\
                               \n\U0001F621\U0001F621\U0001F621\U0001F621\U0001F621:\
                               \nserviceCode: %@\
                               \nErrorMsg: %@\
                               \n===================================",
                               operation.request.URL, (parameters ?: @""), requestBofyInfo.errorCode, requestBofyInfo.errorMsg);
                }
                if (success) {
                    GXHandleBlock(success, requestBofyInfo, operation);
                }
                
            } else {
                GXHandleBlock(failure, kPetServiceStatusJSONDataError, operation, nil);
            }
        } else {
            GXHandleBlock(failure, kPetServiceStatusDataEmpty, operation, nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 如果不是用户取消请求
        if (error.code != NSURLErrorCancelled) {
            PetHttpLog(@"\n===================================\
                       \npath: %@\nparams: %@\
                       \n\U0001F621\U0001F621\U0001F621\U0001F621\U0001F621: %@\
                       \n===================================",
                       operation.request.URL, (parameters ?: @""), [error localizedDescription]);
            NSInteger httpCode = operation.response.statusCode;
            if (httpCode != kPetServiceStatusNotModified) {
                GXHandleBlock(failure, kPetServiceStatusOther, operation, error);
            } else {
                GXHandleBlock(success, [[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kPetServiceStatusNotModified] forKey:kPetServiceResponseCode] returnRequestBodyInfo], operation);
            }
        }
        
    }];
    
    [super enqueueHTTPRequestOperation:op];
}

//上传图片+进度条
- (void)upLoadImageRequestPath:(NSString *)path parameters:(id)parameters imageData:(NSData *)imageData dataName:(NSString *)dataName success:(PLHttpSuccessBlock)success failure:(PLHttpFailureBlock)failure complain:(PLHttpUploadingBlock)complain
{
#if DEBUG
    if (![[self.baseURL absoluteString] hasPrefix:kServerUserUrl ]) {
        PetHttpLog(@"\n===================================\
                   \npath: %@\nparams: %@\
                   \n===================================",
                   [self.baseURL URLByAppendingPathComponent:path], (parameters ?: @""));
    }
#endif
    //    NSLog(@"imageData%@",imageData);
    NSURLRequest *request =  [super multipartFormRequestWithMethod:@"POST" path:path parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png",str];
        [formData appendPartWithFileData:imageData name:dataName fileName:fileName mimeType:@"image/png"];
    }];
    
    AFHTTPRequestOperation *op =[super HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *responseData=responseObject;
        
        if (responseData.length > 0) {
            //解析数据
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
            if (responseDic) { //如果有数据
                //数据解析
                PLRequestBodyInfo *requestBofyInfo = [responseDic returnRequestBodyInfo];
                if (requestBofyInfo.requestCode != kPetServiceStatusNormal || requestBofyInfo.errorCode) {
                    PetHttpLog(@"\n===================================\
                               \npath: %@\nparams: %@\
                               \n\U0001F621\U0001F621\U0001F621\U0001F621\U0001F621:\
                               \nserviceCode: %@\
                               \nErrorMsg: %@\
                               \n===================================",
                               operation.request.URL, (parameters ?: @""), requestBofyInfo.errorCode, requestBofyInfo.errorMsg);
                }
                if (success) {
                    GXHandleBlock(success, requestBofyInfo, operation);
                }
                
            } else {
                GXHandleBlock(failure, kPetServiceStatusJSONDataError, operation, nil);
            }
        } else {
            GXHandleBlock(failure, kPetServiceStatusDataEmpty, operation, nil);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 如果不是用户取消请求
        if (error.code != NSURLErrorCancelled) {
            PetHttpLog(@"\n===================================\
                       \npath: %@\nparams: %@\
                       \n\U0001F621\U0001F621\U0001F621\U0001F621\U0001F621: %@\
                       \n===================================",
                       operation.request.URL, (parameters ?: @""), [error localizedDescription]);
            NSInteger httpCode = operation.response.statusCode;
            if (httpCode != kPetServiceStatusNotModified) {
                GXHandleBlock(failure, kPetServiceStatusOther, operation, error);
            } else {
                GXHandleBlock(success, [[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kPetServiceStatusNotModified] forKey:kPetServiceResponseCode] returnRequestBodyInfo], operation);
            }
        }
        
    }];
    
    // 4. 设置上传进度块.
    [op setUploadProgressBlock:^(NSUInteger __unused bytesWritten,
                                 long long totalBytesWritten,//已上传的字节数
                                 long long totalBytesExpectedToWrite)//总字节数
     {
         //每次上传一部分数据，都会调用此块输出进度，可以在此方法中设置你的上传进度条页面
         NSLog(@"Wrote %lld/%lld", totalBytesWritten, totalBytesExpectedToWrite);
         complain((float)totalBytesWritten/totalBytesExpectedToWrite);
     }];
    
    [super enqueueHTTPRequestOperation:op];
}


@end
