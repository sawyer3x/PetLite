//
//  PLLoadingView.m
//  PetLite
//
//  Created by sawyer3x on 17/5/10.
//  Copyright © 2017年 sawyer3x. All rights reserved.
//

#import "PLLoadingView.h"

@implementation PLLoadingView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        NSMutableArray *arrayRefImg = [[NSMutableArray alloc] init];
        
        for (int i = 1; i <= 14; i++) {
            [arrayRefImg addObject:[UIImage imageNamed:[NSString stringWithFormat:@"n_refresh_%d.png", i]]];
        }
        
        _animationImageView  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"n_refresh_1"]];
        _animationImageView.frame = CGRectMake(0, 0, 60.f, 60.f);
        _animationImageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        _animationImageView.animationImages = arrayRefImg;
        _animationImageView.animationDuration = 2;
        _animationImageView.animationRepeatCount = 0;
        _animationImageView.contentMode = UIViewContentModeCenter;  //24  24
        [self addSubview:_animationImageView];
        
        [_animationImageView startAnimating];
        
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7f];
        self.layer.cornerRadius = 5;
    }
    
    return self;
}

//有用吗？
-(void)animationStart:(BOOL)isStop
{
    if (isStop)
    {
        [_animationImageView stopAnimating];
    }
}

@end
