//
//  UIColor+GXColor.m
//  PetLite
//
//  Created by sawyer3x on 17/5/6.
//  Copyright © 2017年 sawyer3x. All rights reserved.
//

#import "UIColor+GXColor.h"
#import "GXUtilities.h"

@implementation UIColor (GXColor)

//比如：#FF3388、0X22FF11 等颜色字符串转换到RGB
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert {
    if (![GXUtilities isEmpty:stringToConvert]) {
        NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
        
        // String should be 6 or 8 characters
        if ([cString length] < 6) return [UIColor grayColor];
        
        // strip 0X if it appears
        if ([cString hasPrefix:@"0X"]) {
            cString = [cString substringFromIndex:2];
        }
        
        if ([cString hasPrefix:@"#"]) {
            cString = [cString substringFromIndex:1];
        }
        
        if ([cString length] != 6) {
            return [UIColor grayColor];
        }
        
        // Separate into r, g, b substrings
        NSRange range;
        range.location = 0;
        range.length = 2;
        NSString *rString = [cString substringWithRange:range];
        
        range.location = 2;
        NSString *gString = [cString substringWithRange:range];
        
        range.location = 4;
        NSString *bString = [cString substringWithRange:range];
        
        // Scan values
        unsigned int r, g, b;
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        
        return [UIColor colorWithRed:((float) r / 255.0f)
                               green:((float) g / 255.0f)
                                blue:((float) b / 255.0f)
                               alpha:1.0f];
    } else {
        return nil;
    }
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha{
    if (![GXUtilities isEmpty:stringToConvert]) {
        NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
        
        // String should be 6 or 8 characters
        if ([cString length] < 6) return [UIColor grayColor];
        
        // strip 0X if it appears
        if ([cString hasPrefix:@"0X"]) {
            cString = [cString substringFromIndex:2];
        }
        
        if ([cString hasPrefix:@"#"]) {
            cString = [cString substringFromIndex:1];
        }
        
        if ([cString length] != 6) {
            return [UIColor grayColor];
        }
        
        // Separate into r, g, b substrings
        NSRange range;
        range.location = 0;
        range.length = 2;
        NSString *rString = [cString substringWithRange:range];
        
        range.location = 2;
        NSString *gString = [cString substringWithRange:range];
        
        range.location = 4;
        NSString *bString = [cString substringWithRange:range];
        
        // Scan values
        unsigned int r, g, b;
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        
        if (alpha > 1) {
            alpha = 1;
        }else if(alpha < 0){
            alpha = 0;
        }
        
        return [UIColor colorWithRed:((float) r / 255.0f)
                               green:((float) g / 255.0f)
                                blue:((float) b / 255.0f)
                               alpha:alpha];
    } else {
        return nil;
    }
}

// 默认字体颜色
+ (UIColor *)defalutFontColor
{
    return [UIColor colorWithHexString:@"#808080"];
}

// 默认橙色颜色
+ (UIColor *)defalutOrangeColor
{
    return [UIColor colorWithHexString:@"#ff8b1a"];
}

// 默认蓝色颜色
+ (UIColor *)defalutBlueColor
{
    return [UIColor colorWithHexString:@"#355be6"];
}

// 默认红色颜色
+ (UIColor *)defalutRedColor
{
    return [UIColor colorWithHexString:@"#fe332c"];
}

//默认绿色
+ (UIColor *)defalutGreenColor{
    return [UIColor colorWithHexString:@"#B4D748"];
}

// 默认line颜色
+ (UIColor *)defalutLineColor
{
    return [UIColor colorWithHexString:@"#B3B3B3"];
}

+ (UIColor *)defalutTinColor
{
    return [UIColor colorWithHexString:@"#FA794B"];
}

@end
