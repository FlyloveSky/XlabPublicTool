//
//  CustomAlertView.m
//  FD018
//
//  Created by Star on 16/8/3.
//  Copyright © 2016年 DONGWANG. All rights reserved.
//

#import "CustomAlertView.h"
#import "CommonMacro.h"

#define AlertTitleH 45
#define cancelBtnH 45
#define leftMove (iPhone4||iPhone5?-5:-4)


typedef enum {
    cancel_Tag,
    sure_Tag

}btn_tag;

@implementation CustomAlertView


- (instancetype)initWithframe:(CGRect)frame Title:(NSString *)titleStr titleLine:(BOOL)isHide message:(NSString *)message subView:(UIView *)subView cancelBtnTitle:(NSString *)cancelTitle sureBtnTitle:(NSString *)sureTitle
{
    self = [super initWithFrame:frame];
    if (self) {
        //蒙版bgView
        UIView *bgView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.tag = 123;
        bgView.alpha = 0.5;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:bgView];
        //Alert
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, AlertTitleH)];
        titleLab.text = titleStr;
        titleLab.font = [UIFont systemFontOfSize:19];
        titleLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLab];
        
        
        
            
       
        if (message && subView == nil) {
            
            UILabel *messageLab = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLab.frame), self.frame.size.width - 20, 0)];
            messageLab.text = message;
            messageLab.textAlignment = NSTextAlignmentCenter;
            messageLab.font = [UIFont systemFontOfSize:14];
            messageLab.numberOfLines = 0;
            [messageLab sizeToFit];
            //            messageLab.frame = CGRectMake(10, CGRectGetMaxY(titleLine.frame), self.frame.size.width - 20, messageLab.frame.size.height);
            [self addSubview:messageLab];
        }else if (message == nil && subView){
            subView.frame = CGRectMake(leftMove, CGRectGetMaxY(titleLab.frame) - 10, subView.frame.size.width, subView.frame.size.height);
            
            [self addSubview:subView];
        }else if (message && subView){
            subView.frame = CGRectMake(0, CGRectGetMaxY(titleLab.frame) - 10, subView.frame.size.width, subView.frame.size.height);
            [self addSubview:subView];
            UILabel *messageLab = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(subView.frame) , self.frame.size.width - 20, 0)];
            messageLab.text = message;
            messageLab.font = [UIFont systemFontOfSize:14];
            messageLab.numberOfLines = 0;
            [messageLab sizeToFit];
            //            messageLab.frame = CGRectMake(10, CGRectGetMaxY(titleLine.frame), self.frame.size.width - 20, messageLab.frame.size.height);
            [self addSubview:messageLab];
        }
        
        CALayer *titleLine = [[CALayer alloc] init];
        titleLine.frame = CGRectMake(0, CGRectGetMaxY(titleLab.frame), frame.size.width, 1.0);
        titleLine.backgroundColor = [UIColor grayColor].CGColor;
        titleLine.hidden = isHide;
        [self.layer addSublayer:titleLine];
        
        UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0 , frame.size.height - cancelBtnH, frame.size.width/2 , cancelBtnH)];
//        cancelBtn.backgroundColor = [UIColor yellowColor];
        [cancelBtn setTitle:cancelTitle forState:UIControlStateNormal];
        [cancelBtn setTitleColor:BarColor forState:UIControlStateNormal];
        cancelBtn.tag = cancel_Tag;
        [cancelBtn addTarget:self action:@selector(sureOrCancleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        
        UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - CGRectGetMaxX(cancelBtn.frame), cancelBtn.frame.origin.y, cancelBtn.frame.size.width, cancelBtnH)];
        [sureBtn setTitle:sureTitle forState:UIControlStateNormal];
        [sureBtn setTitleColor:BarColor forState:UIControlStateNormal];
        sureBtn.tag = sure_Tag;
        [sureBtn addTarget:self action:@selector(sureOrCancleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sureBtn];
        
        
        CALayer *btnHorizontalLine = [[CALayer alloc] init];
        btnHorizontalLine.frame = CGRectMake(0, CGRectGetMinY(cancelBtn.frame), frame.size.width, 1.0);
        btnHorizontalLine.backgroundColor = [UIColor lightGrayColor].CGColor;
        [self.layer addSublayer:btnHorizontalLine];
        
        
        CALayer *btnVerticalLine = [[CALayer alloc] init];
        btnVerticalLine.frame = CGRectMake(CGRectGetMaxX(cancelBtn.frame), CGRectGetMinY(cancelBtn.frame) + 5, 1.0, cancelBtn.frame.size.height - 10);
        btnVerticalLine.backgroundColor = [UIColor lightGrayColor].CGColor;
        [self.layer addSublayer:btnVerticalLine];
    }
    return self;
}

- (void)show
{
    
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    [win addSubview:self];
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.40;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [self.layer addAnimation:animation forKey:nil];
}

- (void)dismiss
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *bgView = [window viewWithTag:123];
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 0;
        bgView.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [bgView removeFromSuperview];
    }];

}

- (void)sureOrCancleBtnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        [self.delegate alertView:self clickedButtonAtIndex:btn.tag];
        [self dismiss];
    }
}
@end
