
//
//  Created by zhuochunsheng on 16/6/30.
//  Copyright © 2016年 fenda. All rights reserved.
//

#import "XZLog.h"
#import <UIKit/UIKit.h>

//log color
#define XCODE_COLORS_ESCAPE_MAC @"\033["
#define XCODE_COLORS_ESCAPE_IOS @"\xC2\xA0["

#if 0//TARGET_OS_IPHONE
#define XCODE_COLORS_ESCAPE  XCODE_COLORS_ESCAPE_IOS
#else
#define XCODE_COLORS_ESCAPE  XCODE_COLORS_ESCAPE_MAC
#endif

#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"
static NSMutableDictionary* colorDic = nil;
static NSMutableDictionary* bgColorDic = nil;

// 文件夹string
static NSString *logFilePath = nil;
static NSString *logDic      = nil;
static NSString *crashDic    = nil;

// 设置默认保留文件天数为5天
static NSInteger numberOfDaysToDelete = 5;

// logQueue
static dispatch_once_t logQueueCreatOnce;
static dispatch_queue_t logOperationQueue;

//默认颜色
static NSString *logColor = nil;




NSString *applicationDocumentsDirectory() {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

void UncaughtExceptionHandler(NSException *exception) {
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    
    
    //    NSString *url = [NSString stringWithFormat:@"=============异常崩溃报告=============\nname:\n%@\nreason:\n%@\ncallStackSymbols:\n%@",
    //                     name,reason,[arr componentsJoinedByString:@"\n"]];
    
    NSDate *senddate=[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *locationString=[dateFormatter stringFromDate:senddate];
    
    
    
    NSString *exceptionUrl = [NSString stringWithFormat:@"%@--%@",locationString,[NSString stringWithFormat:@"name:%@  reason:%@  callStackSymbols:%@--%@--%@\n\n",name,reason,arr,exception.userInfo,exception.callStackReturnAddresses]];
    
    NSString *path = [applicationDocumentsDirectory() stringByAppendingPathComponent:@"Exception.txt"];
    [exceptionUrl writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    
    
    
    //除了可以选择写到应用下的某个文件，通过后续处理将信息发送到服务器等
    //还可以选择调用发送邮件的的程序，发送信息到指定的邮件地址
    //或者调用某个处理程序来处理这个信息
}



@implementation XZLog


#pragma mark --
#pragma mark -- public methods

+(void)initLog{
    [self _initFile];
    logColor = FDColor(0, 0, 0);
    dispatch_once(&logQueueCreatOnce, ^{
        logOperationQueue =  dispatch_queue_create("com.xzlog.app.operationqueue", DISPATCH_QUEUE_SERIAL);
        
    });
}



-(NSString *)applicationDocumentsDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}




/**
 *  崩溃日志
 * by nelsen 2016.09.13
 */
+ (void)setLogCrash
{
    NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);
}

+ (NSUncaughtExceptionHandler*)getHandler
{
    return NSGetUncaughtExceptionHandler();
}


+ (void)logCrash:(NSException *)exception{
    if (!exception) return;
    
#ifdef DEBUG
    NSLog(@"CRASH: %@",exception);
    NSLog(@"Stack Trace: %@",[exception callStackSymbols]);
#endif
    if (!crashDic) {
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *crashDirectory = [documentsDirectory stringByAppendingString:@"/log/"];
        crashDic = crashDirectory;
    }
    
    NSString *fileName = [NSString stringWithFormat:@"CRASH_%@.log",[self _getCurrentTime]];
    NSString *filePath = [crashDic stringByAppendingString:fileName];
    NSString *content = [[NSString stringWithFormat:@"CRASH: %@\n", exception] stringByAppendingString:[NSString stringWithFormat:@"Stack Trace: %@\n", [exception callStackSymbols]]];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *phoneLanguage = [languages objectAtIndex:0];
    
    content = [content stringByAppendingString:[NSString stringWithFormat:@"iOS Version:%@ Language:%@", [[UIDevice currentDevice] systemVersion],phoneLanguage]];
    NSError *error = nil;
    [content writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        NSLog(@"error is %@",error);
    }
}

/**
 *  设置文件夹保存几天的数据
 *
 *  @param number 多少天
 */
+(void)setNumberOfDaysToDelete:(NSInteger)number{
    numberOfDaysToDelete = number;
}

+(void)_initFile
{
    if (!logFilePath)
    {
        // 大文件的命名，例如2016-06-24
        NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
        NSDate *date1 = [NSDate date];
        NSString *dateString1 = [dateFormatter1 stringFromDate:date1];
        
        // documentDirectory目录string
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *logDirectory = [documentsDirectory stringByAppendingFormat:@"/log/%@/",dateString1];
        NSString *crashDirectory = [documentsDirectory stringByAppendingFormat:@"/log/%@/",dateString1];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:logDirectory]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:logDirectory
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:nil];
        }
        if (![[NSFileManager defaultManager] fileExistsAtPath:crashDirectory]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:crashDirectory
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:nil];
        }
        
        // 弄log文件路径里面的数组
        NSError *error = nil;
        NSMutableArray *fileArrays = [NSMutableArray array];
        fileArrays = [NSMutableArray arrayWithArray:[[NSFileManager defaultManager] contentsOfDirectoryAtPath:[documentsDirectory stringByAppendingString:@"/log/"] error:&error]];
        
        // 移除根目录
        [fileArrays removeObject:@".DS_Store"];
        NSString *minStr = [fileArrays objectAtIndex:0];
        
        // 移除最小那天的文件夹
        for (NSString *string in fileArrays) {
            if([string compare:minStr]<0)
                minStr = string;
        }
        if (fileArrays.count > numberOfDaysToDelete) {
            [[NSFileManager defaultManager] removeItemAtPath:[documentsDirectory stringByAppendingFormat:@"/log/%@",minStr] error:&error];
        }
        
        logDic = logDirectory;
        crashDic = crashDirectory;
        
        // 小文件的命名
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
        NSString *fileNamePrefix = [dateFormatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"XZ_log_%@.logtraces.txt", fileNamePrefix];
        NSString *filePath = [logDirectory stringByAppendingPathComponent:fileName];
        logFilePath = filePath;
