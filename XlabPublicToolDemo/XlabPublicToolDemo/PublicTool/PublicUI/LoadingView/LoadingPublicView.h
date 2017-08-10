//
//  LoadingPublicView.h
//  AW600NewUI
//
//  Created by DONGWANG on 2017/2/21.
//  Copyright © 2017年 com.Fenda.Fly. All rights reserved.
//
/*!
@adstract 
@author
@version
*/

#import <Foundation/Foundation.h>
#import "CommonMacro.h"

@interface LoadingPublicView : NSObject

SINGLETON
/**
 增加一个菊花加载框
 
 @param view 对应的View
 */
- (void)startLoadingInView:(UIView *)view;

/**
 停止加载
 */
- (void)stopLoading;


/**
 增加一个带有文字描述的加载框
 
 @param view 加载的对应的View
 @param message 对应的Message
 */
- (void)startLoadingInView:(UIView *)view withmessage:(NSString *)message;


/*********************************************************************
 函数名称 : showHWWaitingView
 函数描述 : 专门为华为登录注册设定蒙版全部遮住，避免许多网络回调问题
 参数 :
 返回值 : N/A
 作者 : yan_hao
 *********************************************************************/

- (void)showHWWaitingView;

/*********************************************************************
 函数名称 : showHWWaitingView
 函数描述 : 专门为华为登录注册设定蒙版全部遮住，避免许多网络回调问题
 参数 :
 返回值 : N/A
 作者 : yan_hao
 *********************************************************************/
- (void)showHWWaitingViewInView:(UIView *)view;

/*********************************************************************
 函数名称 : removeHWWaitingView
 函数描述 : 专门为华为登录注册设定蒙版全部遮住，避免许多网络回调问题
 参数 :
 返回值 : N/A
 作者 : yan_hao
 *********************************************************************/
- (void)removeHWWaitingView;


@end
