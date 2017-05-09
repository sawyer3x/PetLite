//
//  PLRequestBodyInfo.h
//  PetLite
//
//  Created by sawyer3x on 17/5/9.
//  Copyright © 2017年 sawyer3x. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLRequestBodyInfo : NSObject

@property (nonatomic, assign) int requestCode;
@property (nonatomic, strong) NSDictionary *requestBodyDic;
@property (nonatomic, strong) NSString *errorCode;
@property (nonatomic, strong) NSString *errorMsg;

@end

@interface NSDictionary (PLRequestBodyInfo)

- (PLRequestBodyInfo *)returnRequestBodyInfo;

@end
