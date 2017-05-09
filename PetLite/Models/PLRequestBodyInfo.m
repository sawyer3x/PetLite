//
//  PLRequestBodyInfo.m
//  PetLite
//
//  Created by sawyer3x on 17/5/9.
//  Copyright © 2017年 sawyer3x. All rights reserved.
//

#import "PLRequestBodyInfo.h"

@implementation PLRequestBodyInfo

@end

@implementation NSDictionary (PLRequestBodyInfo)

- (PLRequestBodyInfo *)returnRequestBodyInfo {
    PLRequestBodyInfo *bodyInfo = [[PLRequestBodyInfo alloc] init];
    bodyInfo.requestBodyDic = (NSDictionary *)self;
    
    NSString *levelStr = [self objectForKey:@"level"];
    if ([levelStr isEqualToString:kRequestSucess]) {
        bodyInfo.requestCode = 0;
    } else if ([levelStr isEqualToString:kRequestError]) {
        bodyInfo.requestCode = 1;
        
        if (![GXUtilities isEmpty:bodyInfo.requestBodyDic]) {
            bodyInfo.errorCode = [bodyInfo.requestBodyDic objectForKey:@"error_code"];
            bodyInfo.errorMsg = [bodyInfo.requestBodyDic objectForKey:@"message"];
        }
    }
    
    return bodyInfo;
}

@end
