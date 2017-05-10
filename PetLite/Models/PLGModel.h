//
//  PLGModel.h
//  PetLite
//
//  Created by sawyer3x on 17/5/10.
//  Copyright © 2017年 sawyer3x. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLGModel : NSObject

@property (nonatomic, strong) PLUserInfo *userInfo;

@property (nonatomic, strong) NSString *accessToken;

@property (nonatomic, strong) NSString *userId;

@property (nonatomic, strong) NSMutableArray *loadingArrayManage;

+ (PLGModel *)sharePLGModel;

@end
