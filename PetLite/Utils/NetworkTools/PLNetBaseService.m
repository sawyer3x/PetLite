//
//  PLNetBaseService.m
//  PetLite
//
//  Created by sawyer3x on 17/5/10.
//  Copyright © 2017年 sawyer3x. All rights reserved.
//

#import "PLNetBaseService.h"

@implementation PLNetBaseService

+ (instancetype)sharedService {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"%@ must implemention `sharedService` class method", NSStringFromClass([self class])]
                                 userInfo:nil];
}

#pragma mark - Cancel
- (void)cancelRequest:(NSString *)path {
    if (self.client) {
        [self.client cancelRequest:path];
    }
}

@end
