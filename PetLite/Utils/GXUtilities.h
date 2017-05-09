//
//  GXUtilities.h
//  PetLite
//
//  Created by sawyer3x on 17/5/6.
//  Copyright © 2017年 sawyer3x. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GXUtilities : NSObject

/**
 *  判断对象是否为空
 *
 *  @param object <#object description#>
 *
 *  @return bool
 */
+(BOOL) isEmpty:(id) object;

/**
 *  获取文本的宽度
 *
 *  @param text     <#text description#>
 *  @param font <#showView description#>
 *
 *  @return <#return value description#>
 */
+ (float)getWidth:(NSString *)text font:(UIFont *)font;

/**
 *  显示view
 *
 *  @param view <#view description#>
 */
+(void) showView:(UIView *) view;

@end
