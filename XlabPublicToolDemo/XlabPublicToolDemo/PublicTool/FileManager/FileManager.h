//
//  FileManager.h
//  ModularizationPro
//
//  Created by DONGWANG on 2017/6/22.
//  Copyright © 2017年 com.Fenda.Fly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject
/**
 *  创建文件夹
 *
 *  @param file 文件的名称
 *
 *  @return 返回创建文件夹的路径
 */
+ (NSString *)creatFileDictionaryWithFile:(NSString *)file  withfile:(NSString *)fileName;

/**
 *  获取文件夹路径
 *
 *  @param fileName 文件的名称
 *
 *  @return 返回创建文件夹的路径
 */
+ (NSString *)getFileDictionaryWithFile:(NSString *)fileName;

/**
 特定的数据写入文件
 
 @param filePath 写入的文件名称，若不存在则直接创建
 @param dataArray 数据的内容
 @param resultBlock 写完成之后对应的Block
 */
+(void)writeFile:(NSString*)filePath withDataArray:(NSArray *)dataArray withBlock:(void(^)(BOOL isSuccess))resultBlock;

/**
 *  删除Document下的文件
 *
 *  @param type     文件类型
 *  @param filepath 文件路径
 */
+ (void)deleteDucomentFile:(NSString *)type withpath:(NSString *)filepath;

/**
 *  Document文件夹下面文件的重命名
 *
 *  @param folderName 新的文件的名称
 *  @param beforeName 旧文件的名称
 */
+ (void)changeFolderName:(NSString *)folderName beforeName:(NSString *)beforeName;

@end
