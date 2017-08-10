//
//  LoadingPublicView.m
//  AW600NewUI
//
//  Created by DONGWANG on 2017/2/21.
//  Copyright © 2017年 com.Fenda.Fly. All rights reserved.
//

#import "LoadingPublicView.h"
#import "MBProgressHUD.h"
#import "CommonMacro.h"
@interface LoadingPublicView()
{
    MBProgressHUD *_loadingView;
    NSUInteger _loadingCount;

    UIView *m_hwwaitingView;
    UIActivityIndicatorView *m_hwactivity;
    
    
    
}

@end


@implementation LoadingPublicView
SINGLETON_SYNTHE

#pragma mark Loading

/**
 增加一个菊花加载框

 @param view 对应的View
 */
- (void)startLoadingInView:(UIView *)view
{
    dispatch_async(dispatch_get_main_queue(), ^{
        _loadingCount = 1;
        
        if (_loadingCount == 1) {
            if (_loadingView) {
                [_loadingView removeFromSuperview];
            }
            _loadingView = [[MBProgressHUD alloc] initWithView:view];
            _loadingView.labelText = NSLocalizedString(@"settings_policy_toast", nil);
            [_loadingView show:YES];
        }
        [view addSubview:_loadingView];
    });
   
}

/**
 停止加载
 */
- (void)stopLoading
{
    dispatch_async(dispatch_get_main_queue(), ^{
        _loadingCount--;
        
        // 当没有请求web的时候才移除loading
        if (_loadingCount == 0) {
            [_loadingView hide:YES];
            [_loadingView removeFromSuperview];
            _loadingView = nil;
            
            // 网络加载标志停止转动
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }

    });
}


/**
 增加一个带有文字描述的加载框

 @param view 加载的对应的View
 @param message 对应的Message
 */
- (void)startLoadingInView:(UIView *)view withmessage:(NSString *)message
{
    dispatch_async(dispatch_get_main_queue(), ^{
        _loadingCount = 1;
        
        if (_loadingCount == 1) {
            if (_loadingView) {
                [_loadingView removeFromSuperview];
            }
            _loadingView = [[MBProgressHUD alloc] initWithView:view];
            _loadingView.labelText = message;
            [_loadingView show:YES];
        }
        [view addSubview:_loadingView];
    });
   
}


/*********************************************************************
 函数名称 : showHWWaitingView
 函数描述 : 专门为华为登录注册设定蒙版全部遮住，避免许多网络回调问题
 参数 :
 返回值 : N/A
 作者 : yan_hao
 *********************************************************************/

- (void)showHWWaitingView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!m_hwwaitingView)
        {
            m_hwwaitingView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            m_hwwaitingView.backgroundColor = [UIColor blackColor];
            m_hwwaitingView.alpha =0.2;
            
            m_hwactivity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            m_hwactivity.frame=CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, 0, 0);
            
            [m_hwactivity startAnimating];
            [m_hwwaitingView addSubview:m_hwactivity];
            
        }

    });
    
    
    
    //[[AppDelegate getAPPDelegate].window addSubview:m_hwwaitingView];
    
}
/*********************************************************************
 函数名称 : showHWWaitingView
 函数描述 : 专门为华为登录注册设定蒙版全部遮住，避免许多网络回调问题
 参数 :
 返回值 : N/A
 作者 : yan_hao
 *********************************************************************/
- (void)showHWWaitingViewInView:(UIView *)view
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!m_hwwaitingView)
        {
            m_hwwaitingView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            m_hwwaitingView.backgroundColor = [UIColor blackColor];
            m_hwwaitingView.alpha =0.2;
            
            m_hwactivity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            m_hwactivity.frame=CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, 0, 0);
            
            [m_hwactivity startAnimating];
            [m_hwwaitingView addSubview:m_hwactivity];
            
        }
        
        [view addSubview:m_hwwaitingView];
    });
}

/*********************************************************************
 函数名称 : removeHWWaitingView
 函数描述 : 专门为华为登录注册设定蒙版全部遮住，避免许多网络回调问题
 参数 :
 返回值 : N/A
 作者 : yan_hao
 *********************************************************************/
- (void)removeHWWaitingView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (m_hwwaitingView.superview)
        {
            [m_hwwaitingView removeFromSuperview];
            [m_hwactivity stopAnimating];
            m_hwactivity =nil;
            m_hwwaitingView = nil;
        }

    });
}


@end
