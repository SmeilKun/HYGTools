//
//  NSString+HYGExtension.m
//  HYGToolKit
//
//  Created by 胡亚刚 on 2017/7/11.
//  Copyright © 2017年 hu yagang. All rights reserved.
//

#import "NSString+HYGExtension.h"

@implementation NSString (HYGExtension)

- (NSString *)toValidString {

    if (self && (NSNull *)self != [NSNull null] && ![self isEqualToString:@"(null)"] && ![self isEqualToString:@"<null>"] && self.length > 0) {

        return self;
    }

    return nil;
}

+ (NSString *)hyg_validString:(NSString *)string {

    if (string != nil &&
        (NSNull *)string != [NSNull null] &&
        [string isKindOfClass:[NSString class]] &&
        ![string isEqualToString:@"(null)"] &&
        ![string isEqualToString:@"<null>"] && string.length > 0) {

        return string;
    }

    return nil;
}

+ (BOOL)hyg_isNull:(NSString *)string {

    string = [NSString hyg_validString:string];

    if (string == nil) {

        return YES;
    }

    return NO;
}

+ (NSString *)hyg_notNilString:(NSString *)string {

    string = [NSString hyg_validString:string];

    if (string == nil) {

        return @"";
    }

    return string;
}

+ (NSString *)hyg_filterHTML:(NSString *)html{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO){
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    html = [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    html = [html stringByReplacingOccurrencesOfString:@"&quot;" withString:@" "];
    html = [html stringByReplacingOccurrencesOfString:@"&apos;" withString:@" "];
    html = [html stringByReplacingOccurrencesOfString:@"&lt;" withString:@" "];
    html = [html stringByReplacingOccurrencesOfString:@"&gt;" withString:@" "];
    html = [html stringByReplacingOccurrencesOfString:@"&amp;" withString:@" "];
    return html;
}

+ (NSString *)hyg_getConstellationWithMonth:(NSInteger)month day:(NSInteger)day
{
    NSString * con = nil;
    if (!month || !day)return nil;

    if (month == 1) {
        if (day >= 20) {
            con = @"水瓶座";
        }else{
            con = @"摩羯座";
        }
    }

    if (month == 2) {
        if (day >= 19) {
            con = @"双鱼座";
        }else{
            con = @"水瓶座";
        }
    }

    if (month == 3) {
        if (day >= 21) {
            con = @"白羊座";
        }else{
            con = @"双鱼座";
        }
    }

    if (month == 4) {
        if (day >= 20) {
            con = @"金牛座";
        }else{
            con = @"白羊座";
        }
    }

    if (month == 5) {
        if (day >= 21) {
            con = @"双子座";
        }else{
            con = @"金牛座";
        }
    }

    if (month == 6) {
        if (day >= 22) {
            con = @"巨蟹座";
        }else{
            con = @"双子座";
        }
    }

    if (month == 7) {
        if (day >= 23) {
            con = @"狮子座";
        }else{
            con = @"巨蟹座";
        }
    }

    if (month == 8) {
        if (day >= 23) {
            con = @"处女座";
        }else{
            con = @"狮子座";
        }
    }

    if (month == 9) {
        if (day >= 23) {
            con = @"天秤座";
        }else{
            con = @"处女座";
        }
    }

    if (month == 10) {
        if (day >= 24) {
            con = @"天蝎座";
        }else{
            con = @"天秤座";
        }
    }

    if (month == 11) {
        if (day >= 23) {
            con = @"射手座";
        }else{
            con = @"天蝎座";
        }
    }

    if (month == 12) {
        if (day >= 20) {
            con = @"摩羯座";
        }else{
            con = @"射手座";
        }
    }

    return con;
}

+ (NSString *)hyg_shortedNumberDesc:(NSInteger)number {
    // should be localized
    if (number <= 9999) return [NSString stringWithFormat:@"%d", (int)number];
    if (number <= 9999999) return [NSString stringWithFormat:@"%d万", (int)(number / 10000)];
    return [NSString stringWithFormat:@"%d千万", (int)(number / 10000000)];
}

+ (NSString *)hyg_returnConfigDateStr:(NSDate *)lastDate
{
    NSTimeInterval late = [lastDate timeIntervalSince1970] * 1;
    NSDate * currentDate = [NSDate date];
    NSTimeZone * zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: currentDate];
    NSDate * localeDate = [currentDate  dateByAddingTimeInterval: interval];

    NSTimeInterval now = [localeDate timeIntervalSince1970] * 1;

    NSTimeInterval cha = late - now;

    NSString * dayStr;
    NSString * hourStr;
    NSString * minStr;

    NSMutableString * timeString = [[NSMutableString alloc] initWithString:@""];
    double day = cha / 86400;
    if (day > 1) {
        dayStr = [NSString stringWithFormat:@"%f", day];
        dayStr = [dayStr substringToIndex:dayStr.length - 7];
        dayStr = [NSString stringWithFormat:@"%@天", dayStr];
        [timeString appendString:dayStr];
    }

    double hour = (cha - (NSInteger)day * 86400);
    if (hour > 1) {
        hourStr = [NSString stringWithFormat:@"%f", hour / 3600];
        hourStr = [hourStr substringToIndex:hourStr.length - 7];
        hourStr = [NSString stringWithFormat:@"%@小时", hourStr];
        [timeString appendString:hourStr];
    }

    double min = (hour - (NSInteger)(hour / 3600) * 3600);
    if (min > 1) {
        minStr = [NSString stringWithFormat:@"%f", min / 60];
        minStr = [minStr substringToIndex:minStr.length - 7];
        minStr = [NSString stringWithFormat:@"%@分钟", minStr];
        [timeString appendString:minStr];
    }

    return timeString;
}

