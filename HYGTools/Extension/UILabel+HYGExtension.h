//
//  UILabel+HYGExtension.h
//  HYGToolKit
//
//  Created by 胡亚刚 on 2017/8/24.
//  Copyright © 2017年 hu yagang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (HYGExtension)
//以下三个扩展属性在label初始化时设置，单独设置无效。
@property (nonatomic,assign) CGFloat lineSpace;//行间隔
@property (nonatomic,assign) CGFloat fontLineSpace;//字体间隔
@property (nonatomic,assign) BOOL isFirstLineHeadIndent;//是否首行缩进
//设置有行间隔和字体间隔时的内容。注意：若使用了以上任意一个扩展属性，设置label内容必须使用hyg_Text设置，否则扩展属性无效。
@property (nonatomic,copy) NSString * hyg_Text;
//获取设置过行间距、字间距、首行缩进的内容高度。注意：在设置过hyg_Text之后方可调用生效，并且样式需统一
- (CGFloat)getHyg_TextHeightWithSize:(CGSize)labelSize;
//设置某段文字字体颜色、字体样式大小。建议：如果一段文字中有部分样式不同，label布局的时候建议使用sizeToFit自动调整
- (void)setTextColor:(UIColor *)textColor font:(UIFont *)font range:(NSRange)range;

@end
