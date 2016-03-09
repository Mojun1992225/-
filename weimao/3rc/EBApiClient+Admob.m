//
//  EBApiClient+Admob.m
//  zhaoshangdai
//
//  Created by gitBurning on 15/7/10.
//  Copyright (c) 2015年 ZhiAi. All rights reserved.
//

#import "EBApiClient+Admob.h"
#import "getNotice.h"
#import "lockLog.h"
#import "getBind.h"
#import "getBindHouse.h"
//#import "SVProgressHUD.h"
#import "getRelaPerson.h"

@implementation EBApiClient (Admob)

//  首页banner获取
-(void)quaryAdmobWithOther:(id)other success:(void (^)(BOOL, NSArray *, NSString *))success failse:(void (^)(BOOL, id))failse
{
    
    [self GET:kHTTPDomnut parameters:[self generateParameter:[self getStringWithDict:nil] withMetho:kHTTPBanner] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dict=responseObject;
            NSString* code=dict[@"code"];
            NSString * mgs=dict[@"message"];
            if ([code isEqualToString:kSuccessCode]) {
                
                NSArray * result=dict[@"result"];
                NSLog(@"%@",dict[@"result"]);
                __block NSMutableArray * tem=[NSMutableArray arrayWithCapacity:0];
                [result enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop) {
                   
                    Admob * admob=[[Admob alloc] initWithDictionary:obj error:nil];
                    [tem addObject:admob];
                }];
                                
                success(YES,tem,mgs);
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

//  业主绑定信息
-(void)getBindWithsessionId:(NSString *)sessionId success:(void (^)(BOOL,NSArray *,NSString *))success failse:(void (^)(BOOL, id))failse
{
    NSMutableDictionary * dict=[@{@"sessionId":sessionId} mutableCopy];
    
    [self GET:kHTTPDomnut parameters:[self generateParameter:[self getStringWithDict:dict] withMetho:kHTTPgetBindKey] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dict=responseObject;
            NSString *code=dict[@"code"];
            NSLog(@"-----业主绑定信息返回结果code---%@--------",code);
            NSString * message=dict[@"message"];
            NSLog(@"========%@=======",message);
            if (message.length==0) {
                message=kErrorAlter;
            }
            if ([code isEqualToString:kSuccessCode]) {
                NSArray *result=dict[@"result"];
                if (result.count==0)
                {
                    //[SVProgressHUD showSuccessWithStatus:@"业主绑定信息无数据,请联系物业添加"];
                    //[SVProgressHUD dismiss];
                    return ;
                }

                //houses  list(数组中内嵌数组的解析)
                NSDictionary *dict2=[result objectAtIndex:0];
                NSArray *array=dict2[@"houses"];
                
                NSDictionary* dict3=[array objectAtIndex:0];
                NSArray *array1=dict3[@"houseCode"];
                NSArray *array2=dict3[@"houseId"];
                NSArray *array3=dict3[@"relaType"];
                NSLog(@"－－－%@－－－%@－－－%@－－－",array1,array2,array3);
                
                NSLog(@"-----业主绑定信息返回结果---%@--------",dict[@"result"]);
                NSLog(@"-----业主绑定信息返回结果list---%@--------",dict2[@"houses"]);
               
                __block NSMutableArray * tem=[NSMutableArray arrayWithCapacity:0];
                [result enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                    
                    getBind *notice=[[getBind alloc] initWithDictionary:obj error:nil];
                    notice.houseCode=dict3[@"houseCode"];
                    notice.houseId=dict3[@"houseId"];
                    notice.relaType=dict3[@"relaType"];
                    notice.houseName=dict3[@"houseName"];

                    NSLog(@"＝＝＝＝%@＝＝＝%@＝＝＝%@＝＝%@＝",notice.relaType,notice.houseId,notice.houseCode,notice.houseName);
                    [tem addObject:notice];
                }];
                
                success(YES,tem,message);
                
            }
            else{
                success(NO,nil,message);
            }
        }
        else{
            success(NO,nil,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failse(NO,kHTTPErrorAlter);
    }];
}

//  业主绑定
-(void)bindWithsessionId:(NSString *)sessionId houseId:(NSString *)houseId  relaType:(NSString *)relaType success:(void (^)(BOOL, NSString *))success failse:(void (^)(BOOL, id))failse
{
    NSMutableDictionary * dict=[@{@"sessionId":sessionId,
                                  @"houseId":houseId,
                                  @"relaType":relaType
                                  } mutableCopy];
    
    [self GET:kHTTPDomnut parameters:[self generateParameter:[self getStringWithDict:dict] withMetho:kHTTPBindKey] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dict=responseObject;
            NSString *code=dict[@"code"];
            NSString * message=dict[@"message"];
            if (message.length==0) {
                message=kErrorAlter;
            }
            if ([code isEqualToString:kSuccessCode]) {
                success(YES,message);
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

//  个人信息
-(void)personalWithsessionId:(NSString *)sessionId success:(void (^)(BOOL,id, NSString *))success failse:(void (^)(BOOL, id))failse
{
    NSMutableDictionary * dict=[@{@"sessionId":sessionId} mutableCopy];
    
    [self GET:kHTTPDomnut parameters:[self generateParameter:[self getStringWithDict:dict] withMetho:kHTTPpersonalKey] success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        //编码(解决乱码问题)
        NSString * string=[[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        //NSLog(@"＝＝＝＝＝＝＝＝%@＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝",string);
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dict=responseObject;
            NSString *code=dict[@"code"];
            NSLog(@"----------%@---------",dict[@"code"]);
            NSString * message=dict[@"message"];
            NSLog(@"----------%@---------",dict[@"message"]);

            if ([code isEqualToString:kSuccessCode])
            {
                NSDictionary * result=dict[@"result"];
                NSLog(@"----------%@---------",dict[@"result"]);
                if ([result isKindOfClass:[NSDictionary class]]) {
                    
                    //[CheckTools savenickName:result[@"nickName"]];
                    //[CheckTools savesignature:result[@"signature"]];
                    //[CheckTools saveUserVaval:result[@"pesionImg"] withKey:[UserInfo shareUser].nickName];
                    success(YES,dict[@"result"],message);
                }
                else{
                    success(NO,nil,kErrorAlter);
                }
            }
            else{
                success(NO,nil,message);
            }
        }
        else{
            success(NO,nil,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failse(NO,kHTTPErrorAlter);
    }];
}

//  个人信息修改
-(void)modifyPersonalWithsessionId:(NSString *)sessionId nickName:(NSString *)nickName signature:(NSString *)signature pesionImg:(NSString *)pesionImg success:(void (^)(BOOL, id, NSString *))success failse:(void (^)(BOOL, id))failse
{
    NSMutableDictionary * dict=[@{@"sessionId":sessionId,
                                  @"nickName":nickName,
                                  @"signature":signature,
                                  @"pesionImg":pesionImg
                                  } mutableCopy];
    
    [self GET:kHTTPDomnut parameters:[self generateParameter:[self getStringWithDict:dict] withMetho:kHTTPmodifyPersonalKey] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //编码(解决乱码问题)
        NSString * string=[[NSString alloc]initWithData:operation.responseData encoding:NSISOLatin1StringEncoding];
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dict=responseObject;
            NSString* code=dict[@"code"];
            NSLog(@"---------%@------------",dict[@"code"]);
            NSString * mgs=dict[@"message"];
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
//    [self POST:kHTTPDomnut parameters:[self generateParameter:[self getStringWithDict:dict]withMetho:kHTTPmodifyPersonalKey]  success:^(AFHTTPRequestOperation *operation, id responseObject)
//    {
//        //编码(解决乱码问题)
//        NSString * string=[[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
//        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//            NSDictionary * dict=responseObject;
//            NSString* code=dict[@"code"];
//            NSLog(@"---------%@------------",dict[@"code"]);
//            NSString * mgs=dict[@"message"];
//            if ([code isEqualToString:kSuccessCode]) {
//                success(YES,nil,mgs);
//            }
//            else{
//                success(NO,nil,mgs);
//            }
//        }
//        else{
//            success(NO,nil,kErrorAlter);
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failse(NO,kHTTPErrorAlter);
//    }];
}

//  获取关系人  关系类型 10、业主 20、租户 30、亲属
-(void)getRelaPersonWithsessionId:(NSString *)sessionId   WithPage:(NSInteger)page andPageSize:(NSInteger)pageSize relaType:(NSString *)relaType success:(void (^)(BOOL, NSArray *, NSString *))success failse:(void (^)(BOOL, id))failse
{
    
    if (page<=0) {
        page=kDefualtPage;
    }
    if (pageSize<10) {
        pageSize=kDefualtSize;
    }
    NSMutableDictionary * dict=[@{@"sessionId":sessionId,
                                  @"relaType":relaType,
                                  @"page":@(page),
                                  @"rows":@(pageSize)
                                  } mutableCopy];
    
    [self GET:kHTTPDomnut parameters:[self generateParameter:[self getStringWithDict:dict] withMetho:kHTTPgetRelaPersonKey] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dict=responseObject;
            NSString* code=dict[@"code"];
            NSLog(@"-------------%@----",dict[@"code"]);
            NSString * mgs=dict[@"message"];
            if ([code isEqualToString:kSuccessCode]) {
                NSArray * result=dict[@"result"];
                NSLog(@"-----结果--------%@-----结果------",dict[@"result"]);
                if (result.count==0) {
                    //[SVProgressHUD showSuccessWithStatus:@"物业绑定信息为空,请联系物业添加"];
                }
                __block NSMutableArray * tem=[NSMutableArray arrayWithCapacity:0];
                [result enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop)
                {
                    getRelaPerson *notice=[[getRelaPerson alloc] initWithDictionary:obj error:nil];
                    //[UserInfo shareUser].userId=notice.userId;
                    //[UserInfo shareUser].houseId=notice.houseId;
                    [tem addObject:notice];
                }];
                success(YES,tem,mgs);
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

//添加关系人
-(void)addRelaPersonWithsessionId:(NSString *)sessionId relaType:(NSString *)relaType houseId:(NSString *)houseId telephone:(NSString *)telephone nickName:(NSString *)nickName success:(void (^)(BOOL, id, NSString *))success failse:(void (^)(BOOL, id))failse
{
    NSMutableDictionary * dict=[@{@"sessionId":sessionId,
                                  @"relaType":relaType,
                                  @"houseId":houseId,
                                  @"telephone":telephone,
                                  @"nickName":nickName
                                  } mutableCopy];
    
    [self GET:kHTTPDomnut parameters:[self generateParameter:[self getStringWithDict:dict] withMetho:kHTTPaddRelaPersonKey] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //编码(解决乱码问题)
        NSString * string=[[NSString alloc]initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dict=responseObject;
            NSString* code=dict[@"code"];
            NSString * mgs=dict[@"message"];
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

//  获取业主绑定的房信息
-(void)getBindHouseWithsessionId:(NSString *)sessionId success:(void (^)(BOOL, NSArray *, NSString *))success failse:(void (^)(BOOL, id))failse
{
    NSMutableDictionary * dict=[@{@"sessionId":sessionId
                                  } mutableCopy];
    
    [self GET:kHTTPDomnut parameters:[self generateParameter:[self getStringWithDict:dict] withMetho:kHTTPgetBindHouseKey] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dict=responseObject;
            NSString* code=dict[@"code"];
            NSString * mgs=dict[@"message"];
            if ([code isEqualToString:kSuccessCode]) {
                    NSArray * result=dict[@"result"];
                    NSLog(@"-----结果--------%@-----结果------",dict[@"result"]);
                    
                    __block NSMutableArray * tem=[NSMutableArray arrayWithCapacity:0];
                    [result enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop) {
                        
                        getBindHouse *notice=[[getBindHouse alloc] initWithDictionary:obj error:nil];
                         
                        [tem addObject:notice];
                    }];
                    
                    success(YES,tem,mgs);
                    
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

//  公告列表
-(void)getNoticeWithsessionId:(NSString *)sessionId  WithPage:(NSInteger)page andPageSize:(NSInteger)pageSize success:(void (^)(BOOL, NSArray *, NSString *))success failse:(void (^)(BOOL, id))failse
{
    if (page<=0) {
        page=kDefualtPage;
    }
    if (pageSize<10) {
        pageSize=kDefualtSize;
    }
    
    NSMutableDictionary * dict=[@{@"sessionId":sessionId,
                                  @"page":@(page),
                                  @"rows":@(pageSize)
                                 }mutableCopy];
    
    [self GET:kHTTPDomnut parameters:[self generateParameter:[self getStringWithDict:dict] withMetho:kHTTPgetNotice] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dict=responseObject;
            NSString* code=dict[@"code"];
            NSLog(@"-------------%@----",dict[@"code"]);
            NSString * mgs=dict[@"message"];
            if ([code isEqualToString:kSuccessCode]) {
                NSArray * result=dict[@"result"];
                NSLog(@"-----结果--------%@-----结果------",dict[@"result"]);

                __block NSMutableArray * tem=[NSMutableArray arrayWithCapacity:0];
                [result enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop) {
                    
               getNotice *notice=[[getNotice alloc] initWithDictionary:obj error:nil];                    
                    [tem addObject:notice];
                }];
                success(YES,tem,mgs);
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

//  开锁记录列表
-(void)lockLogWithSessionId:(NSString *)sessionId WithPage:(NSInteger)page andPageSize:(NSInteger)pageSize success:(void (^)(BOOL,  NSArray *, NSString *))success failse:(void (^)(BOOL, id))failse
{
    if (page<=0) {
        page=kDefualtPage;
    }
    if (pageSize<10) {
        pageSize=kDefualtSize;
    }
    
    NSMutableDictionary * dict=[@{@"sessionId":sessionId,
                                  @"page":@(page),
                                  @"rows":@(pageSize)
                                  } mutableCopy];
    
    [self GET:kHTTPDomnut parameters:[self generateParameter:[self getStringWithDict:dict] withMetho:kHTTPlockLogKey] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dict=responseObject;
            NSString* code=dict[@"code"];
            NSString * mgs=dict[@"message"];
            NSLog(@"------%@-------",dict[@"code"]);
            if ([code isEqualToString:kSuccessCode]) {
                
                NSArray * result=dict[@"result"];
                NSLog(@"****开锁记录*********%@***********",result);
                if (result.count==0) {
                    //[SVProgressHUD showWithStatus:@"暂无数据"];
                }
                __block NSMutableArray * tem=[NSMutableArray arrayWithCapacity:0];
                [result enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop)
                {
                    lockLog * lock=[[lockLog alloc] initWithDictionary:tem error:nil];
                }];
                
                success(YES,tem,mgs);
                
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


//  开锁记录
-(void)lockLogWithsessionId:(NSString *)sessionId startTime:(NSString *)startTime endTime:(NSString *)endTime WithPage:(NSInteger)page andPageSize:(NSInteger)pageSize success:(void (^)(BOOL,  NSArray *, NSString *))success failse:(void (^)(BOOL, id))failse
{
    if (page<=0) {
        page=kDefualtPage;
    }
    if (pageSize<10) {
        pageSize=kDefualtSize;
    }
    NSMutableDictionary * dict=[@{@"sessionId":sessionId,
                                  @"startTime":startTime,
                                  @"endTime":endTime,
                                  @"page":@(page),
                                  @"rows":@(pageSize)
                                  } mutableCopy];
    
    [self GET:kHTTPDomnut parameters:[self generateParameter:[self getStringWithDict:dict] withMetho:kHTTPlockLogKey] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dict=responseObject;
            NSString* code=dict[@"code"];
            NSString * mgs=dict[@"message"];
            NSLog(@"------%@-------",dict[@"code"]);
            if ([code isEqualToString:kSuccessCode]) {
                
                NSArray * result=dict[@"result"];
                NSLog(@"*************%@***********",result);
                if (result.count==0) {
                    //[SVProgressHUD showWithStatus:@"暂无数据"];
                }
                __block NSMutableArray * tem=[NSMutableArray arrayWithCapacity:0];
                [result enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop)
                 {
                     lockLog * lock=[[lockLog alloc] initWithDictionary:tem error:nil];
                 }];
                
                success(YES,tem,mgs);
                
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

//  修改密码
-(void)modifyPwdWithsessionId:(NSString *)sessionId newPwd:(NSString *)newPwd oldPwd:(NSString *)oldPwd success:(void (^)(BOOL, id, NSString *))success failse:(void (^)(BOOL, id))failse
{
    NSMutableDictionary * dict=[@{@"sessionId":sessionId,
                                  @"newPassword":newPwd,
                                  @"password":oldPwd
                                } mutableCopy];
    
    [self GET:kHTTPDomnut parameters:[self generateParameter:[self getStringWithDict:dict] withMetho:kHTTPmodifyPwd] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dict=responseObject;
            NSString* code=dict[@"code"];
            NSLog(@"-------------%@--------",dict[@"code"]);
            NSString * mgs=dict[@"message"];
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

//  保存开锁记录
-(void)savePwdWithsessionId:(NSString *)sessionId uid:(NSString *)uid result:(NSString *)result code:(NSString *)code success:(void (^)(BOOL, id, NSString *))success failse:(void (^)(BOOL, id))failse
{
    NSMutableDictionary * dict=[@{@"sessionId":sessionId,
                                  @"uid":uid,
                                  @"result":result,
                                  @"code":code
                                  } mutableCopy];
    
    [self GET:kHTTPDomnut parameters:[self generateParameter:[self getStringWithDict:dict] withMetho:kHTTPSavePwd] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dict=responseObject;
            NSString* code=dict[@"code"];
            NSString * mgs=dict[@"message"];
            if ([code isEqualToString:kSuccessCode]) {
                NSDictionary * result=dict[@"result"];
                if ([result isKindOfClass:[NSDictionary class]]) {
                    
                    //JFDetail* detail=[[JFDetail alloc] initWithDictionary:result error:nil];
                    
                    //success(YES,detail,mgs);
                    success(YES,nil,mgs);
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
            success(NO,nil,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failse(NO,kHTTPErrorAlter);
    }];
}

//  获取门禁权限1
-(void)validLockWithsessionId:(NSString *)sessionId uid:(NSString *)uid success:(void (^)(BOOL, NSArray *, NSString *))success failse:(void (^)(BOOL, id))failse
{
    NSMutableDictionary * dict=[@{@"sessionId":sessionId,
                                  @"uid":uid
                                  } mutableCopy];
    
    [self GET:kHTTPDomnut parameters:[self generateParameter:[self getStringWithDict:dict] withMetho:kHTTPvalidLock1] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dict=responseObject;
            NSString* code=dict[@"code"];
            NSLog(@"===%@===",code);
            NSString * mgs=dict[@"message"];
            if ([code isEqualToString:kSuccessCode]) {
                NSArray * result=dict[@"result"];
                NSLog(@"*******获取门禁权限******%@***********",result);
//                if (result.count==0) {
//                    [SVProgressHUD showWithStatus:@"暂无数据"];
//                }
                __block NSMutableArray * tem=[NSMutableArray arrayWithCapacity:0];
//                [result enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop)
//                 {
//                     //lockLog * lock=[[lockLog alloc] initWithDictionary:tem error:nil];
//                 }];
                
                success(YES,tem,mgs);
                
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

//  获取门禁权限2
-(void)validLockWithsessionId:(NSString *)sessionId  success:(void (^)(BOOL, NSArray *, NSString *))success failse:(void (^)(BOOL, id))failse
{
    NSMutableDictionary * dict=[@{@"sessionId":sessionId
                                  } mutableCopy];
    
    [self GET:kHTTPDomnut parameters:[self generateParameter:[self getStringWithDict:dict] withMetho:kHTTPvalidLock] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dict=responseObject;
            NSString* code=dict[@"code"];
            NSLog(@"===%@===",code);
            NSString * mgs=dict[@"message"];
            if ([code isEqualToString:kSuccessCode]) {
                NSArray * result=dict[@"result"];
                NSLog(@"*******获取门禁权限******%@***********",result);
                //                if (result.count==0) {
                //                    [SVProgressHUD showWithStatus:@"暂无数据"];
                //                }
                __block NSMutableArray * tem=[NSMutableArray arrayWithCapacity:0];
                //                [result enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop)
                //                 {
                //                     //lockLog * lock=[[lockLog alloc] initWithDictionary:tem error:nil];
                //                 }];
                
                success(YES,tem,mgs);
                
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



//  修改关系人
-(void)modifyRelaPersonWithsessionId:(NSString *)sessionId userId:(NSString *)userId relaType:(NSString *)relaType houseId:(NSString *)houseId telephone:(NSString *)telephone nickName:(NSString *)nickName success:(void (^)(BOOL, id, NSString *))success failse:(void (^)(BOOL, id))failse
{
    NSMutableDictionary * dict=[@{@"sessionId":sessionId,
                                  @"userId":userId,
                                  @"relaType":relaType,
                                  @"houseId":houseId,
                                  @"telephone":telephone,
                                  @"nickName":nickName
                                  } mutableCopy];
    
    [self GET:kHTTPDomnut parameters:[self generateParameter:[self getStringWithDict:dict] withMetho:kHTTPmodifyRelaPerson] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dict=responseObject;
            NSString* code=dict[@"code"];
            NSString * mgs=dict[@"message"];
            if ([code isEqualToString:kSuccessCode]) {
                NSDictionary * result=dict[@"result"];
                if ([result isKindOfClass:[NSDictionary class]]) {
                    
                    //JFDetail* detail=[[JFDetail alloc] initWithDictionary:result error:nil];
                    
                    //success(YES,detail,mgs);
                    success(YES,nil,mgs);
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
            success(NO,nil,nil);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failse(NO,kHTTPErrorAlter);
    }];
}

//  删除关系人
-(void)removeRelaPersonWithsessionId:(NSString *)sessionId userId:(NSString *)userId relaType:(NSString *)relaType houseId:(NSString *)houseId success:(void (^)(BOOL, id, NSString *))success failse:(void (^)(BOOL, id))failse
{
    NSMutableDictionary * dict=[@{@"sessionId":sessionId,
                                  @"userId":userId,
                                  @"relaType":relaType,
                                  @"houseId":houseId
                                  } mutableCopy];
    
    [self GET:kHTTPDomnut parameters:[self generateParameter:[self getStringWithDict:dict] withMetho:kHTTPremoveRelaPerson] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dict=responseObject;
            NSString* code=dict[@"code"];
            NSLog(@"-------------%@--------",dict[@"code"]);
            NSString * mgs=dict[@"message"];
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

@end
