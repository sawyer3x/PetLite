//
//  GXLabel.h
//  PetLite
//
//  Created by sawyer3x on 17/5/10.
//  Copyright © 2017年 sawyer3x. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    myVerticalAlignmentNone = 0,
    myVerticalAlignmentCenter,
    myVerticalAlignmentTop,
    myVerticalAlignmentBottom
} myVerticalAlignment;

@interface GXLabel : UILabel

@property (nonatomic) UIEdgeInsets edgeInsets;
/**
 *  对齐方式
 */
@property (nonatomic) myVerticalAlignment verticalAlignment;

+ (UILabel *)setLabel:(UILabel *)label withText:(NSString *)text;

+ (UILabel *)setLabel:(UILabel *)label withText:(NSString *)text withColor:(NSString *)color withFont:(UIFont *)font;

+ (UILabel *)setLabel:(UILabel *)label withStrokeWidth:(id)width withStrokeColor:(NSString *)color;

@end
