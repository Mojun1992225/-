//
//  EBApiClient+LogIn.h
//  zhaoshangdai
//
//  Created by gitBurning on 15/7/10.
//  Copyright (c) 2015年 ZhiAi. All rights reserved.
//

#import "EBApiClient.h"

/**
 *  版本更新
 *
 */
#define kHTTPValidVersion @"hszsd.ra.validVersion"
@interface EBApiClient (LogIn)

//用户注册
-(void)registerWithPhoneNumber:(NSString*)phoneNumber withPassword:(NSString*)password withnickName:(NSString*)nickName withtype:(NSString*)type withuid:(NSString*)uid andOther:(id)other
                    success:(void(^)(BOOL success,id other,NSString* alter))success failse:(void(^)(BOOL failse,id other))failse;

//用户登录(第三方)
-(void)thirdLoginWithuid:(NSString*)uid withtype:(NSString*)type withtokenInfo:(NSString*)tokenInfo withuserInfo:(NSString*)userInfo andOther:(id)other
                       success:(void(^)(BOOL success,id other,NSString* alter))success failse:(void(^)(BOOL failse,id other))failse;

//检查手机号存在
-(void)validPhone:(NSString*)phone withOther:(id)other success:(void(^)(BOOL success,id other, NSString*codeNumber))success failse:(void(^)(BOOL failse,id other))failse;


//发送验证码
-(void)getPhoneCodeWithPhoneNumber:(NSString*)number  type:(NSString*)type success:(void(^)(BOOL success,id other,NSString*codeNumber))success failse:(void(^)(BOOL failse,id other))failse;

//校验验证码
-(void)validCodeWithSmsId:(NSString*)smsId withCode:(NSString*)Code success:(void(^)(BOOL success,NSString*codeNumber))success failse:(void(^)(BOOL failse,id other))failse;

//登录(手机)
-(void)logInWithPhoneNumber:(NSString*)phoneNumber withPassword:(NSString*)password andOther:(id)other
                    success:(void(^)(BOOL success,id other,NSString* alter))success failse:(void(^)(BOOL failse,id other))failse;

//忘记密码
-(void)forgetPasswordWithPhoneNumber:(NSString*)phoneNumber withPassword:(NSString*)password andOther:(id)other
                             success:(void(^)(BOOL success,id other,NSString* alter))success failse:(void(^)(BOOL failse,id other))failse;

//检查版本号
-(void)checkVersonSuccess:(void(^)(BOOL success,id other,NSString* alter))success failse:(void(^)(BOOL failse,id other))failse;
@end
