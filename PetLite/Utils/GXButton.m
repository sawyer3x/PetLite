//
//  GXButton.m
//  PetLite
//
//  Created by sawyer3x on 17/5/10.
//  Copyright © 2017年 sawyer3x. All rights reserved.
//

#import "GXButton.h"

@implementation GXButton

+ (UIButton *)setButton:(UIButton *)btn withTitle:(NSString *)title{
    
    [btn setTitle:title forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor defalutTinColor];
    btn.layer.cornerRadius = 8;
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    return btn;
}

+ (UIButton *)withBtnImage:(NSString *)btnImage frame: (CGRect)frame andImageAndLabelText:(NSString *)bntLabelText AlsoDeatilText:(NSString *)detail;
{
    UIButton *baseBtn = [[UIButton alloc] initWithFrame:frame];
    UIImageView *btnImageView = [[UIImageView alloc] initWithFrame:CGRectMake(gotW(15) , gotH(15), gotW(45) , gotH(45))];
    [baseBtn addSubview:btnImageView];
    
    btnImageView.image = [UIImage imageNamed:btnImage];
    
    UILabel *btnLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btnImageView.frame)+gotW(15), gotH(15), gotW(70), gotH(30))];
    btnLabel.text = bntLabelText;
    btnLabel.font = [UIFont systemFontOfSize:12.0];
    btnLabel.textColor = [UIColor colorWithHexString:@"#505050"];
    [baseBtn addSubview:btnLabel];
    
    UILabel *btnDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btnImageView.frame)+gotW(15), CGRectGetMaxY(btnLabel.frame)-gotH(15), gotW(70), gotH(30))];
    btnDetailLabel.text = bntLabelText;
    btnDetailLabel.tag = 100001;
    btnDetailLabel.font = [UIFont systemFontOfSize:10.0];
    btnDetailLabel.textColor = [UIColor colorWithHexString:@"#b3b3b3"];
    [baseBtn addSubview:btnDetailLabel];
    
    return baseBtn;
}

@end
