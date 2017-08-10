//
//  CustomAlertView.h
//  FD018
//
//  Created by Star on 16/8/3.
//  Copyright © 2016年 DONGWANG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomAlertView;
@protocol CustomAlertViewDelegate <NSObject>

@optional

- (void)alertView:(CustomAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface CustomAlertView : UIView

@property (nonatomic,strong)id<CustomAlertViewDelegate> delegate;

- (instancetype)initWithframe:(CGRect)frame Title:(NSString *)titleStr titleLine:(BOOL)isHide message:(NSString *)message subView:(UIView *)subView cancelBtnTitle:(NSString *)cancelTitle sureBtnTitle:(NSString *)sureTitle;
- (void)show;
@end
