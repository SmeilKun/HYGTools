//
//  HYGUtility.m
//  SDLayoutTest
//
//  Created by 胡亚刚 on 16/4/26.
//  Copyright © 2016年 hu yagang. All rights reserved.
//

#import "HYGUtility.h"

@implementation HYGUtility

+ (BOOL)hyg_validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)hyg_validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符 新增17开头
    NSString *phoneRegex = @"^((13[0-9])|(14[0,0-9])|(15[0,0-9])|(18[0,0-9])|(17[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

+ (BOOL)hyg_validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

+ (BOOL)hyg_validatePassword:(NSString *)password {
    BOOL flag;
    if (password.length <= 0) {
        flag = NO;
        return flag;
    }
    //字母、数字、特殊字符任意两种，不包含中文和空格
    NSString *regex2 = @"(?!.*[\u4E00-\u9FA5\\s])(?!^[a-zA-Z]+$)(?!^[\\d]+$)(?!^[^a-zA-Z\\d]+$)^.{8,20}$";
    NSPredicate *passwordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [passwordPredicate evaluateWithObject:password];
}

+ (NSString *)hyg_getCurrentCursor
{
    NSTimeInterval currentDate = [[NSDate date] timeIntervalSince1970];
    NSString * cursor = [NSString stringWithFormat:@"%.0f",currentDate];
    return cursor;
}

+ (NSString *)hyg_getCurrentVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

@end
