//
//  XlabTool.m
//  FD018
//
//  Created by DONGWANG on 16/7/18.
//  Copyright © 2016年 DONGWANG. All rights reserved.
//

#import "XlabTool.h"
#import "Reachability.h"
@implementation XlabTool


/**
 *  判断手机当前的网络是否可达
 *  2016/07/19 modify By Aney
 *  @return 返回Bool类型
 */
+(BOOL)isNetConnect
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    switch (networkStatus)
    {
        case NotReachable:
            return NO;
            break;
        default:
            break;
    }
    
    return YES;
}

/**
 *  判断当前网络的状态,0为不可达;1为GPRS;2为WIFI
 *  2016/07/18 modify By Aney
 *  @return 返回Bool类型
 */
+(int)isNetConnectType
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    return networkStatus;
    
}

/**
 *  NSUserDefault持久化数据
 *  2016/07/18 modify By Aney
 *  @param value      Value
 *  @param defaultKey KEY
 */
+(void)setStringValue:(id)value defaultKey:(NSString *)defaultKey
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:defaultKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
/**
 *  获取持久化的数据
 *  2016/07/18 modify By Aney
 *  @param defaultKey KEY
 *
 *  @return 获取持久化的数据
 */
+(id)getStringValueFromKey:(NSString *)defaultKey
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultKey];
}

/**
 *  持久化BOOL状态值
 *  2016/07/18 modify By Aney
 *  @param boolState BOOL类型
 *  @param defaultKey KEY
 */
+(void)setBoolState:(BOOL)boolState defaultKey:(NSString *)defaultKey
{
    [[NSUserDefaults standardUserDefaults] setBool:boolState forKey:defaultKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  获取持久化的数据
 *  2016/07/18 modify By Aney
 *  @param defaultKey KEY
 *
 *  @return 获取持久化的数据
 */

+(BOOL)getBoolState:(NSString *)defaultKey
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:defaultKey];
}

/**
 *  移除KEY对应的持久化数据
 *  2016/07/18 modify By Aney
 *  @param defaultString KEY
 */
+(void)removeUserDefaultString:(NSString *)defaultString
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:defaultString];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *  根据字典的KEY按首字母排序并拼接成字符串
 *  2016/07/18 modify By Aney
 *  @param dic 需要排序的字典
 *
 *  @return 返回的字符串
 */
+ (NSString *)getStrFromDic:(NSDictionary *)dic
{
    
    NSArray *kArrSort = [dic allKeys]; //这里是字母数组:,g,a,b.y,m……
    NSArray *resultkArrSort = [kArrSort sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSLog(@"按字母排序后%@",resultkArrSort);
    
    NSString* signStr = @"";
    for (int i = 0; i<resultkArrSort.count; i++)
    {
        signStr = [NSString stringWithFormat:@"%@%@%@",signStr,resultkArrSort[i],[dic objectForKey:resultkArrSort[i]]];
    }
    
    return signStr;
}

/**
 *  判断当前机型是否为Retina 屏
 *  2016/07/18 modify By Aney
 *  @return 返回对应的BOOL值
 */
+(BOOL)isRetinaDisplay
{
    int scale = 1.0;
    UIScreen *screen = [UIScreen mainScreen];
    if([screen respondsToSelector:@selector(scale)])
        scale = screen.scale;
    
    if(scale == 2.0f) return YES;
    else return NO;
}


/**
 *  判断当否是中文.包括繁体
 *  2016/07/18 modify By Aney
 *  @return 返回BOOL类型
 */
+(BOOL)isChinese
{
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage];
    if([lang compare:@"zh-Hans" options:NSCaseInsensitiveSearch]==NSOrderedSame || [lang compare:@"zh-Hant" options:NSCaseInsensitiveSearch]==NSOrderedSame)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

/**
 *  获取当前的语言环境
 *  2016/07/18 modify By Aney
 *  @return 返回对应的语言环境
 */

+(NSString*)currentLanguage
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLang = [languages objectAtIndex:0];
    return currentLang;
}


/**
 *  16进制数据转换成NSdata
 *  2016/07/18 modify By Aney
 *  @param command 16进制数据
 *
 *  @return 返回的NSdata
 */