#if DEBUG
        NSLog(@"【XZ】LogPath: %@", logFilePath);
#endif
        // 文件如果不存在就创建
        if(![[NSFileManager defaultManager] fileExistsAtPath:filePath])
        {
            [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
        }
    }
    
}


/**
 自定义写入数据，数据的格式可以自行定义

 @param customString 自定义的数据格式
 */
+ (void)logFromCustomStr:(NSString *)customString
{
    
    
    NSString *contentN = [customString stringByAppendingString:@"\n"];
    NSString *content = [NSString stringWithFormat:@"%@", contentN];
    // 使用句柄写入文件
    NSFileHandle *file = [NSFileHandle fileHandleForUpdatingAtPath:logFilePath];
    // 把句柄移到文件最后
    [file seekToEndOfFile];
    [file writeData:[content dataUsingEncoding:NSUTF8StringEncoding]];
    [file closeFile];
    
}


/**
 *  输入一个名称string和简单描述string、详细描述string
 *
 *  @param nameString      打印者的名称string
 *  @param simpleDescriptionString 简单描述string
 *  @param detailDescriptionString 详细描述string
 *  by xiaoZhuo   2016/06/29
 */
+ (void)logFromWhom:(NSString *)nameString andSimpleLogDescription:(NSString *)simpleDescriptionString andDetailLogDescription:(NSString *)detailDescriptionString andFileString:(NSString *)fileString
{
    NSString *contentStr = [[NSString alloc] initWithFormat:@"%@ %@ %@：%@",nameString,fileString,simpleDescriptionString,detailDescriptionString];
    
    NSLog(@"\033" @"fg%@" @"%@" XCODE_COLORS_RESET,logColor,contentStr);
    [[self class] writeDataToFileByString:contentStr];
}




