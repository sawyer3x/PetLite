//
//  PLNetBaseService.h
//  PetLite
//
//  Created by sawyer3x on 17/5/10.
//  Copyright © 2017年 sawyer3x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLNetHTTPClient.h"

@interface PLNetBaseService : NSObject

@property (nonatomic, strong)  PLNetHTTPClient *client;

+ (instancetype)sharedService;

@end
