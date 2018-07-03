//
//  EOCAnimator.m
//  微信浮窗公开课
//
//  Created by 八点钟学院 on 2018/5/30.
//  Copyright © 2018年 八点钟学院. All rights reserved.
//

#import "EOCAnimator.h"
#import "EOCAnimView.h"

@interface EOCAnimator () <CAAnimationDelegate>

@end

@implementation EOCAnimator

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    
    return 1.f;
    
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *containerView = [transitionContext containerView];
    
    if (_operation == UINavigationControllerOperationPush) {
    
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        [containerView addSubview:toView];
        
        ///截屏
        EOCAnimView *theView = [[EOCAnimView alloc] initWithFrame:toView.bounds];
        
        UIGraphicsBeginImageContext(toView.bounds.size);
        [toView.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        theView.imgView.image = image;
        
        toView.hidden = YES;
        
        UIGraphicsEndImageContext();
        
        [containerView addSubview:theView];
        
        [theView startAnimationForView:toView fromRect:CGRectMake(_curPoint.x, _curPoint.y, 60.f, 60.f) toRect:toView.frame];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [transitionContext completeTransition:YES];
            
        });
        
        
    } else if (_operation == UINavigationControllerOperationPop) {

        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        [containerView addSubview:toView];
        
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        [containerView bringSubviewToFront:fromView];
        
        UIView *floatingBtn = [UIApplication sharedApplication].keyWindow.subviews.lastObject;
        
        if (_isInteractive) {  /// 可交互式动画
            
            [UIView animateWithDuration:0.3f animations:^{
                
                fromView.frame = CGRectOffset(fromView.frame, [UIScreen mainScreen].bounds.size.width, 0.f);
                
            } completion:^(BOOL finished) {
                
                [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
                
                if (!transitionContext.transitionWasCancelled) {
                    
                    floatingBtn.alpha = 1.f;
                    
                }
                
            }];
            
        } else {    /// 非可交互式动画
            
            ///截屏
            EOCAnimView *theView = [[EOCAnimView alloc] initWithFrame:fromView.bounds];
            UIGraphicsBeginImageContext(fromView.bounds.size);
            [fromView.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            theView.imgView.image = image;
            UIGraphicsEndImageContext();
            
            CGRect fromRect = fromView.frame;
            fromView.frame = CGRectZero;
            
            [containerView addSubview:theView];
            
            
            [theView startAnimationForView:theView fromRect:fromRect toRect:CGRectMake(_curPoint.x, _curPoint.y, 60.f, 60.f)];
        
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
            floatingBtn.alpha = 1.f;
        }

    }
    
}


@end
