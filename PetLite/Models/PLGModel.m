//
//  PLGModel.m
//  PetLite
//
//  Created by sawyer3x on 17/5/10.
//  Copyright © 2017年 sawyer3x. All rights reserved.
//

#import "PLGModel.h"

@implementation PLGModel

static PLGModel *sharedModel = nil;

+ (PLGModel *)sharePLGModel
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedModel = [[PLGModel alloc] init];
        [sharedModel initData];
    });
    return sharedModel;
}

- (void)initData
{
    _loadingArrayManage = [[NSMutableArray alloc] init];
}

@end
