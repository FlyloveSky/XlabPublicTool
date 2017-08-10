//
//  XlabTool.h
//  FD018
//
//  Created by DONGWANG on 16/7/18.
//  Copyright © 2016年 DONGWANG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CommonMacro.h"
#define SIMPLECHINESE           @"simpleChinese"//是简体中文

@interface XlabTool : NSObject



/**
 *  判断手机当前的网络是否可达
 *  2016/07/19 modify By Aney
 *  @return 返回Bool类型
 */
+(BOOL)isNetConnect;
/**
 *  判断当前网络的状态,0为不可达;1为GPRS;2为WIFI
 *  2016/07/18 modify By Aney
 *  @return 返回Bool类型
 */
+(int)isNetConnectType;
/**
 *  NSUserDefault持久化数据
 *  2016/07/18 modify By Aney
 *  @param value      Value
 *  @param defaultKey KEY
 */
+(void)setStringValue:(id)value defaultKey:(NSString *)defaultKey;
/**
 *  获取持久化的数据
 *  2016/07/18 modify By Aney
 *  @param defaultKey KEY
 *
 *  @return 获取持久化的数据
 */
+(id)getStringValueFromKey:(NSString *)defaultKey;
/**
 *  持久化BOOL状态值
 *  2016/07/18 modify By Aney
 *  @param boolState BOOL类型
 *  @param defaultKey KEY
 */
+(void)setBoolState:(BOOL)boolState defaultKey:(NSString *)defaultKey;
/**
 *  获取持久化的数据
 *  2016/07/18 modify By Aney
 *  @param defaultKey KEY
 *
 *  @return 获取持久化的数据
 */

+(BOOL)getBoolState:(NSString *)defaultKey;
/**
 *  移除KEY对应的持久化数据
 *  2016/07/18 modify By Aney
 *  @param defaultString KEY
 */
+(void)removeUserDefaultString:(NSString *)defaultString;
/**
 *  根据字典的KEY按首字母排序并拼接成字符串
 *  2016/07/18 modify By Aney
 *  @param dic 需要排序的字典
 *
 *  @return 返回的字符串
 */
+ (NSString *)getStrFromDic:(NSDictionary *)dic;
/**
 *  判断当前机型是否为Retina 屏
 *  2016/07/18 modify By Aney
 *  @return 返回对应的BOOL值
 */
+(BOOL)isRetinaDisplay;
/**
 *  判断当否是中文.包括繁体
 *  2016/07/18 modify By Aney
 *  @return 返回BOOL类型
 */
+(BOOL)isChinese;
/**
 *  获取当前的语言环境
 *  2016/07/18 modify By Aney
 *  @return 返回对应的语言环境
 */

+(NSString*)currentLanguage;
/**
 *  16进制数据转换成NSdata
 *  2016/07/18 modify By Aney
 *  @param command 16进制数据
 *
 *  @return 返回的NSdata
 */
+(NSData*)hexStringToNSData:(NSString *)command;
/**
 *  16进制数据转换成NSdata
 *  2016/07/18 modify By Aney
 *  @param aString 16进制数据
 *
 *  @return 返回的NSdata
 */
+(NSData*) bytesFromHexString:(NSString *)aString;
/**
 *  得到自定义大小的数据
 *  2016/07/18 modify By Aney
 *  @param valueUnitArray 数据对应的Value
 *  @param attriArry      对应需要自定义的格式
 *
 *  @return 返回格式化的数据
 */
+ (NSAttributedString *)getAttributeStr:(NSArray *)valueUnitArray withAttributArr:(NSArray *)attriArry;
/**
 *  数组元素使用"，"号拼接，转换成字符串
 *  2016/07/18 modify By Aney
 *  @param array   需要拼接的数组
 *  @param typeStr 特定的字符
 *
 *  @return 拼接好的字符串
 */
+ (NSMutableString *)getArrayToString:(NSMutableArray *)array WithType:(NSString *)typeStr;
/**
 *  字符串拆分数组
 *  2016/07/18 modify By Aney
 *  @param string  需要拆分的字符串
 *  @param typeStr 特定的字符
 *
 *  @return 返回拆分好的数组
 */
+ (NSMutableArray *)getArrayFromString:(NSString *)string WithType:(NSString *)typeStr;
/**
 *  int类型的数据转换成NSData
 *  2016/07/18 modify By Aney
 *  @param operatetype 需要转换的int类型
 *
 *  @return 返回转换好的NSData类型
 */
+(NSData *)intTochar:(int)operatetype;
/**
 *  计算NSData对应的CRC值（128）
 *  2016/07/18 modify By Aney
 *  @param data  需要计算的NSData数据
 *  @param lenth 数据长度
 *
 *  @return 返回计算好的CRC值
 */
