//
//  EOCInteractiveTransition.h
//
//  Created by 八点钟学院 on 2018/6/9.
//  Copyright © 2018年 八点钟学院. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EOCInteractiveTransition : UIPercentDrivenInteractiveTransition

@property(nonatomic, assign)BOOL isInteractive;
@property(nonatomic, assign)CGPoint curPoint;

- (void)transitionToViewController:(UIViewController *)toViewController;

@end
