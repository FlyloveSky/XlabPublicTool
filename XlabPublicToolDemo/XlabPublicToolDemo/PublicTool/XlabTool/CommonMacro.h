//
//  CommonMacro.h
//  AW600
//
//  Created by DONGWANG on 15/9/12.
//  Copyright (c) 2015年 DONGWANG. All rights reserved.
//



#ifndef CommonMacro_h
#define CommonMacro_h



/**
 *  宏定义单例类.m
 */
#define SINGLETON_SYNTHE \
+ (id)sharedInstance\
{\
static id shared = nil;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken,\
^{\
shared = [[self alloc]init];\
});\
return shared;\
}

/**
 *  宏定义单例类.h
 */
#define SINGLETON + (id)sharedInstance;


//导航栏高度
#define NavigationBar_HEIGHT 64

//获取屏幕的宽度和高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//获取当前设备的屏幕尺寸
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)) : NO)
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6PlusBigMode ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen]currentMode].size) : NO)

#define IPAD_IPHONE4 (iPhone4|| !(iPhone6plus||iPhone5||iPhone6PlusBigMode||iPhone6))


//判断当前系统的版本号
#define iOS9 [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0
#define iOS8 [[[UIDevice currentDevice] systemVersion] floatValue] > 8.0
#define iOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0


#define IOS7  [[[UIDevice currentDevice] systemVersion] integerValue] >= 7.0 ? YES : NO
#define IOS8  [[[UIDevice currentDevice] systemVersion] integerValue] >= 8.0 ? YES : NO
#define IOS9  [[[UIDevice currentDevice] systemVersion] integerValue] >= 9.0 ? YES : NO
#define IOS10  [[[UIDevice currentDevice] systemVersion] integerValue] >= 10.0 ? YES : NO

//当前软件的版本(plist文件中)
#define appVersion [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey]
#define HELVETICANEUEBOLD_FONT(fontSize)		[UIFont fontWithName:@"HelveticaNeue-Bold" size:fontSize]	//加粗
#define HELVETICANEUE_FONT(fontSize)			[UIFont fontWithName:@"HelveticaNeue" size:fontSize]		//不加粗

//正则表达式

#define VALIDATE_EMAIL_REGEX @"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z0-9]{1,6})\\b"
#define VALIDATE_PHONE_REGEX @"^(13|14|15|18)\\d{9}$"
#define VALIDATE_CAPCHANUM_REGEX @"\\d{5}"
#define VALIDATE_PASSWORD_REGEX @"^[0-9a-zA-Z_]{8,16}$"

//本地化
#define CustomLocalizedString(Key)     NSLocalizedString(Key, nil)


#define NSLocalizedString(key, comment) \
[NSBundle.mainBundle localizedStringForKey:(key) value:@"" table:nil]
//推荐使用第二个，可以项目内语言切换
#define NSLocalizedStringFromTable(key, tbl, comment) \
[NSBundle.mainBundle localizedStringForKey:(key) value:@"" table:(tbl)]
#define NSLocalizedStringFromTableInBundle(key, tbl, bundle, comment) \
[bundle localizedStringForKey:(key) value:@"" table:(tbl)]
#define NSLocalizedStringWithDefaultValue(key, tbl, bundle, val, comment) \
[bundle localizedStringForKey:(key) value:(val) table:(tbl)]

/**
 控制alert弹出的次数,避免多次弹出
 */
#define ALERTINFO_POPBOX                 @"alertInfo_popBox"
#define NOTI_BODY                        @"noti_body" //通知提示内容
#define NOTI_NAME                        @"noti_name"//通知名称


//工具类
#import "XlabTool.h"

//共用颜色
#define RGB_COlOR(r,g,b,ap) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:ap]
#define BarColor RGB_COlOR(5,174,231,1)//bar的颜色

#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

#define COLOR_RGB(rgbValue,a) [UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 green:((float)(((rgbValue) & 0xFF00)>>8))/255.0 blue: ((float)((rgbValue) & 0xFF))/255.0 alpha:(a)]


//默认的userid,避免与用户使用重复
#define DefaultUserId    @"3892y89griub78t349vhv9756096-569"

//当前用户id
#define USERID           @"userId"

//本地化个人信息
#define USERDIC [NSString stringWithFormat:@"UserInfo%@",[XlabTool getUserID]]

//是否是第一次使用
#define FIRST_USE        @"first_use"








#endif /* CommonMacro_h */
