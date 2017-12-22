//
//  YGTextField.m
//  XiaoJuEnglish
//
//  Created by HYG on 2017/11/28.
//  Copyright © 2017年 hu yagang. All rights reserved.
//

#import "YGTextField.h"

@implementation YGTextField

- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect rect = [super textRectForBounds:bounds];

    UIEdgeInsets insets = UIEdgeInsetsMake(0, 12, 0,0);
    return UIEdgeInsetsInsetRect(rect, insets);
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect rect = [super textRectForBounds:bounds];

    UIEdgeInsets insets = UIEdgeInsetsMake(0, 12, 0,0);
    return UIEdgeInsetsInsetRect(rect, insets);
}

@end
