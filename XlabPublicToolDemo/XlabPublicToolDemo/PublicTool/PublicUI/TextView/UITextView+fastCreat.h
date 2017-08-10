//
//  UITextView+fastCreat.h
//  ModularizationPro
//
//  Created by DONGWANG on 2017/6/13.
//  Copyright © 2017年 com.Fenda.Fly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (fastCreat)

/**
 快速创建uitextView

 @param frame 生成UItextView的fram
 @param text text内容
 @param size text字体大小
 @return 返回创建的TextView
 */
+(UITextView *)getTextView:(CGRect)frame   text:(NSString *)text size:(int)size;
@end
