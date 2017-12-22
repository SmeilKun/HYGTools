//
//  NSString+HYGExtension.h
//  HYGToolKit
//
//  Created by 胡亚刚 on 2017/7/11.
//  Copyright © 2017年 hu yagang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (HYGExtension)

/*!
 @methods
 @brief 输出实际合法字符串
 @return nil | 实际值
 */
+ (NSString *)hyg_validString:(NSString *)string;

/*!
 @methods
 @brief 检测是否是空字符串，nil、@""
 */
+ (BOOL)hyg_isNull:(NSString *)string;
/*
 返回非空字符串
 */
+ (NSString *)hyg_notNilString:(NSString *)string;
/*!
 @brief HTML标签处理
 @param html 需要处理的HTML字符串
 */
+ (NSString *)hyg_filterHTML:(NSString *)html;

/*!
 @brief 根据几月几号返回所属星座
 @param month 月份(几月)
 @param day 天数(几号)
 */
+ (NSString *)hyg_getConstellationWithMonth:(NSInteger)month day:(NSInteger)day;
/*!
 @brief 对长数字处理成短格式（1~9999->不变，10000~9999999->%ld万，10000000~MAX->%ld千万）
 @param number 数字
 */
+ (NSString *)hyg_shortedNumberDesc:(NSInteger)number;
/*!
 @brief 返回距离当前时间还有多久(天，小时，分钟)
 @param lastDate 日期
 */
+ (NSString *)hyg_returnConfigDateStr:(NSDate *)lastDate;
/*!
 @brief 返回多久时间前
 @param customDate 时间
 */
+ (NSString *)hyg_returnUploadTime:(NSString *)customDate;
/*!
 @brief 返回JSON字符串
 @param dic 字典
 */
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;
/*!
 @brief 返回字典
 @param jsonString JSON字符串
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
/*!
 @brief 返回字符串size
 @param string 字符串
 @param size 容器size
 @param font 字符串字体大小
 */
+ (CGSize)stringSizeWithString:(NSString *)string size:(CGSize)size font:(UIFont *)font;
/*!
 @brief 返回日期字符串
 @param format 日期格式
 @param timeStamp 时间戳
 */
+ (NSString *)formatTime:(NSString *)format stamp:(double)timeStamp;
/*!
 @brief 返回日期字符串
 @param format 日期格式
 @param date 日期
 */
+ (NSString *)formatDateToString:(NSString *)format date:(NSDate *)date;
/*!
 @brief 返回日期
 @param format 日期格式
 @param dateStr 日期字符串
 */
+ (NSDate *)formatStringToDate:(NSString *)format string:(NSString *)dateStr;
/*!
 @brief 返回局部加密的手机号
 @param mobile 手机号
 */
+ (NSString *)mobileEncryptionWithMobile:(NSString *)mobile;
@end
