//
//  EOCNextViewController.m
//  微信浮窗公开课
//
//  Created by 八点钟学院 on 2018/5/30.
//  Copyright © 2018年 八点钟学院. All rights reserved.
//

#import "EOCNextViewController.h"
#import "EOCWeChatFloatingBtn.h"
#import "EOCAnimView.h"

@interface EOCNextViewController () <UIActionSheetDelegate>

@end

@implementation EOCNextViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    ///自定义导航栏
    [self customNavigationBar];
    
}

#pragma mark - 自定义导航栏
- (void)customNavigationBar {
    
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, [UIScreen mainScreen].bounds.size.width, 64.f)];
    navView.backgroundColor = [UIColor whiteColor];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(10.f, 27.f, 30.f, 30.f);
    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 30.f, 27.f, 30.f, 30.f);
    [moreBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.view.autoresizesSubviews = YES;
    navView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    
    navView.autoresizesSubviews = YES;
    
    moreBtn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    
    [navView addSubview:closeBtn];
    [navView addSubview:moreBtn];
    
    [self.view addSubview:navView];
    
}

#pragma mark - 按钮事件
- (void)closeAction {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    self.navigationController.delegate = nil;
    
}

-(void)moreAction {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"请选择"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
   
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"添加浮窗" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [EOCWeChatFloatingBtn show];
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
