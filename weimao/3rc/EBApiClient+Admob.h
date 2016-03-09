//
//  EBApiClient+Admob.h
//  zhaoshangdai
//
//  Created by gitBurning on 15/7/10.
//  Copyright (c) 2015年 ZhiAi. All rights reserved.
//

#import "EBApiClient.h"
#import "Admob.h"
@interface EBApiClient (Admob)

//  首页banner获取
-(void)quaryAdmobWithOther:(id)other  success:(void(^)(BOOL success,NSArray* other,NSString* alter))success failse:(void(^)(BOOL failse,id other))failse;

//  业主绑定信息
-(void)getBindWithsessionId:(NSString *)sessionId  success:(void(^)(BOOL success,NSArray *,NSString* alter))success failse:(void(^)(BOOL failse,id other))failse;


//  业主绑定
-(void)bindWithsessionId:(NSString *)sessionId  houseId:(NSString *)houseId relaType:(NSString *)relaType success:(void(^)(BOOL success,NSString* alter))success failse:(void(^)(BOOL failse,id other))failse;


//  个人信息
-(void)personalWithsessionId:(NSString *)sessionId  success:(void(^)(BOOL success,id,NSString* alter))success failse:(void(^)(BOOL failse,id other))failse;

//  个人信息修改
-(void)modifyPersonalWithsessionId:(NSString *)sessionId   nickName:(NSString *)nickName signature:(NSString *)signature pesionImg:(NSString *)pesionImg success:(void (^)(BOOL,id, NSString *))success failse:(void (^)(BOOL, id))failse;

//  获取关系人  关系类型 10、业主 20、租户 30、亲属
-(void)getRelaPersonWithsessionId:(NSString *)sessionId   WithPage:(NSInteger)page andPageSize:(NSInteger)pageSize relaType:(NSString *)relaType success:(void (^)(BOOL,NSArray *, NSString *))success failse:(void (^)(BOOL, id))failse;

//  添加关系人
-(void)addRelaPersonWithsessionId:(NSString *)sessionId   relaType:(NSString *)relaType houseId:(NSString *)houseId telephone:(NSString *)telephone nickName:(NSString *)nickName success:(void (^)(BOOL,id, NSString *))success failse:(void (^)(BOOL, id))failse;

//  获取业主绑定的房信息
-(void)getBindHouseWithsessionId:(NSString *)sessionId  success:(void (^)(BOOL,NSArray *, NSString *))success failse:(void (^)(BOOL, id))failse;

//  公告列表
-(void)getNoticeWithsessionId:(NSString *)sessionId  WithPage:(NSInteger)page andPageSize:(NSInteger)pageSize success:(void (^)(BOOL, NSArray *, NSString *))success failse:(void (^)(BOOL, id))failse;

//  开锁记录列表
-(void)lockLogWithSessionId:(NSString *)sessionId WithPage:(NSInteger)page andPageSize:(NSInteger)pageSize  success:(void (^)(BOOL, NSArray *, NSString *))success failse:(void (^)(BOOL, id))failse;

//  开锁记录
-(void)lockLogWithsessionId:(NSString *)sessionId    startTime:(NSString *)startTime endTime:(NSString *)endTime  WithPage:(NSInteger)page andPageSize:(NSInteger)pageSize  success:(void (^)(BOOL, NSArray *, NSString *))success failse:(void (^)(BOOL, id))failse;

//  修改密码
-(void)modifyPwdWithsessionId:(NSString *)sessionId     newPwd:(NSString *)newPwd oldPwd:(NSString *)oldPwd success:(void (^)(BOOL,id, NSString *))success failse:(void (^)(BOOL, id))failse;

//  保存开锁记录
-(void)savePwdWithsessionId:(NSString *)sessionId    uid:(NSString *)uid result:(NSString *)result code:(NSString *)code success:(void (^)(BOOL,id, NSString *))success failse:(void (^)(BOOL, id))failse;

//  获取门禁权限1
-(void)validLockWithsessionId:(NSString *)sessionId   uid:(NSString *)uid  success:(void (^)(BOOL,NSArray *, NSString *))success failse:(void (^)(BOOL, id))failse;

//  获取门禁权限2
-(void)validLockWithsessionId:(NSString *)sessionId   success:(void (^)(BOOL,NSArray *, NSString *))success failse:(void (^)(BOOL, id))failse;

//  修改关系人
-(void)modifyRelaPersonWithsessionId:(NSString *)sessionId   userId:(NSString *)userId relaType:(NSString *)relaType houseId:(NSString *)houseId telephone:(NSString *)telephone nickName:(NSString *)nickName success:(void (^)(BOOL,id, NSString *))success failse:(void (^)(BOOL, id))failse;

//  删除关系人
-(void)removeRelaPersonWithsessionId:(NSString *)sessionId   userId:(NSString *)userId relaType:(NSString *)relaType houseId:(NSString *)houseId  success:(void (^)(BOOL,id, NSString *))success failse:(void (^)(BOOL, id))failse;




@end

