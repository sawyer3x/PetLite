//
//  GXTextField.m
//  PetLite
//
//  Created by sawyer3x on 17/5/10.
//  Copyright © 2017年 sawyer3x. All rights reserved.
//

#import "GXTextField.h"

@implementation GXTextField

//输入框左边提示
+ (UITextField *)setTFLeftMsg:(NSString *)leftmsg msg:(NSString *)placeholder view:(UITextField *)tf {
    return [self setTFLeftMsg:leftmsg msg:placeholder view:tf repeatBtn:NO leftImg:nil rightBtn:NO rightBtnImg:nil];
}

//输入框左边提示，右边定时重发按钮
+ (UITextField *)setTFLeftMsg:(NSString *)leftmsg msg:(NSString *)placeholder view:(UITextField *)tf repeatBtn:(BOOL)repeaterbtn {
    return [self setTFLeftMsg:leftmsg msg:placeholder view:tf repeatBtn:repeaterbtn leftImg:nil rightBtn:NO rightBtnImg:nil];
}

//输入框左边提示，右边按钮
+ (UITextField *)setTFLeftMsg:(NSString *)leftmsg msg:(NSString *)placeholder view:(UITextField *)tf repeatBtn:(BOOL)repeaterbtn leftImg:(UIImage *)leftimg rightBtn:(BOOL)rightbtn {
    return [self setTFLeftMsg:leftmsg msg:placeholder view:tf repeatBtn:repeaterbtn leftImg:leftimg rightBtn:repeaterbtn rightBtnImg:nil];
}

//输入框左边提示，右边定位按钮
+ (UITextField *)setTFLeftMsg:(NSString *)leftmsg msg:(NSString *)placeholder view:(UITextField *)tf repeatBtn:(BOOL)repeaterbtn leftImg:(UIImage *)leftimg rightBtn:(BOOL)rightbtn rightBtnImg:(UIImage *)rightbtnimg {
    tf.borderStyle = UITextBorderStyleRoundedRect;
    UIColor *color = [UIColor colorWithHexString:@"a3a3a3"];
    UIFont *font = [UIFont systemFontOfSize:14.0];
    tf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: color,NSFontAttributeName: font}];
    
    //设置左视图
    if (leftmsg != nil ) {
        UIView *lView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 35)];
        UILabel *lLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 90, 35)];
        lLabel.textColor = [UIColor colorWithHexString:@"808080"];
        lLabel.font = [UIFont systemFontOfSize:14.0];
        lLabel.text = leftmsg;
        [lView addSubview:lLabel];
        tf.leftView = lView;
        tf.leftViewMode = UITextFieldViewModeAlways;
    }
    if (leftimg != nil) {
        UIView *lView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 35)];
        UIImageView *lImgV = [[UIImageView alloc] initWithFrame:CGRectMake(12, 11, 13, 13)];
        [lImgV setImage:leftimg];
        [lView addSubview:lImgV];
        tf.leftView = lView;
        tf.leftViewMode = UITextFieldViewModeAlways;
    }
    
    //设置右试图
    UIView *rView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 35)];
    if (repeaterbtn == YES) {
        UIButton *rBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 35)];
        rBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
        [rBtn setTitleColor:[UIColor colorWithHexString:@"808080"] forState:UIControlStateNormal];
        
        //验证码重发倒计时
        __block int timeout = 60; //倒计时时间
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(timeout <= 0){ //倒计时结束，关闭
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    [rBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                    rBtn.userInteractionEnabled = YES;
                });
            }else{
                int seconds = timeout % 60;
                NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //设置界面的按钮显示 根据自己需求设置
                    [rBtn setTitle:[NSString stringWithFormat:@"重发(%@秒)",strTime] forState:UIControlStateNormal];
                    rBtn.userInteractionEnabled = NO;
                });
                timeout--;
            }
        });
        dispatch_resume(_timer);
        
        [rView addSubview:rBtn];
    }
    if (rightbtn == YES) {
        UIButton *rBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 35)];
        rBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
        [rBtn setTitleColor:[UIColor colorWithHexString:@"808080"] forState:UIControlStateNormal];
        [rBtn setTitle:@"更换 >" forState:UIControlStateNormal];
        [rView addSubview:rBtn];
    }
    if (rightbtnimg != nil) {
        UIButton *rBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 5, 25, 25)];
        [rBtn setImage:rightbtnimg forState:UIControlStateNormal];
        [rView addSubview:rBtn];
    }
    tf.rightView = rView;
    tf.rightViewMode = UITextFieldViewModeAlways;
    
    return tf;
}

//输入框左边图片
+ (UITextField *)setLeftImg:(UIImage *)leftimg msg:(NSString *)placeholder msgColor:(UIColor *)msgColor view:(UITextField *)tf {
    tf.borderStyle = UITextBorderStyleRoundedRect;
    UIColor *color = msgColor;
    UIFont *font = [UIFont systemFontOfSize:14.0];
    NSMutableParagraphStyle *style = [tf.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    style.minimumLineHeight = tf.font.lineHeight - (tf.font.lineHeight - [UIFont fontWithName:@"Helvetica-Bold" size:14.0].lineHeight) / 2.0;
    tf.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder
                                                               attributes:@{NSForegroundColorAttributeName: color,
                                                                            NSFontAttributeName: font,
                                                                            NSParagraphStyleAttributeName:style}];
    
    //设置左视图
    if (leftimg != nil) {
        UIView *lView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 34, 40)];
        UIImageView *lImgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
        [lImgV setImage:leftimg];
        [lView addSubview:lImgV];
        tf.leftView = lView;
        tf.leftViewMode = UITextFieldViewModeAlways;
    }
    
    return tf;
}

@end
