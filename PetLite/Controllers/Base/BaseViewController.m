//
//  BaseViewController.m
//  PetLite
//
//  Created by sawyer3x on 17/5/6.
//  Copyright © 2017年 sawyer3x. All rights reserved.
//

#import "BaseViewController.h"
#import "MainNavigationViewController.h"
#import "LoginOrRegisterViewController.h"

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f0f0"];
    
    if (kIOS7) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callLoginVC:) name:kNotiShowLoginVC object:nil];
    
}

- (void)showBack:(SEL)sel backName:(NSString *)title {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(51, 0, 55, 43)];
    btn.exclusiveTouch = YES;
    btn.tag = 101;
    [btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"backNormal.png"] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"#595959"] forState:UIControlStateNormal];
    [[btn titleLabel] setFont:[UIFont systemFontOfSize:17]];
    
    if (kIOS7) {
        [btn setImageEdgeInsets:UIEdgeInsetsMake(2,-18,0,0)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(2,-14,0,0)];
    } else {
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0,0, 7)];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 7, 0, 0)];
    }
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

#pragma mark - show back
- (void)showBackNoText:(SEL)sel backName:(NSString *)title {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(41, 0, 55, 43)];
    btn.exclusiveTouch = YES;
    btn.tag = 101;
    [btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:(CGFloat)99/255 green:(CGFloat)152/255 blue:(CGFloat)200/255 alpha:1] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:(CGFloat)59/255 green:(CGFloat)93/255 blue:(CGFloat)119/255 alpha:1] forState:UIControlStateHighlighted];
    [[btn titleLabel] setFont:[UIFont systemFontOfSize:17]];
    if (kIOS7) {
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(2,-14,0,0)];
    } else {
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 7, 0, 0)];
    }
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

- (void)setRightNavItemWithTitle:(NSString *)title selector:(SEL)sel
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    //    [btn setTitleShadowColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.4f] forState:UIControlStateNormal];
    //    btn.titleLabel.shadowOffset = CGSizeMake(0, -1);
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    //    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
    [btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.bounds = CGRectMake(0, 0, 45, 44);
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)setLeftNavItemWithTitle:(NSString *)title selector:(SEL)sel
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.bounds = CGRectMake(0, 0, 50, 44);
    
    UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 26, 26)];
    backImg.image = [UIImage imageNamed:@"backBtn"];
    backImg.contentMode = UIViewContentModeCenter;
    [btn addSubview:backImg];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)setRightNavItemCustomView:(UIView *)view
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)setRightNavItem:(UIImage *)image selector:(SEL)sel
{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(51, 0, 40, 43)];
    btn.exclusiveTouch = YES;
    [btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0,0, 0, -10)];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)setLeftNavItem:(UIImage *)image selector:(SEL)sel
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-1, -30, 0, 0)];
    [btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.bounds = CGRectMake(0, 0, 60, 44);
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = item;
    
    // 调整 leftBarButtonItem 在 iOS7 下面的位置
    if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0)){
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = -16;
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, item];
    }else
        self.navigationItem.leftBarButtonItem = item;
}

- (void)addLeftNavItemWithPopSelector
{
    [self setLeftNavItem:[UIImage imageNamed:@"backImg"] selector:@selector(pop)];
}

-(void) pop
{
    [self.navigationController popViewControllerAnimated:NO];
    [self.navigationController dismissViewControllerAnimated:NO completion:^{
        ;
    }];
}

//加载自定义的view
-(void)loadView
{
    [super loadView];
//    self.baseView = [[BaseViewController alloc] init];
//    _baseView.backgroundColor = [UIColor colorWithRed:(CGFloat)216/255 green:(CGFloat)218/255 blue:(CGFloat)232/255 alpha:1];
//    //    [self.view addSubview: _baseView];
//    self.view = _baseView ;
}


#pragma mark --
#pragma mark 导航条字体
- (void)setTitle:(NSString *)title
{
    UILabel *lab = (UILabel *) self.navigationItem.titleView;
    
    CGFloat textWidth = [GXUtilities getWidth:title font:kHelveticaFont(18)] + 26;
    if (lab) {
        lab.text = title;
    } else {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
        titleLabel.font = kHelveticaFont(19);
        titleLabel.textColor = [UIColor colorWithHexString:@"#fafafa"];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.frame = CGRectMake(0, 0, MAX(textWidth, 120), 30);
        titleLabel.text = title;
        self.navigationItem.titleView = titleLabel;
    }
}

#pragma callLogin
- (void)callLoginVC:(NSNotification *) notification
{
    UIViewController * appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController * topV = appRootVC.presentedViewController;

    if ([topV isKindOfClass:[MainNavigationViewController class]]) {
        return;
    }
    
    LoginOrRegisterViewController *loginOrRegisterVC = [[LoginOrRegisterViewController alloc] init];
    MainNavigationViewController *nav = [[MainNavigationViewController alloc] initWithRootViewController:loginOrRegisterVC];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
