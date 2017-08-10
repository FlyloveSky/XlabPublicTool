//
//  FileManager.m
//  ModularizationPro
//
//  Created by DONGWANG on 2017/6/22.
//  Copyright © 2017年 com.Fenda.Fly. All rights reserved.
//

#import "FileManager.h"
#import "ZipArchive.h"
@implementation FileManager


/**
 *  创建文件夹
 *
 *  @param file 文件的名称
 *
 *  @return 返回创建文件夹的路径
 */
+ (NSString *)creatFileDictionaryWithFile:(NSString *)file  withfile:(NSString *)fileName
{
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:fileName];
    BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    NSAssert(bo,@"创建目录失败");
    
    NSString *result = [path stringByAppendingPathComponent:file];
    return result;
}


/**
 *  获取文件夹路径
 *
 *  @param fileName 文件的名称
 *
 *  @return 返回创建文件夹的路径
 */
+ (NSString *)getFileDictionaryWithFile:(NSString *)fileName
{
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:fileName];
    BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    NSAssert(bo,@"创建目录失败");
    if (bo)
    {
        return path;
    }
    
    return nil;
}

/**
 特定的数据写入文件

 @param filePath 写入的文件名称，若不存在则直接创建
 @param dataArray 数据的内容
 @param resultBlock 写完成之后对应的Block
 */
+(void)writeFile:(NSString*)filePath withDataArray:(NSArray *)dataArray withBlock:(void(^)(BOOL isSuccess))resultBlock;

{
    
    //创建文件管理器对象
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString* _filename = filePath;
    __block NSFileHandle  *outFile;
    NSLog(@"+>>>>>>>>-数据个数--------%lu",(unsigned long)[dataArray count]);
    [dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx != 0)
        {
            
            //创建目录
            
            if ( ![fileManager fileExistsAtPath:_filename])
            {
                [fileManager createFileAtPath:_filename contents:nil attributes:nil];
            }
            
            NSData *buffer;
            
            outFile = [NSFileHandle fileHandleForWritingAtPath:_filename];
            
            if(outFile == nil)
            {
                NSLog(@"Open of file for writing failed");
            }
            
            //找到并定位到outFile的末尾位置(在此后追加文件)
            [outFile seekToEndOfFile];
            
            //读取inFile并且将其内容写到outFile中
            NSString *bs = [NSString stringWithFormat:@"%@",obj];
            buffer = [bs dataUsingEncoding:NSUTF8StringEncoding];
            
            [outFile writeData:buffer];
            
        }
        
        if (idx == [dataArray count]-1)
        {
            //操作文件成功
            dispatch_async(dispatch_get_main_queue(), ^{
                resultBlock(YES);
            });

            //关闭读写文件
            [outFile closeFile];
        }
    }];
    
    
    
}

/**
 *  删除Document下的文件
 *
 *  @param type     文件类型
 *  @param filepath 文件路径
 */
+ (void)deleteDucomentFile:(NSString *)type withpath:(NSString *)filepath
{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    //文件名
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:filepath];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    if (!blHave)
    {
        NSLog(@"no  have");
        return ;
    }
    else
    {
        NSLog(@" have");
        BOOL blDele= [fileManager removeItemAtPath:uniquePath error:nil];
        if (blDele)
        {
            NSLog(@"dele success");
        }
        else
        {
            NSLog(@"dele fail");
        }
        
    }
}

/**
 *  Document文件夹下面文件的重命名
 *
 *  @param folderName 新的文件的名称
 *  @param beforeName 旧文件的名称
 */
+ (void)changeFolderName:(NSString *)folderName beforeName:(NSString *)beforeName
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *beforeFolder = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),beforeName];
    NSString *afterFolder = [NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),folderName];
    
    
    [fm copyItemAtPath:beforeFolder toPath:afterFolder error:nil];
}

/**
 *  清除APP内的数据
 *
 *  @param searchPath 需要清理的文件的路径
 */
+ (void)removeAPPMemoryFile:(NSSearchPathDirectory)searchPath
{
    //===============清除缓存==============
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(searchPath, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    //    NSLog(@"文件数 ：%d",[files count]);
    for (NSString *p in files)
    {
        NSError *error;
        NSString *path = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
        if([[NSFileManager defaultManager] fileExistsAtPath:path])
        {
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        }
    }
}

/**
 *  Txt文件压缩成Zip文件
 *
 *  @param filepatharray Txt文件数组
 *  @param zippath       压缩好的文件夹
 */
+ (void)zipFilesButtonPressedwithFile:(NSArray *)filepatharray withZip:(NSString *)zippath
{
    NSString *cachePath = [self getFileDictionaryWithFile:zippath];
    NSString *zipFile = [[self getFileDictionaryWithFile:zippath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.zip",zippath]];
    ZipArchive *za = [[ZipArchive alloc] init];
    [za CreateZipFile2:zipFile];
    
    for (int i = 0; i<[filepatharray count]; i++)
    {
        NSString *textPath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",filepatharray[i],@"txt"]];
        [za addFileToZip:textPath newname:[NSString stringWithFormat:@"%@.%@",filepatharray[i],@"txt"]];
    }
    
    BOOL success = [za CloseZipFile2];
    NSLog(@"Zipped file with result %d",success);
    
}


@end
