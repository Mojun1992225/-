//
//  EBApiClient.m
//  E-beans
//
//  Created by jingbaoying on 15/5/9.
//  Copyright (c) 2015年 aa. All rights reserved.
//

#import "EBApiClient.h"
#import "SBJSON.h"
#import "UserInfo.h"
#define kAppKey @"cornucopia"
#define Format  @"json"

//版本号
#define kAppVersionString @"1.0"

//阿里云服务器地址
static NSString *const WYUserBaseURLString = @"http://112.74.81.110:8080/o2o";

//服务器地址
//static NSString *const WYUserBaseURLString = @"http://192.168.2.103:8080/o2o";

@implementation EBApiClient

+ (instancetype)sharedEBApiClient
{
    static EBApiClient *_sharedEBClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        AFSecurityPolicy* policy = [[AFSecurityPolicy alloc] init];
        [policy setAllowInvalidCertificates:YES];
        _sharedEBClient = [[EBApiClient alloc] initWithBaseURL:[NSURL URLWithString:WYUserBaseURLString]];
        [_sharedEBClient setSecurityPolicy:policy];
        _sharedEBClient.requestSerializer = [AFJSONRequestSerializer serializer];
        _sharedEBClient.responseSerializer = [AFJSONResponseSerializer serializer];
       // _sharedEBClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/x-javascript",@"application/json", @"text/json", @"text/html", nil];
    });
    return _sharedEBClient;
}

-(NSMutableDictionary *)generateParameter:(id  )userInf  withMetho:(NSString *)method
{
    NSMutableDictionary * dicc=[NSMutableDictionary dictionary];
    [dicc setObject:method forKey:@"method"];
    [dicc setObject:kAppVersionString forKey:@"version"];
    [dicc setObject:userInf forKey:@"bindObject"];
    if ([UserInfo shareUser].sessionId.length>0 )
    {
       [dicc setObject:[UserInfo  shareUser].sessionId forKey:@"sessionId"];
     }
    NSLog(@"post 参数--%@",dicc);
    return dicc;
}

-(NSString *)getStringWithDict:(NSDictionary *)dict1
{
    
    NSMutableDictionary * dict=[NSMutableDictionary dictionaryWithDictionary:dict1];
    if ([UserInfo shareUser].sessionId.length>0) {
        [dict setObject:[UserInfo  shareUser].sessionId forKey:@"sessionId"];
    }
       NSString * json=[[SBJsonWriter alloc] stringWithObject:dict];
    if (json==nil) {
        json=@"";
    }
    return  json;
//    __block NSString* postString=@"";
//    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        
//        if (postString.length==0) {
//            postString=[NSString stringWithFormat:@"%@:%@",key,obj];
//        }
//        else{
//            postString=[NSString stringWithFormat:@"%@,%@:%@",postString,key,obj];
//        }
//    }];
//    postString=[NSString stringWithFormat:@"{%@}",postString];
//    return postString;
}

//---------------------------------token----------------------------------------

-(NSMutableDictionary *)generateParameter1:(id)userInf withToken:(NSString *)token withMetho:(NSString *)method
{
    NSMutableDictionary * dicc=[NSMutableDictionary dictionary];
    [dicc setObject:kAppKey forKey:@"appkey"];
    [dicc setObject:method forKey:@"method"];
    [dicc setObject:Format forKey:@"format"];
    [dicc setObject:kAppVersionString forKey:@"version"];
    [dicc setObject:userInf forKey:@"bindObject"];
    [dicc setObject:token forKey:@"token"];
    if ([UserInfo shareUser].sessionId.length>0 ) {
        [dicc setObject:[UserInfo  shareUser].sessionId forKey:@"sessionId"];
    }
    NSLog(@"post 参数--%@",dicc);
    return dicc;
}


-(NSString *)getStringWithDict1:(NSDictionary *)dict1
{
    
    NSMutableDictionary * dict=[NSMutableDictionary dictionaryWithDictionary:dict1];
    if ([UserInfo shareUser].sessionId.length>0 ) {
        [dict setObject:[UserInfo  shareUser].sessionId forKey:@"sessionId"];
       
    }
    NSString * json=[[SBJsonWriter alloc] stringWithObject:dict];
    if (json==nil) {
        json=@"";
    }
    return  json;
   
}


@end