/**
 输入一个名称string和简单描述string、详细描述string、模块名称

 @param nameString              打印者的名称string
 @param simpleDescriptionString 简单描述string
 @param detailDescriptionString 详细描述string
 @param logModule               打印的模块名称,则打印的txt文件以该模块名称命名
 */
+ (void)logFromWhom:(NSString *)nameString andSimpleLogDescription:(NSString *)simpleDescriptionString andDetailLogDescription:(NSString *)detailDescriptionString andFileString:(NSString *)fileString logModule:(NSString *)logModule
{
    
    NSString *filePath = [logDic stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.txt",logModule]];
    // 文件如果不存在就创建
    if(![[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    }
    logFilePath = filePath;
    
    NSString *contentStr = [[NSString alloc] initWithFormat:@"%@ %@ %@：%@",nameString,fileString,simpleDescriptionString,detailDescriptionString];
    
    NSLog(@"\033" @"fg%@" @"%@" XCODE_COLORS_RESET,logColor,contentStr);
    [[self class] writeDataToFileByString:contentStr];
}


/**
 *  输入一个名称string和简单描述string、详细描述string、字体颜色string
 *
 *  @param nameString      打印者的名称string
 *  @param simpleDescriptionString 简单描述string
 *  @param detailDescriptionString 详细描述string
 *  @param foreGroundColorString   字体颜色string
 *  by xiaoZhuo   2016/06/29
 */
+ (void)logFromWhom:(NSString *)nameString andSimpleLogDescription:(NSString *)simpleDescriptionString andDetailLogDescription:(NSString *)detailDescriptionString andFileString:(NSString *)fileString andColorString:(NSString *)foreGroundColorString
{
    NSString *contentStr = [[NSString alloc] initWithFormat:@"%@ %@ %@：%@",nameString,fileString,simpleDescriptionString,detailDescriptionString];
    NSLog(@"\033[" @"fg%@;" @"%@" XCODE_COLORS_RESET,foreGroundColorString,contentStr);
    
    [[self class] writeDataToFileByString:contentStr];
}


+ (void)logFromWhom:(NSString *)nameString andSimpleLogDescription:(NSString *)simpleDescriptionString andDetailLogDescription:(NSString *)detailDescriptionString andColorString:(NSString *)foreGroundColorString
{
    NSString *contentStr = [[NSString alloc] initWithFormat:@"%@ %@：%@",nameString,simpleDescriptionString,detailDescriptionString];
    NSLog(@"\033[" @"fg%@;" @"%@" XCODE_COLORS_RESET,foreGroundColorString,contentStr);
    
    [[self class] writeDataToFileByString:contentStr];
    
}
/**
 *  将打印的字符串string转化为data数据写入文件
 *
 *  @param string 打印的字符串string
 */
+ (void)writeDataToFileByString:(NSString *)string
{
    NSString *contentN = [string stringByAppendingString:@"\n"];
    NSString *content = [NSString stringWithFormat:@"%@ %@",[self _getCurrentTime], contentN];
    // 使用句柄写入文件
    NSFileHandle *file = [NSFileHandle fileHandleForUpdatingAtPath:logFilePath];
    // 把句柄移到文件最后
    [file seekToEndOfFile];
    [file writeData:[content dataUsingEncoding:NSUTF8StringEncoding]];
    [file closeFile];
}

/**
 *  获取当前时间，格式为yyyy-MM-dd hh:mm:ss
 *
 *  @return 当前时间string
 */
+(NSString *)_getCurrentTime
{
    NSDate *nowUTC = [NSDate date];
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [format stringFromDate:nowUTC];
    
    return dateString;
}

@end