+(NSData*)hexStringToNSData:(NSString *)command
{
    //NSString *command = @"72ff63cea198b3edba8f7e0c23acc345050187a0cde5a9872cbab091ab73e553";
    command = [command stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableData *commandToSend= [[NSMutableData alloc] init];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [command length]/2; i++) {
        byte_chars[0] = [command characterAtIndex:i*2];
        byte_chars[1] = [command characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [commandToSend appendBytes:&whole_byte length:1];
    }
    NSLog(@"%@", commandToSend);
    return commandToSend;
}

/**
 *  16进制数据转换成NSdata
 *  2016/07/18 modify By Aney
 *  @param aString 16进制数据
 *
 *  @return 返回的NSdata
 */
+(NSData*) bytesFromHexString:(NSString *)aString
{
    NSString *theString = [[aString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString:nil];
    
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= theString.length; idx+=2)
    {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [theString substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        if ([scanner scanHexInt:&intValue])
            [data appendBytes:&intValue length:1];
    }
    return data;
}


/**
 *  得到自定义大小的数据
 *  2016/07/18 modify By Aney
 *  @param valueUnitArray 数据对应的Value
 *  @param attriArry      对应需要自定义的格式
 *
 *  @return 返回格式化的数据
 */
+ (NSAttributedString *)getAttributeStr:(NSArray *)valueUnitArray withAttributArr:(NSArray *)attriArry
{
    if (valueUnitArray.count > 1)
    {
        NSMutableAttributedString *resultStr = [[NSMutableAttributedString alloc] initWithString:valueUnitArray[0] attributes:attriArry[0]];

        for (NSInteger i = 1; i < valueUnitArray.count; i ++)
        {
            [resultStr appendAttributedString:[[NSAttributedString alloc] initWithString:valueUnitArray[i] attributes:attriArry[i]]];
            
        }
        
        
        return resultStr;

    }
    
    
    
    
    
    return nil;
}

/**
 *  数组元素使用"，"号拼接，转换成字符串
 *  2016/07/18 modify By Aney
 *  @param array   需要拼接的数组
 *  @param typeStr 特定的字符
 *
 *  @return 拼接好的字符串
 */
+ (NSMutableString *)getArrayToString:(NSMutableArray *)array WithType:(NSString *)typeStr
{
    NSMutableString *str = [NSMutableString new];
    if ([array count]>0)
    {
        for (int i = 0; i<[array count]; i++)
        {
            [str appendFormat:@"%@%@",array[i],typeStr];
        }
        str = (NSMutableString *)[str substringWithRange:NSMakeRange(0, [str length]-1)];
    }
    
    return str;
}

/**
 *  字符串拆分数组
 *  2016/07/18 modify By Aney
 *  @param string  需要拆分的字符串
 *  @param typeStr 特定的字符
 *
 *  @return 返回拆分好的数组
 */
+ (NSMutableArray *)getArrayFromString:(NSString *)string WithType:(NSString *)typeStr
{
    NSMutableArray *arrWriterPos;
    if ([string length] > 0)
    {
        arrWriterPos = [[NSMutableArray alloc] initWithArray:[string componentsSeparatedByString:typeStr]];
    }
    return arrWriterPos;
}

/**
 *  int类型的数据转换成NSData
 *  2016/07/18 modify By Aney
 *  @param operatetype 需要转换的int类型
 *
 *  @return 返回转换好的NSData类型
 */
+(NSData *)intTochar:(int)operatetype
{
    NSNumber *data = [NSNumber numberWithChar:operatetype];
    char value = [data charValue];
    
    NSMutableData *charData = [NSMutableData dataWithBytes:&value length:sizeof(char)];
    
    return charData;
}


/**
 *  计算NSData对应的CRC值（128）
 *  2016/07/18 modify By Aney
 *  @param data  需要计算的NSData数据
 *  @param lenth 数据长度
 *
 *  @return 返回计算好的CRC值
 */
+ (uint16_t)creatCRCWith:(NSData *)data withLenth:(NSInteger)lenth
{
    uint16_t crc = 0xffff;
    Byte *testByte = (Byte *)[data bytes];
    for (int i = 0; i<lenth; i++)
    {
        crc = (unsigned char)(crc>>8)| (crc<<8);
        crc ^= testByte[i];
        crc ^= (unsigned char)(crc & 0xff)>>4;
        crc ^= (crc << 8)<<4;
        crc ^= ((crc & 0xff)<<4)<<1;
    }
    return crc;
}

/**
 *  2016/07/18 modify By Aney
 *  获取当前手机系统语言,主要用于区分中文以及非中文
 */
+(void)saveCurrentLanguage
{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    NSLog( @"languages~~~~%@" , languages);//简体汉字zh-Hans,英文en
    if ([currentLanguage hasPrefix:@"zh"])
    {
        NSLog(@"+>>>>>>>>中文---");
        [self setBoolState:YES defaultKey:SIMPLECHINESE];
    }
    else
    {
        NSLog(@"+>>>>>>>>非中文---");
        
        [self setBoolState:NO defaultKey:SIMPLECHINESE];
    }
}

/**
 *  生成特定长度的随机数
 *  2016/07/18 modify By Aney
 *  @param randomLength 制定的长度
 *
 *  @return 返回制定长度的字符串
 */
+ (NSString*) randomWithLengh:(int)randomLength
{
    static char* RANDOM_STR = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    static int RANDOM_STR_LEN = 62;
    
    NSMutableData* tmpBuf = [NSMutableData dataWithLength:randomLength];
    char* tmpPointer = [tmpBuf mutableBytes];
    for (int i = 0; i < randomLength; i++)
    {
        tmpPointer[i] = RANDOM_STR[arc4random() % RANDOM_STR_LEN];
    }
    NSString* result = [[NSString alloc] initWithData:tmpBuf encoding:NSASCIIStringEncoding];//[NSString stringWithCString:tmpPointer encoding:NSASCIIStringEncoding];
    
    return result;
}

/**
 *  由于IOS数据存储为小端存储，故在于其他硬件设备交互时需要进行数据移位
 *  2016/07/18 modify By Aney
 *  @param number 需要因为的两个字节数据
 *
 *  @return 移位后的数据
 */
+ (UInt16)NSDataToUInt16:(UInt16)number
{
    number = (number & 0xFF)<<8 | (number >>8);
    return number;
}

/**
 *  由于IOS数据存储为小端存储，故在于其他硬件设备交互时需要进行数据移位
 *  2016/07/18 modify By Aney
 *  @param number 需要因为的四个字节数据
 *
 *  @return 移位后的数据
 */
+ (UInt32) NSDataToUInt32:(UInt32)number
{
    number = ((number&0xFF)<<24) | (((number>>8)&0xFF)<<16) | (((number>>16)&0xFF)<<8) | ((number >>24)&0xFF);
    return number;
}

/**
 *  把字典数据转换成对应的Model数据
 *  2016/07/18 modify By Aney
 *  @param dicArray       存放字典对应的数组
 *  @param modelClassName 需要转换的Model类名
 *
 *  @return 返回建模好的数据Model
 */
+ (NSArray *)convertDicArrayToModelArray:(NSArray *)dicArray withModelClass:(NSString*)modelClassName
{
    NSMutableArray *modelArray = [NSMutableArray array];
    
    Class getModelClass = NSClassFromString(modelClassName);
    
    if (dicArray.count != 0) {
        for (NSDictionary *dic in dicArray) {
            id model = [[getModelClass alloc]init];
            
            if ([dic isKindOfClass:[NSDictionary class]]) {
                
                [model setValuesForKeysWithDictionary:dic];
                
                [modelArray addObject:model];
            }
            
            
        }
    }
    
    return [NSArray arrayWithArray:modelArray];
}



/**
 *  返回制定范围的随机数
 *  2016/07/18 modify By Aney
 *  @param fromNumber 其实范围
 *  @param toNumber   结束范围
 *
 *  @return 返回到的随机数
 */
+ (int)getRandomNumber:(int)fromNumber to:(int)toNumber
{
    //2、  获取一个随机数范围在：[500,1000），包括500，包括1000
    
    int y = (arc4random() % (toNumber-fromNumber+1) + fromNumber);
    return y;
}

/**
 *  检测系统通知开关是否打开
 *  2016/07/18 modify By Aney
 *  @return 返回开关状态
 */
+ (BOOL)isAllowedNotification
{
    if (IOS8)
    {//ios8
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone != setting.types)
        {
            return YES;
        }
    }
    else
    {//ios7
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if (UIRemoteNotificationTypeNone != type)
        {
            return YES;
        }
    }
    return NO;
}

/**
 *  请求itunes 获取当前APP的信息，APP升级需要
 *  2016/07/18 modify By Aney
 *  @param delegate alertView框对应的delegate
 *  @param alertTag alertView框对应的Tag值
 *  @param appId    对应提交到APP store对应的APP ID
 *
 *  @return 返回更新APP对应的URL
 */
+ (NSString *)checkAppUpdateFromAppStoreDelegate:(id /*<UIAlertViewDelegate>*/)delegate withAlertTag:(int)alertTag WithAppId:(NSString *)appId
{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *nowVersion = [infoDict objectForKey:@"CFBundleVersion"]; //当前APP的版本号
    
    NSError *error;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",appId]];//921410129 AW600 1097693984
    
    if ([self getBoolState:SIMPLECHINESE])
    {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",appId]];
    }
    NSURLRequest *request= [NSURLRequest requestWithURL:url];
    NSData *response=[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString * trackViewUrl = [NSString new];
    
    
    if (response != nil)
    {
        NSDictionary *dict=  [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        NSArray *res= [dict objectForKey:@"results"];
        
        if([res count])
        {
            NSDictionary *resDict= [res objectAtIndex:0];
            
            NSString *newVersion = [resDict objectForKey:@"version"];
            NSString *releaseNotes = [resDict objectForKey:@"releaseNotes"];
            NSLog(@"%@",releaseNotes);
            
            if([nowVersion compare:newVersion] == NSOrderedAscending)   //当前的版本小余APP Store版本时提示升级
            {
                
                trackViewUrl=[resDict objectForKey:@"trackViewUrl"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *message=[[NSString alloc] initWithFormat:@"%@ %@,%@ %@\n",@"当前版本为", nowVersion, @"最新版本为",newVersion];

                    //因为系统自带的UIAlertView显示的文字是默认居中的，所以这里使用CustomAlertView
                    UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"检测版本更新" message:message  delegate:delegate  cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil ];
                    alert.tag = alertTag;
                    [alert show];

                });
                
            }
        }
        
    }
    
    return trackViewUrl;
}

/**
 *  获取系统所有的国家
 *  2016/07/18 modify By Aney
 *  @return 返回获取到的国家
 */
+(NSMutableArray *)getSystermAllCountry
{
    NSLocale *locale = [NSLocale currentLocale];
    
    NSArray *countryArray = [NSLocale ISOCountryCodes];
    NSMutableArray * countriesArray = [NSMutableArray new];
    
    for (NSString *countryCode in countryArray)
    {
        NSString *displayNameString = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
        
        [countriesArray addObject:displayNameString];
        
    }
    //NSLog(@"-=---------%@", countriesArray);
    return countriesArray;
}


/**
 *  获取国家对应的代号
 *  2016/07/18 modify By Aney
 *  @return 返回获取到的代号
 */
+ (NSDictionary *)getSystermCountryCode
{
    NSArray *countryCodes = [NSLocale ISOCountryCodes];
    
    NSDictionary *codeForCountryDictionary = [[NSDictionary alloc] initWithObjects:countryCodes forKeys:[self getSystermAllCountry]];
    //NSLog(@"-=---------%@", codeForCountryDictionary);
    return codeForCountryDictionary;
}


/**
 *  数组中的数据进行排序处理。
 *  2016/07/18 modify By Aney
 *  @param array 需要升序排列的数组
 *
 *  @return 返回升序排列好的数组
 */
+(NSArray *)rankArray:(NSArray *)array
{
    NSMutableArray *mutableArray = [[NSMutableArray alloc]initWithArray:array];
    
    for (int i=0; i<[mutableArray count]; i++) {
        NSString *value = [mutableArray objectAtIndex:i];
        
        for (int j =i+1; j<[mutableArray count]; j++)
        {
            NSString  *nextvalue = [mutableArray objectAtIndex:j];
            if ([value intValue] > [nextvalue intValue])
            {
                [mutableArray exchangeObjectAtIndex:i withObjectAtIndex:j];
                value = nextvalue;
            }
            
        }
    }
    return mutableArray;
}

/**
 *  验证手机号格式是否正确
 *  2016/07/28 modify By Alice
 *  @param str 输入的电话号
 *
 *  @return 合法则返回YES
 */
+ (BOOL)isValidPhoneNumber:(NSString *)str {
    NSPredicate *rexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", VALIDATE_PHONE_REGEX];
    return [rexTest evaluateWithObject:str];
}

/**
 *  验证手机号格式是否正确
 *  2016/07/28 modify By Alice
 *  @param str 输入的电话号
 *
 *  @return 合法则返回YES
 */
+ (BOOL)isvalidPassword:(NSString *)str {
    NSPredicate *rexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", VALIDATE_PASSWORD_REGEX];
    return [rexTest evaluateWithObject:str];
}

+(NSString *)getUserID{
    
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:USERID];
    if (!userid)
    {
        //TODO 暂时测试用，不需要登录
        userid = DefaultUserId;
    }
    return userid;
}


