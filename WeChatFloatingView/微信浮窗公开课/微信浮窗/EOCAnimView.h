//
//  EOCAnimView.h
//  微信浮窗公开课
//
//  Created by 八点钟学院 on 2018/5/31.
//  Copyright © 2018年 八点钟学院. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EOCAnimView : UIView

@property(nonatomic, strong)UIImageView *imgView;
@property(nonatomic, strong)CAShapeLayer *shapeLayer;

- (void)startAnimationForView:(UIView *)view fromRect:(CGRect)fromRect toRect:(CGRect)toRect;

@end
