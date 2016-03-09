//
//  EBApiClient+LogIn.m
//  zhaoshangdai
//
//  Created by gitBurning on 15/7/10.
//  Copyright (c) 2015年 ZhiAi. All rights reserved.
//

#import "EBApiClient+LogIn.h"
#import "UserInfo.h"
#import "login.h"
#import "EBApiClient.h"
//#define kAppVersionString [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//测试版本号
#define kAppVersionString @"1.0"
//服务器地址
#define  EBUserBaseURLString @"http://192.168.2.106:8080/o2o/service"


@implementation EBApiClient (LogIn)

#pragma mark---用户注册
-(void)registerWithPhoneNumber:(NSString *)phoneNumber withPassword:(NSString *)password withnickName:(NSString *)nickName withtype:(NSString *)type withuid:(NSString *)uid andOther:(id)other success:(void (^)(BOOL, id, NSString *))success failse:(void (^)(BOOL, id))failse
{
    //[UserInfo shareUser].sessionId=@"";
    //type ------第三方登录类型11、QQ 12、微信 13、 新浪微博--------
    NSMutableDictionary * dict=[@{@"password":password,
                                  @"phone":phoneNumber,
                                  @"nickName":nickName,
                                  @"type":type,
                                  @"uid":uid
                                  } mutableCopy];
    
    [self GET:kHTTPDomnut parameters:[self generateParameter:[self getStringWithDict:dict] withMetho:kHTTPregisterKey] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dict=responseObject;
            NSString* code=dict[@"code"];
            NSString * mgs=dict[@"message"];
            NSLog(@"--------------%@--------------",code);
            if ([code isEqualToString:kSuccessCode]) {
                
                NSDictionary * result=dict[@"result"];
                if ([result isKindOfClass:[NSDictionary class]]) {
                    
                    [UserInfo shareUser].sessionId=result[@"sessionId"];
                    [UserInfo shareUser].userId=result[@"userId"];
                    [UserInfo  shareUser].telephone=result[@"telephone"];
                    [UserInfo shareUser].type=result[@"type"];
                    
                    /**
                     *  等于 1 是 登录界面
                     */
                    success(YES,dict[@"result"],mgs);
                    
                }
                else{
                    success(NO,nil,kErrorAlter);
                }
            }
            else{
                success(NO,nil,mgs);
            }
        }
        else{
            success(NO,nil,kErrorAlter);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failse(NO,kHTTPErrorAlter);
    }];

}

#pragma mark - 验证手机号码
-(void)validPhone:(NSString *)phone withOther:(id)other success:(void (^)(BOOL, id other, NSString *))success failse:(void (^)(BOOL, id))failse
{
   
    id dict=@{@"phone":phone};
    
    [self GET:kHTTPDomnut parameters:[self generateParameter:[self getStringWithDict:dict] withMetho:kHTTPvalidPhoneKey] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dict=responseObject;
            NSString* code=dict[@"code"];
            NSString * message=dict[@"message"];
            if (message.length==0) {
                message=kErrorAlter;
            }
            if ([code isEqualToString:kSuccessCode]) {
                success(YES,nil,message);
            }
            else{
                success(NO,nil,message);
            }
        }
        else{
            success(NO,nil,kErrorAlter);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failse(NO,kHTTPErrorAlter);
    }];
    
}


//获取验证码
-(void)getPhoneCodeWithPhoneNumber:(NSString *)number   type:(NSString*)type success:(void (^)(BOOL, id, NSString *))success failse:(void (^)(BOOL, id))failse
{
    
    id dict=@{@"phone":number,@"type":type};
    
    [self GET:kHTTPDomnut parameters:[self generateParameter:[self getStringWithDict:dict] withMetho:kHTTPGetCodeKey] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            NSDictionary * dict=responseObject;
            NSString *code=dict[@"code"];
            
            if ([code isEqualToString:kSuccessCode]) {
                NSDictionary * result=dict[@"result"];
                [UserInfo shareUser].smsId=result[@"smsId"];
                NSLog(@"==========%@=====",result);
                NSLog(@"-----1---%@-----1---",[UserInfo shareUser].smsId);
                if ([result isKindOfClass:[NSDictionary class]]) {
                    success(YES,result,dict[@"result"]);
                }
                else
                {
                    success(NO,kErrorAlter,nil);
                }
            }
            else{
                NSLog(@"-----%@-----",code);
                success(NO,dict[@"message"],nil);
            }
        }
        else{
            success(NO,kErrorAlter,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failse(NO,kHTTPErrorAlter);
    }];
}

//校验验证码
-(void)validCodeWithSmsId:(NSString *)smsId withCode:(NSString *)Code success:(void (^)(BOOL, NSString *))success failse:(void (^)(BOOL, id))failse
{
    id dict=@{@"smsId":smsId,@"Code":Code};
    
    [self GET:kHTTPDomnut parameters:[self generateParameter:[self getStringWithDict:dict] withMetho:kHTTPValidCodeKey] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dict=responseObject;
            NSString* code=dict[@"code"];
            NSString * message=dict[@"message"];
            if (message.length==0) {
                message=kErrorAlter;
            }
            if ([code isEqualToString:kSuccessCode]) {
                success(YES,nil);
            }
            else{
                success(NO,message);
            }
        }
        else{
            success(NO,kErrorAlter);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failse(NO,kHTTPErrorAlter);
    }];
    
}

