//
//  EOCWeChatFloatingBtn.m
//  微信浮窗公开课
//
//  Created by 八点钟学院 on 2018/5/30.
//  Copyright © 2018年 八点钟学院. All rights reserved.
//

#import "EOCWeChatFloatingBtn.h"
#import "EOCNextViewController.h"
#import "EOCSemiCircleView.h"
#import "EOCAnimator.h"
#import "EOCInteractiveTransition.h"

@interface EOCWeChatFloatingBtn()<UINavigationControllerDelegate> {
    
    CGPoint lastPoint;
    CGPoint pointInSelf;
    EOCInteractiveTransition *interactiveTransition;

}

@end

@implementation EOCWeChatFloatingBtn
#define fixSpace 160.f

static EOCWeChatFloatingBtn *floatingBtn;
static EOCSemiCircleView *semiCircleView;

#pragma mark - 外部调用  展示浮窗
+ (void)show {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        floatingBtn = [[EOCWeChatFloatingBtn alloc] initWithFrame:CGRectMake(0.f, 200.f, 60.f, 60.f)];
        semiCircleView = [[EOCSemiCircleView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height, fixSpace, fixSpace)];
        
    });
    
    ///两者顺序不能颠倒
    if (!semiCircleView.superview) {
        
        [[UIApplication sharedApplication].keyWindow addSubview:semiCircleView];
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:semiCircleView];
        
    }
    
    if (!floatingBtn.superview) {
        
        floatingBtn.frame = CGRectMake(0.f, 200.f, 60.f, 60.f);
        [[UIApplication sharedApplication].keyWindow addSubview:floatingBtn];
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:floatingBtn];
        
    }
    
}

#pragma mark - init 方法
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        ///设置图片
        self.layer.contents = (__bridge id)[UIImage imageNamed:@"FloatBtn"].CGImage;
        
    }
    return self;
}

#pragma mark - touch 方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    lastPoint = [touch locationInView:self.superview];
    pointInSelf = [touch locationInView:self];

}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesMoved:touches withEvent:event];
    
    /// 动画展开semiCircleView
    CGRect rect = CGRectMake([UIScreen mainScreen].bounds.size.width - fixSpace, [UIScreen mainScreen].bounds.size.height - fixSpace, fixSpace, fixSpace);
    
    if (!CGRectEqualToRect(semiCircleView.frame, rect)) {
        
        [UIView animateWithDuration:0.3f animations:^{
            
            semiCircleView.frame = rect;
            
        }];
        
    }
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.superview];
    
    CGFloat theCenterX = point.x + (self.frame.size.width/2 - pointInSelf.x);
    CGFloat theCenterY = point.y + (self.frame.size.height/2 - pointInSelf.y);
    
    CGFloat x = MIN([UIScreen mainScreen].bounds.size.width - self.frame.size.width/2, MAX(theCenterX, self.frame.size.width/2));
    CGFloat y = MIN([UIScreen mainScreen].bounds.size.height - self.frame.size.height/2, MAX(theCenterY, self.frame.size.height/2));
    
    //移动的时候，该图标也跟随移动
    self.center = CGPointMake(x, y);
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesEnded:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint curPoint = [touch locationInView:self.superview];
    
    ///判断end和begin 两种状态之间是否有移动，如果没有移动，响应跳转事件
    if (CGPointEqualToPoint(curPoint, lastPoint)) {
        
        interactiveTransition = [EOCInteractiveTransition new];
        interactiveTransition.curPoint = self.frame.origin;
        
        UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        nav.delegate = self;
        EOCNextViewController *nextViewCtrl = [EOCNextViewController new];
        
        [interactiveTransition transitionToViewController:nextViewCtrl];
        
        [nav pushViewController:nextViewCtrl animated:YES];
        return;
        
    }
    
    ///收缩动画
    CGRect rect = CGRectMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height, fixSpace, fixSpace);
    
    if (!CGRectEqualToRect(semiCircleView.frame, rect)) {
        
        [UIView animateWithDuration:0.3f animations:^{
            
            semiCircleView.frame = rect;
            
            /// 两个圆心的距离 <= 四分之一圆的半径 - 圆形的半径  移除掉self
            CGFloat distance = sqrt(pow([UIScreen mainScreen].bounds.size.width - self.center.x, 2) + pow([UIScreen mainScreen].bounds.size.height - self.center.y, 2));
            
            if (distance <= fixSpace - 30.f) {
                
                [self removeFromSuperview];
                
            }
            
        }];
        
    }
    
    /// 离左右两边的距离
    CGFloat left = curPoint.x;
    CGFloat right = [UIScreen mainScreen].bounds.size.width - curPoint.x;
    
    if (left <= right) {   ///往左边靠
        
        [UIView animateWithDuration:0.2f animations:^{
           
            self.center = CGPointMake(15+self.frame.size.width/2, self.center.y);
            
        }];
        
    } else {   ///往右边靠
        
        [UIView animateWithDuration:0.2f animations:^{
            
            self.center = CGPointMake([UIScreen mainScreen].bounds.size.width - (10+self.frame.size.width/2), self.center.y);
            
        }];
        
    }
    
}


#pragma mark - UINavigationController delegate method
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush) {
        
        self.alpha = 0.f;
        
    } 
    
    EOCAnimator *animator = [EOCAnimator new];
    animator.curPoint = self.frame.origin;
    animator.operation = operation;
    animator.isInteractive = interactiveTransition.isInteractive;
    
    return animator;
    
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    
    return interactiveTransition.isInteractive?interactiveTransition:nil;
    
}

@end
