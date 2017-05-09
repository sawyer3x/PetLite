//
//  GXUtilities.m
//  PetLite
//
//  Created by sawyer3x on 17/5/6.
//  Copyright © 2017年 sawyer3x. All rights reserved.
//

#import "GXUtilities.h"

@implementation GXUtilities

+(BOOL)isEmpty:(id) object
{
    if (object == nil || [object isKindOfClass:[NSNull class]] ||([object isKindOfClass:[NSString class]] && [[object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]) ||([object isKindOfClass:[NSString class]] && [object isEqualToString:@"(null)"]) || ([object isKindOfClass:[NSString class]] && [object isEqualToString:@"<null>"]))
    {
        return YES;
    }else
    {
        return NO;
    }
}

+ (float)getWidth:(NSString *)text font:(UIFont *)font
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
        
        NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                              font, NSFontAttributeName,
                                              nil];
        CGSize sizeUp7 = [text boundingRectWithSize:CGSizeMake(1000, 25) options:NSStringDrawingUsesFontLeading attributes:attributesDictionary context:nil].size;
        return sizeUp7.width;
    }
    
    CGSize size = [text sizeWithFont:font constrainedToSize:CGSizeMake(1000, 25) lineBreakMode:1];
    return  size.width;
}

+(void) showView:(UIView *) view
{
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

@end
