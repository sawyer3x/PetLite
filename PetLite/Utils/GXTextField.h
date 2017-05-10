//
//  GXTextField.h
//  PetLite
//
//  Created by sawyer3x on 17/5/10.
//  Copyright © 2017年 sawyer3x. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GXTextField : UITextField

//输入框左边提示
+ (UITextField *)setTFLeftMsg:(NSString *)leftmsg msg:(NSString *)placeholder view:(UITextField *)tf;

//输入框左边提示，右边定时重发按钮
+ (UITextField *)setTFLeftMsg:(NSString *)leftmsg msg:(NSString *)placeholder view:(UITextField *)tf repeatBtn:(BOOL)repeaterbtn;

//输入框左边提示，右边按钮
+ (UITextField *)setTFLeftMsg:(NSString *)leftmsg msg:(NSString *)placeholder view:(UITextField *)tf repeatBtn:(BOOL)repeaterbtn leftImg:(UIImage *)leftimg rightBtn:(BOOL)rightbtn;

//输入框左边提示，右边定位按钮
+ (UITextField *)setTFLeftMsg:(NSString *)leftmsg msg:(NSString *)placeholder view:(UITextField *)tf repeatBtn:(BOOL)repeaterbtn leftImg:(UIImage *)leftimg rightBtn:(BOOL)rightbtn rightBtnImg:(UIImage *)rightbtnimg;

//输入框左边图片
+ (UITextField *)setLeftImg:(UIImage *)leftimg msg:(NSString *)placeholder msgColor:(UIColor *)msgColor view:(UITextField *)tf;

@end
