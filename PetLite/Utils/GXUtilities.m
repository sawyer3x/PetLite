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

+ (void)showLoding
{
    [self showLodingLType:kPLLoadingFullScreen userEnabled:YES];
}


+ (void)showLodingLType:(PLLoadingType)type userEnabled:(BOOL)enabled
{
    NSArray *loadingViews = [[PetGModel sharePetGModel] loadingArrayManage];
    for (UIView * subView in loadingViews) {
        if ([subView isKindOfClass:[PetLoadingView class]]) {
            [subView removeFromSuperview];
        }
    }
    CGRect loadingFrame; // 哈哈
    loadingFrame = CGRectMake((kGSize.width - 60)*0.5, (kGSize.height - 60)*0.5, 60, 60);
    //    if (type == 0) {
    //        loadingFrame = CGRectMake(0, 0, kGSize.width, kGSize.height);
    //    } else if (type == 1){
    //        loadingFrame = CGRectMake(0, 64, kGSize.width, kGSize.height - 64);
    //    } else if (type == 2) {
    //        loadingFrame = CGRectMake(0, 64, kGSize.width, kGSize.height - 64 -49);
    //    }
    
    PetLoadingView *loadingView = [[PetLoadingView alloc] initWithFrame:loadingFrame];
    loadingView.userInteractionEnabled = NO;
    [[UIApplication sharedApplication].keyWindow addSubview:loadingView];
    //    loadingView.center = [UIApplication sharedApplication].keyWindow.center;
    [[[PetGModel sharePetGModel] loadingArrayManage] addObject:loadingView];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:loadingView];
    [UIApplication sharedApplication].keyWindow.userInteractionEnabled = enabled;
}

//+ (void)showLodingTitle:(NSString *)title toucheEnabled:(BOOL)enabled
//{
//    for (UIView * subView in [[UIApplication sharedApplication].keyWindow subviews])
//    {
//        if ([subView isKindOfClass:[GXLoadingIView class]]) {
//            subView.hidden = YES;
//            [GXUtilities fadeView:subView time:.3f];
//            [subView removeFromSuperview];
//        }
//    }
//
//    GXLoadingIView *loding = [[GXLoadingIView alloc] initWithFrame:CGRectMake(0, 0, 70, 50)];
//    loding.layer.cornerRadius = 10;
//    if(title == nil)
//    {
//        loding.title = @"请稍后";
//    }else
//    {
//        loding.title = title;
//    }
//
//    loding.center = CGPointMake([UIApplication sharedApplication].keyWindow.center.x, [UIApplication sharedApplication].keyWindow.center.y);
//    [[UIApplication sharedApplication].keyWindow addSubview:loding];
//    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:loding];
//    [GXUtilities fadeView:loding time:.3f];
//    [UIApplication sharedApplication].keyWindow.userInteractionEnabled = enabled;
//}

+ (void)hideLoding
{
    for (UIView * subView in [[UIApplication sharedApplication].keyWindow subviews])
    {
        if ([subView isKindOfClass:[PetLoadingView class]])
        {
            subView.hidden = YES;
            [GXUtilities fadeView:subView time:.3f];
            [subView removeFromSuperview];
        }
    }
    [[[PetGModel sharePetGModel] loadingArrayManage] removeAllObjects];
    [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;
}

+(void) showNetErrorView
{
    AppDelegate *appDelegate = kGetAppDelegate;
    [appDelegate.erroNetView showSelfViewWithTitle:nil];
}

+(void) showNetErrorView:(NSString *) strMgs
{
    AppDelegate *appDelegate = kGetAppDelegate;
    if ([GXUtilities isEmpty:strMgs])
    {
        [appDelegate.erroNetView showSelfViewWithTitle:nil];
    }else
    {
        [appDelegate.erroNetView showSelfViewWithTitle:strMgs];
    }
}

+(void) showNetErrorView:(NSString *) strMgs attrString:(NSAttributedString *) AttrStr
{
    AppDelegate *appDelegate = kGetAppDelegate;
    if ([GXUtilities isEmpty:strMgs])
    {
        [appDelegate.erroNetView showSelfViewWithTitle:nil];
    }else
    {
        [appDelegate.erroNetView showSelfViewWithAttrString:AttrStr Title:strMgs];
    }
}

@end
