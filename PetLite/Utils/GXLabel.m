//
//  GXLabel.m
//  PetLite
//
//  Created by sawyer3x on 17/5/10.
//  Copyright © 2017年 sawyer3x. All rights reserved.
//

#import "GXLabel.h"

@implementation GXLabel

- (void)setVerticalAlignment:(myVerticalAlignment)verticalAlignment
{
    verticalAlignment= verticalAlignment;
    [self setNeedsDisplay];
}

- (void)drawTextInRect:(CGRect)rect
{
    if (_verticalAlignment == myVerticalAlignmentNone)
    {
        [super drawTextInRect:UIEdgeInsetsInsetRect(self.bounds, self.edgeInsets)];
    }
    else
    {
        CGRect textRect = [self textRectForBounds:UIEdgeInsetsInsetRect(rect, self.edgeInsets) limitedToNumberOfLines:self.numberOfLines];
        [super drawTextInRect:textRect];
    }
    
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (_verticalAlignment) {
        case myVerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
            
        case myVerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
            
        case myVerticalAlignmentCenter:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
            break;
            
        default:
            break;
    }
    return textRect;
}

+ (UILabel *)setLabel:(UILabel *)label withText:(NSString *)text{
    
    [GXLabel setLabel:label withText:text withColor:@"808080" withFont:[UIFont systemFontOfSize:13.0]];
    return label;
}

+ (UILabel *)setLabel:(UILabel *)label withText:(NSString *)text withColor:(NSString *)color withFont:(UIFont *)font{
    label.text = text;
    label.font = font;
    label.textColor = [UIColor colorWithHexString:color];
    return label;
}

+ (UILabel *)setLabel:(UILabel *)label withStrokeWidth:(id)width withStrokeColor:(NSString *)color{
    NSString *string = label.text;
    NSRange range = [string rangeOfString:string];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    [attrString addAttribute:NSStrokeColorAttributeName value:[UIColor colorWithHexString:color] range:range];//设置文字描边颜色，需要和NSStrokeWidthAttributeName设置描边宽度，这样就能使文字空心
    [attrString addAttribute:NSStrokeWidthAttributeName value:width range:range];//空心字，文字边框描述
    NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle alloc] init];
    [ps setAlignment:NSTextAlignmentCenter];
    [attrString addAttribute:NSParagraphStyleAttributeName value:ps range:range];
    [attrString addAttribute:NSBaselineOffsetAttributeName value:@(-6) range:range];
    label.attributedText = attrString;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}


@end
