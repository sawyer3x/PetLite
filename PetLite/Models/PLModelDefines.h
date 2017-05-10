//
//  PLModelDefines.h
//  PetLite
//
//  Created by sawyer3x on 17/5/10.
//  Copyright © 2017年 sawyer3x. All rights reserved.
//

#ifndef PetMarginMerchant_PetModelDefines_h
#define PetMarginMerchant_PetModelDefines_h

typedef NS_ENUM(NSUInteger, PhoneCheckState) {
    kPhoneStateFormatError = 0,                     // 号码格式错误
    kPhoneStateNoPassword,                          // 密码未设置
    kPhoneStateNoRegister,                          // 尚未注册
};

typedef NS_ENUM(NSInteger, PLLoadingType) {
    kPLLoadingFullScreen = 0,
    kPLLoadingWithoutNav = 1,
    kPLLoadingWithoutNavAndTabbar = 2
};

#endif
