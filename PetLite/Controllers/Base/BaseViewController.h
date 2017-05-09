//
//  BaseViewController.h
//  PetLite
//
//  Created by sawyer3x on 17/5/6.
//  Copyright © 2017年 sawyer3x. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, strong) BaseViewController *baseView;

- (void)setLeftNavItem:(UIImage *)image selector:(SEL)sel;

- (void)setRightNavItem:(UIImage *)image selector:(SEL)sel;

- (void)setLeftNavItemWithTitle:(NSString *)title selector:(SEL)sel;

- (void)setRightNavItemWithTitle:(NSString *)title selector:(SEL)sel;

// 默认返回
- (void)addLeftNavItemWithPopSelector;

- (void)showBack:(SEL)sel backName:(NSString *)title;

- (void)pop;

@end
