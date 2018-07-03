//
//  EOCAnimator.h
//  微信浮窗公开课
//
//  Created by 八点钟学院 on 2018/5/30.
//  Copyright © 2018年 八点钟学院. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface EOCAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property(nonatomic, assign)CGPoint curPoint;
@property(nonatomic, assign)UINavigationControllerOperation operation;
@property(nonatomic, assign)BOOL isInteractive;

@end