#pragma mark---登录（手机）
-(void)logInWithPhoneNumber:(NSString *)phoneNumber withPassword:(NSString *)password andOther:(id)other
                    success:(void (^)(BOOL, id, NSString *))success failse:(void (^)(BOOL, id))failse
{
    
    NSMutableDictionary * dict=[@{@"password":password,@"phone":phoneNumber} mutableCopy];

    [self GET:kHTTPDomnut parameters:[self generateParameter:[self getStringWithDict:dict] withMetho:kHTTPloginKey] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dict=responseObject;
            NSString* code=dict[@"code"];
            NSString * mgs=dict[@"message"];
            NSLog(@"--------------%@--------------",code);
            if ([code isEqualToString:kSuccessCode]) {
                
                NSDictionary * result=dict[@"result"];
                if ([result isKindOfClass:[NSDictionary class]]) {
                    
                    [UserInfo shareUser].sessionId=result[@"sessionId"];
                    [UserInfo shareUser].userId=result[@"userId"];
                    [UserInfo  shareUser].telephone=phoneNumber;
                    
                    /**
                     *  等于 1 是 登录界面
                     */
                success(YES,dict[@"result"],mgs);

                }
                else{
                    success(NO,nil,kErrorAlter);
                }
            }
            else{
                success(NO,nil,mgs);
            }
        }
        else{
            success(NO,nil,kErrorAlter);
        }
        
    }
      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failse(NO,kHTTPErrorAlter);
    }];

}

#pragma mark---登录（第三方）
-(void)thirdLoginWithuid:(NSString *)uid withtype:(NSString *)type withtokenInfo:(NSString *)tokenInfo withuserInfo:(NSString *)userInfo andOther:(id)other success:(void (^)(BOOL, id, NSString *))success failse:(void (^)(BOOL, id))failse
{
    NSMutableDictionary * dict=[@{@"uid":uid,
                                  @"type":type,
                                  @"tokenInfo":tokenInfo,
                                  @"userInfo":userInfo
                                  } mutableCopy];
    
    [self GET:kHTTPDomnut parameters:[self generateParameter:[self getStringWithDict:dict] withMetho:kHTTPthirdLoginKey] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dict=responseObject;
            NSString* code=dict[@"code"];
            NSString * mgs=dict[@"message"];
            NSLog(@"--------------%@--------------",code);
            if ([code isEqualToString:kSuccessCode]) {
                
                NSDictionary * result=dict[@"result"];
                NSLog(@"=========%@===========",result);
                if ([result isKindOfClass:[NSDictionary class]]) {
                    
                    [UserInfo shareUser].sessionId=result[@"sessionId"];
                    [UserInfo shareUser].userId=result[@"userId"];
                    
                    /**
                     *  等于 1 是 登录界面
                     */
                    success(YES,dict[@"result"],mgs);
                    
                }
                else{
                    success(NO,nil,kErrorAlter);
                }
            }
            else{
                success(NO,nil,mgs);
            }
        }
        else{
            success(NO,nil,kErrorAlter);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failse(NO,kHTTPErrorAlter);
    }];

}

#pragma mark--忘记密码
-(void)forgetPasswordWithPhoneNumber:(NSString *)phoneNumber withPassword:(NSString *)password andOther:(id)other
                             success:(void (^)(BOOL, id, NSString *))success failse:(void (^)(BOOL, id))failse
{
    
    [UserInfo shareUser].sessionId=@"";
    NSMutableDictionary * dict=[@{@"phone":phoneNumber,@"password":password} mutableCopy];
    
    [self GET:kHTTPDomnut parameters:[self generateParameter:[self getStringWithDict:dict] withMetho:kHTTPforgetPwdKey] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dict=responseObject;
            NSString* code=dict[@"code"];
            NSString * mgs=dict[@"message"];
            NSLog(@"==%@===",dict[@"code"]);
            if ([code isEqualToString:kSuccessCode]) {
                success(YES,nil,mgs);
            }
            else{
                success(NO,nil,mgs);
            }
        }
        else{
            success(NO,nil,kErrorAlter);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failse(NO,kHTTPErrorAlter);
    }];
    
    

}
-(void)checkVersonSuccess:(void (^)(BOOL, id, NSString *))success failse:(void (^)(BOOL, id))failse
{
    NSMutableDictionary * dict=[@{@"version":kAppVersionString,@"type":@"IOS"} mutableCopy];
    
    [self GET:kHTTPDomnut parameters:[self generateParameter:[self getStringWithDict:dict] withMetho:kHTTPValidVersion] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dict=responseObject;
            NSString* code=dict[@"code"];
            NSString * mgs=dict[@"message"];
            if ([code isEqualToString:kSuccessCode]) {
                
                NSDictionary *result=dict[@"result"];
                if ([result isKindOfClass:[NSDictionary class]]) {
                    NSString * isUpdate=result[@"isUpdate"];
                    NSString * url=result[@"url"];
                    //1、不需要更新 2、需要更新
                    if (isUpdate.integerValue==2) {
                        success(YES,url,mgs);

                    }
                    else{
                        success(NO,nil,mgs);
 
                    }
                }
                else
                    success(NO,nil,mgs);

            }
            else{
                success(NO,nil,mgs);
            }
        }
        else{
            success(NO,nil,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failse(NO,kHTTPErrorAlter);
    }];

}
@end