+ (uint16_t)creatCRCWith:(NSData *)data withLenth:(NSInteger)lenth;
/**
 *  2016/07/18 modify By Aney
 *  获取当前手机系统语言,主要用于区分中文以及非中文
 */
+(void)saveCurrentLanguage;
/**
 *  生成特定长度的随机数
 *  2016/07/18 modify By Aney
 *  @param randomLength 制定的长度
 *
 *  @return 返回制定长度的字符串
 */
+ (NSString*) randomWithLengh:(int)randomLength;
/**
 *  由于IOS数据存储为小端存储，故在于其他硬件设备交互时需要进行数据移位
 *  2016/07/18 modify By Aney
 *  @param number 需要因为的两个字节数据
 *
 *  @return 移位后的数据
 */
+ (UInt16)NSDataToUInt16:(UInt16)number;
/**
 *  由于IOS数据存储为小端存储，故在于其他硬件设备交互时需要进行数据移位
 *  2016/07/18 modify By Aney
 *  @param number 需要因为的四个字节数据
 *
 *  @return 移位后的数据
 */
+ (UInt32) NSDataToUInt32:(UInt32)number;
/**
 *  把字典数据转换成对应的Model数据
 *  2016/07/18 modify By Aney
 *  @param dicArray       存放字典对应的数组
 *  @param modelClassName 需要转换的Model类名
 *
 *  @return 返回建模好的数据Model
 */
+ (NSArray *)convertDicArrayToModelArray:(NSArray *)dicArray withModelClass:(NSString*)modelClassName;
/**
 *  返回制定范围的随机数
 *  2016/07/18 modify By Aney
 *  @param fromNumber 其实范围
 *  @param toNumber   结束范围
 *
 *  @return 返回到的随机数
 */
+ (int)getRandomNumber:(int)fromNumber to:(int)toNumber;
/**
 *  检测系统通知开关是否打开
 *  2016/07/18 modify By Aney
 *  @return 返回开关状态
 */
+ (BOOL)isAllowedNotification;
/**
 *  请求itunes 获取当前APP的信息，APP升级需要
 *  2016/07/18 modify By Aney
 *  @param delegate alertView框对应的delegate
 *  @param alertTag alertView框对应的Tag值
 *  @param appId    对应提交到APP store对应的APP ID
 *
 *  @return 返回更新APP对应的URL
 */
+ (NSString *)checkAppUpdateFromAppStoreDelegate:(id /*<UIAlertViewDelegate>*/)delegate withAlertTag:(int)alertTag WithAppId:(NSString *)appId;
/**
 *  获取系统所有的国家
 *  2016/07/18 modify By Aney
 *  @return 返回获取到的国家
 */
+(NSMutableArray *)getSystermAllCountry;
/**
 *  获取国家对应的代号
 *  2016/07/18 modify By Aney
 *  @return 返回获取到的代号
 */
+ (NSDictionary *)getSystermCountryCode;
/**
 *  数组中的数据进行排序处理。
 *  2016/07/18 modify By Aney
 *  @param array 需要升序排列的数组
 *
 *  @return 返回升序排列好的数组
 */
+(NSArray *)rankArray:(NSArray *)array;

/**
 *  验证手机号格式是否正确
 *  2016/07/28 modify By Alice
 *  @param str 输入的电话号
 *
 *  @return 合法则返回YES
 */
+ (BOOL) isValidPhoneNumber:(NSString *)str;
/**
 *  验证密码格式是否正确
 *  2016/07/28 modify By Alice
 *  @param str 输入的密码
 *
 *  @return 合法则返回YES
 */
+ (BOOL)isvalidPassword:(NSString *)str;

/**
 *  获取用户登录的ID
 *
 *  @return 返回用户登录的ID
 */
+(NSString *)getUserID;


/**
 *  处理字符串 type为1表示把hourStr处理成X时X分，type为0处理成两个的,type为1处理单个。
 *
 *  @param SourceStr 需要处理de字符串
 *  @param unitArray 单位数组
 *  @param attriArry 参数信息
 *  @return 返回处理好的数据
 */
+ (NSAttributedString *)getModifyGoodFrom:(NSString *)SourceStr withUnit:(NSArray *)unitArray withAttributArr:(NSArray *)attriArry;


/**
 *  打开系统蓝牙设置
 */
+ (void)OpenSystemBleSetting;

/**
 *  字符串反转
 *
 *  @param str 需要反转的字符串
 *
 *  @return 反转后的字符串
 */
+ (NSString *)stringByReversed:(NSString *)str;

/**
 *  将NSData转成NSString
 *
 *  @param data data
 *
 *  @return NSString
 */
+ (NSString*)hexStringForData:(NSData*)data;


+ (NSString*)TimeformatFromSeconds:(NSInteger)seconds;

@end