+ (NSString *)hyg_returnUploadTime:(NSString *)customDate
{
    NSDate * d = [NSDate dateWithTimeIntervalSince1970:customDate.doubleValue];
    NSTimeInterval late = [d timeIntervalSince1970] * 1;


    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now = [dat timeIntervalSince1970] * 1;
    NSString * timeString = @"";

    NSTimeInterval cha=now-late;

    if (cha/3600 < 1) {
        timeString = [NSString stringWithFormat:@"%f", cha / 60];
        timeString = [timeString substringToIndex:timeString.length - 7];
        if ([timeString intValue] < 1) {
            timeString = @"刚刚";
        }else{
            timeString = [NSString stringWithFormat:@"%@分钟前", timeString];
        }
    }
    if (cha / 3600 > 1 && cha / 86400 < 1) {
        timeString = [NSString stringWithFormat:@"%f", cha / 3600];
        timeString = [timeString substringToIndex:timeString.length - 7];
        timeString = [NSString stringWithFormat:@"%@小时前", timeString];
    }
    if (cha / 86400 > 1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha / 86400];
        timeString = [timeString substringToIndex:timeString.length - 7];
        timeString = [NSString stringWithFormat:@"%@天前", timeString];

    }
    return timeString;
}

+ (NSString *)dictionaryToJson:(NSDictionary *)dic {

    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];

    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {

    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        //        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (CGSize)stringSizeWithString:(NSString *)string size:(CGSize)size font:(UIFont *)font {
    CGSize strSize = CGSizeZero;
    if (size.width > 0) {
        strSize = CGSizeMake(size.width, 20);
    }
    strSize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;

    return strSize;
}

+ (NSString *)formatTime:(NSString *)format stamp:(double)timeStamp{
    if (!timeStamp) {
        return nil;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

+ (NSString *)formatDateToString:(NSString *)format date:(NSDate *)date {
    if (!date) {
        return nil;
    }
    NSDateFormatter * dateFormat = [NSDateFormatter new];
    dateFormat.dateFormat = format;
    return [dateFormat stringFromDate:date];
}

+ (NSDate *)formatStringToDate:(NSString *)format string:(NSString *)dateStr {
    if (!dateStr) {
        return nil;
    }
    NSDateFormatter * dateFormat = [NSDateFormatter new];
    dateFormat.dateFormat = format;
    return [dateFormat dateFromString:dateStr];
}

+ (NSString *)mobileEncryptionWithMobile:(NSString *)mobile {
    if (!mobile) {
        return nil;
    }
    if (mobile.length != 11) {
        return mobile;
    }
    NSString * subStr = [mobile substringWithRange:NSMakeRange(3, 4)];
    mobile = [mobile stringByReplacingOccurrencesOfString:subStr withString:@"****"];
    //NSLog(@"------%@,--------%@",subStr,mobile);
    return mobile;
}

@end
