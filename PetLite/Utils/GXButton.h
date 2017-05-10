//
//  GXButton.h
//  PetLite
//
//  Created by sawyer3x on 17/5/10.
//  Copyright © 2017年 sawyer3x. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GXButton : UIButton

+ (UIButton *)setButton:(UIButton *)btn withTitle:(NSString *)title;

+ (UIButton *)withBtnImage:(NSString *)btnImage frame: (CGRect)frame andImageAndLabelText:(NSString *)bntLabelText AlsoDeatilText:(NSString *)detail;

@end
