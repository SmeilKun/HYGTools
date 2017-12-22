//
//  HYGUtility.h
//  SDLayoutTest
//
//  Created by 胡亚刚 on 16/4/26.
//  Copyright © 2016年 hu yagang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HYGUtility : NSObject
/*
 验证邮箱
 */
+ (BOOL)hyg_validateEmail:(NSString *)email;
/*
 验证手机号
 */
+ (BOOL)hyg_validateMobile:(NSString *)mobile;

/*
 验证身份证号
 */
+ (BOOL)hyg_validateIdentityCard: (NSString *)identityCard;
/*
 验证密码
 */
+ (BOOL)hyg_validatePassword:(NSString *)password;
/*
 获取当前时间戳
 */
+ (NSString *)hyg_getCurrentCursor;
/*
 获取当前版本号
 */
+ (NSString *)hyg_getCurrentVersion;
@end
