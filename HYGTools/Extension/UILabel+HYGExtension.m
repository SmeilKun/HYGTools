//
//  UILabel+HYGExtension.m
//  HYGToolKit
//
//  Created by 胡亚刚 on 2017/8/24.
//  Copyright © 2017年 hu yagang. All rights reserved.
//

#import "UILabel+HYGExtension.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation UILabel (HYGExtension)

char lineSpaceKey;
char fontLineSpaceKey;
char hyg_TextKey;
char isFirstLineHeadIndentKey;

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method textMethod = class_getInstanceMethod(self, @selector(setText:));
        Method hyg_textMethod = class_getInstanceMethod(self, @selector(setHyg_text:));
        method_exchangeImplementations(textMethod, hyg_textMethod);
    });
}

- (CGFloat)lineSpace {
    NSNumber * number = objc_getAssociatedObject(self, &lineSpaceKey);
    return number.floatValue;
}

- (CGFloat)fontLineSpace {

    NSNumber * number = objc_getAssociatedObject(self, &fontLineSpaceKey);
    return number.floatValue;
}

- (BOOL)isFirstLineHeadIndent {

    NSNumber * number = objc_getAssociatedObject(self, &isFirstLineHeadIndentKey);
    return number.boolValue;
}

- (NSString *)hyg_Text {

    return objc_getAssociatedObject(self, &hyg_TextKey);
}

- (void)setLineSpace:(CGFloat)lineSpace {

    objc_setAssociatedObject(self, &lineSpaceKey, @(lineSpace), OBJC_ASSOCIATION_RETAIN);
}

- (void)setFontLineSpace:(CGFloat)fontLineSpace {

    objc_setAssociatedObject(self, &fontLineSpaceKey, @(fontLineSpace), OBJC_ASSOCIATION_RETAIN);
}

- (void)setIsFirstLineHeadIndent:(BOOL)isFirstLineHeadIndent {

    objc_setAssociatedObject(self, &isFirstLineHeadIndentKey, @(isFirstLineHeadIndent), OBJC_ASSOCIATION_ASSIGN);
}

- (void)setHyg_text:(NSString *)text {
    if (self.lineSpace ||
        self.fontLineSpace ||
        self.isFirstLineHeadIndent) {

        objc_setAssociatedObject(self, &hyg_TextKey, text, OBJC_ASSOCIATION_COPY_NONATOMIC);

        if (!self.font) {
            self.font = [UIFont systemFontOfSize:17];
        }
        NSDictionary *dic = @{
                              NSFontAttributeName:self.font, NSParagraphStyleAttributeName:[self getParagraphStyle],
                              NSKernAttributeName:@(self.fontLineSpace?:1.0f),
                              NSForegroundColorAttributeName:self.textColor?:[UIColor blackColor]
                              };

        NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:text attributes:dic];
        self.attributedText = attributeStr;
    }else {
        [self setHyg_text:text];
    }
}

- (void)setHyg_Text:(NSString *)hyg_Text {

    objc_setAssociatedObject(self, &hyg_TextKey, hyg_Text, OBJC_ASSOCIATION_COPY_NONATOMIC);

    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:self.font, NSParagraphStyleAttributeName:[self getParagraphStyle], NSKernAttributeName:@(self.fontLineSpace?:1.0f),
        NSForegroundColorAttributeName:self.textColor
                          };

    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:hyg_Text attributes:dic];
    self.attributedText = attributeStr;
}

- (CGFloat)getHyg_TextHeightWithSize:(CGSize)labelSize {

    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:self.font, NSParagraphStyleAttributeName:[self getParagraphStyle], NSKernAttributeName:@(self.fontLineSpace?:1.0f),
        NSForegroundColorAttributeName:self.textColor
                          };


    CGSize textSize = [self.attributedText.string boundingRectWithSize:labelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return textSize.height;
}

- (void)setTextColor:(UIColor *)textColor font:(UIFont *)font range:(NSRange)range {

    if (!textColor) {
        textColor = self.textColor;
    }
    if (!font) {
        font = self.font;
    }
    if (range.location == 0 && range.length == 0) {
        range = NSMakeRange(0, self.hyg_Text?self.hyg_Text.length:self.text.length);
    }
    //NSString * text = self.hyg_Text?:self.text;
    NSMutableAttributedString * attr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText?:[[NSAttributedString alloc] initWithString:self.text]];
    NSDictionary *dic;
    if (self.hyg_Text) {
        //设置字间距 NSKernAttributeName:@1.5f
        dic = @{NSFontAttributeName:font,NSForegroundColorAttributeName:textColor, NSParagraphStyleAttributeName:[self getParagraphStyle], NSKernAttributeName:@(self.fontLineSpace?:1.0f)};
        [attr addAttributes:dic range:range];
        self.attributedText = attr;
    }else {
         dic = @{NSFontAttributeName:font,NSForegroundColorAttributeName:textColor};
        [attr addAttributes:dic range:range];
        self.attributedText = attr;
    }
}

- (NSMutableParagraphStyle *)getParagraphStyle {

    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = self.lineSpace; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = self.isFirstLineHeadIndent?2 * (self.fontLineSpace + self.font.pointSize):0;//设置首行缩进
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    return paraStyle;
}

@end
