//
//  UITextView+fastCreat.m
//  ModularizationPro
//
//  Created by DONGWANG on 2017/6/13.
//  Copyright © 2017年 com.Fenda.Fly. All rights reserved.
//

#import "UITextView+fastCreat.h"

@implementation UITextView (fastCreat)

+(UITextView *)getTextView:(CGRect)frame   text:(NSString *)text size:(int)size
{
    
    UITextView *textView=[[UITextView alloc] initWithFrame:frame];
    textView.editable=FALSE;
    textView.font=[UIFont fontWithName:@"Arial" size:size];
    textView.text=text;
    return textView;
    
}
@end
