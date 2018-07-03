//
//  EOCInteractiveTransition.m
//
//  Created by 八点钟学院 on 2018/6/9.
//  Copyright © 2018年 八点钟学院. All rights reserved.
//

#import "EOCInteractiveTransition.h"
#import "EOCAnimView.h"

@interface EOCInteractiveTransition () {
    
    UIViewController *presentedViewController;
    BOOL shouldComplete;
    CGFloat transitionX;
    
}

@end

@implementation EOCInteractiveTransition

- (void)transitionToViewController:(UIViewController *)toViewController {
    
    presentedViewController = toViewController;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [toViewController.view addGestureRecognizer:panGesture];
    
}

- (void)panAction:(UIPanGestureRecognizer *)gesture {
    
    UIView *floatingBtn = [UIApplication sharedApplication].keyWindow.subviews.lastObject;
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    switch (gesture.state) {
            
        case UIGestureRecognizerStateBegan:
            
            _isInteractive = YES;
            
            [nav popViewControllerAnimated:YES];
            
            break;
            
        case UIGestureRecognizerStateChanged: {
            
            //监听当前滑动的距离
            CGPoint transitionPoint = [gesture translationInView:presentedViewController.view];
            
            CGFloat ratio = transitionPoint.x/[UIScreen mainScreen].bounds.size.width;
            
            transitionX = transitionPoint.x;
            
            ///获得floatingBtn，改变它的alpha值
           
            floatingBtn.alpha = ratio;
            
            if (ratio >= 0.5) {
                
                shouldComplete = YES;
                
            } else {
                
                shouldComplete = NO;
                
            }
            
            [self updateInteractiveTransition:ratio];
            
        }
            
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            
            if (shouldComplete) {

                /// 添加动画
                ///截屏
                UIView *fromView = presentedViewController.view;
                
                EOCAnimView *theView = [[EOCAnimView alloc] initWithFrame:fromView.bounds];
                UIGraphicsBeginImageContext(fromView.bounds.size);
                [fromView.layer renderInContext:UIGraphicsGetCurrentContext()];
                UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
                theView.imgView.image = image;
                UIGraphicsEndImageContext();
                
                CGRect fromRect = fromView.frame;
                fromView.frame = CGRectZero;
                
                [fromView.superview addSubview:theView];
                
                [theView startAnimationForView:theView fromRect:CGRectMake(transitionX, 0.f, fromRect.size.width, fromRect.size.height) toRect:CGRectMake(_curPoint.x, _curPoint.y, 60.f, 60.f)];
                
                [self finishInteractiveTransition];
                nav.delegate = nil;  //这个需要设置，而且只能在这里设置，不能在外面设置

            } else {

                floatingBtn.alpha = 0.f;
                [self cancelInteractiveTransition];

            }
            
            _isInteractive = NO;
            
        }
            break;
        default:
            break;
    }
    
}


@end