+ (NSAttributedString *)getModifyGoodFrom:(NSString *)SourceStr withUnit:(NSArray *)unitArray withAttributArr:(NSArray *)attriArry
{
    
    if ([unitArray count]== 2)
    {
        NSMutableAttributedString *strhour = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%d",[SourceStr intValue]/60] attributes:attriArry[0]];
        
        NSMutableAttributedString *strMinute = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%d",[SourceStr intValue]%60] attributes:attriArry[0]];
        
        [strhour appendAttributedString:[[NSAttributedString alloc] initWithString:unitArray[0] attributes:attriArry[1]]];
        [strMinute appendAttributedString:[[NSAttributedString alloc] initWithString:unitArray[1] attributes:attriArry[1]]];
        [strhour appendAttributedString:strMinute];
        return strhour;
    }
    else if([unitArray count]== 1)
    {
        if (SourceStr == nil)
        {
            SourceStr = @"0";
        }
        NSMutableAttributedString *str2 = [[NSMutableAttributedString alloc]initWithString:SourceStr attributes:attriArry[0]];
        [str2 appendAttributedString:[[NSAttributedString alloc] initWithString:unitArray[0] attributes:attriArry[1]]];
        return str2;
    }
    return nil;
}


+ (void)OpenSystemBleSetting
{
    
    
    NSURL *url = [NSURL URLWithString:@"prefs:root=Bluetooth"];
    
    if (IOS10)
    {
        UIAlertView *alrt = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"系统蓝牙未打开!请打开手机设置-蓝牙,开启系统蓝牙" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        
        [alrt show];
    }else
    {
        if ([[UIApplication sharedApplication] canOpenURL:url])
            
        {
        
            [[UIApplication sharedApplication] openURL:url];
        
        }
    }
}


+ (NSString *)stringByReversed:(NSString *)str
{
    NSMutableString *s = [NSMutableString string];
    for (NSUInteger i=str.length; i>0; i--) {
        [s appendString:[str substringWithRange:NSMakeRange(i-1, 1)]];
    }
    return s;
}

+ (NSString*)hexStringForData:(NSData*)data

{
    
    if (data == nil) {
        
        return nil;
        
    }
    
    
    NSMutableString* hexString = [NSMutableString string];
    
    
    const unsigned char *p = [data bytes];
    
    
    
    for (int i=0; i < [data length]; i++) {
        
        [hexString appendFormat:@"%02x", *p++];
        
    }
    
    return hexString;
    
}


+ (NSString*)TimeformatFromSeconds:(NSInteger)seconds
{
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    
    NSLog(@"%@",format_time);
    return format_time;
}



/**
 *  
 */

@end
