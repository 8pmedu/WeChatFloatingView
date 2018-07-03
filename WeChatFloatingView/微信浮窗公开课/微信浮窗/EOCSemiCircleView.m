//
//  EOCSemiCircleView.m
//  微信浮窗公开课
//
//  Created by 八点钟学院 on 2018/5/30.
//  Copyright © 2018年 八点钟学院. All rights reserved.
//

#import "EOCSemiCircleView.h"

@interface EOCSemiCircleView ()

@property(nonatomic, strong) CAShapeLayer *semiLayer;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *textLabel;

@end

@implementation EOCSemiCircleView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    [self.layer addSublayer:self.semiLayer];
    [self.layer addSublayer:self.imageView.layer];
    [self.layer addSublayer:self.textLabel.layer];
    
    return self;
    
}

- (CAShapeLayer *)semiLayer {
    
    if (!_semiLayer) {
      
        _semiLayer = [CAShapeLayer layer];
        
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width, self.frame.size.height) radius:self.frame.size.width startAngle:-M_PI_2 endAngle:-M_PI clockwise:NO];
        [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
        [path closePath];
        
        _semiLayer.path = path.CGPath;
        _semiLayer.fillColor = [UIColor colorWithRed:206/255.0 green:85/255.0 blue:85/255.0 alpha:1].CGColor;
        
    }
    
    return _semiLayer;
}

- (UIImageView *)imageView {
    
    if (!_imageView) {
        
        CGFloat wh = 50;
        
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CornerIcon"]];
        _imageView.bounds = CGRectMake(0.f, 0.f, wh, wh);
        _imageView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        
    }
    
    return _imageView;
    
}

- (UILabel *)textLabel {
    
    if (!_textLabel) {
        
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(_imageView.frame.origin.x, CGRectGetMaxY(_imageView.frame), _imageView.frame.size.width, 20)];
        _textLabel.font = [UIFont systemFontOfSize:12];
        _textLabel.text = @"取消浮窗";
        _textLabel.textColor = [UIColor colorWithRed:234.f/255.0 green:160.f/255.0 blue:160.f/255.0 alpha:1];
        
    }
    return _textLabel;
    
}


@end
