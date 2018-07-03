//
//  EOCAnimView.m
//  微信浮窗公开课
//
//  Created by 八点钟学院 on 2018/5/31.
//  Copyright © 2018年 八点钟学院. All rights reserved.
//

#import "EOCAnimView.h"

@interface EOCAnimView()<CAAnimationDelegate> {
    
    CGRect fromRect;
    CGRect toRect;
    UIView *toView;
    
}

@end

@implementation EOCAnimView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    _imgView = [[UIImageView alloc] initWithFrame:frame];
    [self addSubview:_imgView];
    
    self.backgroundColor = [UIColor clearColor];
    
    return self;
    
}

- (void)startAnimationForView:(UIView *)view fromRect:(CGRect)fromRect toRect:(CGRect)toRect {
    
    toView = view;
    
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:fromRect cornerRadius:30.f].CGPath;
    _shapeLayer.fillColor = [UIColor grayColor].CGColor;
    self.imgView.layer.mask = _shapeLayer;
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"path"];
    anim.toValue = (__bridge id)[UIBezierPath bezierPathWithRoundedRect:toRect cornerRadius:30.f].CGPath;
    anim.duration = 0.5f;
    anim.delegate = self;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    
    [self.shapeLayer addAnimation:anim forKey:@"revealAnimation"];
    
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
    
    toView.hidden = NO;
    [self removeFromSuperview];
    
}

@end
