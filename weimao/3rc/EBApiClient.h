//
//  EBApiClient.h
//  E-beans
//
//  Created by jingbaoying on 15/5/9.
//  Copyright (c) 2015年 aa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"
#import "HTTPConfig.h"
//#define kPostAlter @"提交数据中..."
//#define kGetAlter  @"获取数据中..."
#define kPostAlter @""
#define kGetAlter  @""
#define kHTTPErrorAlter  @"服务器连接失败"
@interface EBApiClient : AFHTTPRequestOperationManager<UIActionSheetDelegate>

+ (instancetype)sharedEBApiClient;

- (BOOL)isNetworkAvailable;//  网络是否可见
/**
 *  获取公共参数
 *
 *  @param userInf <#userInf description#>
 *
 *  @return <#return value description#>
 */
- (NSMutableDictionary*)generateParameter1:(id)userInf  withToken:(NSString *)token  withMetho:(NSString*)method;

- (NSMutableDictionary*)generateParameter:(id)userInf   withMetho:(NSString*)method;

-(NSString*)getStringWithDict:(NSDictionary*)dict;

-(NSString*)getStringWithDict1:(NSDictionary*)dict;

@end
