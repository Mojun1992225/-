//
//  HTTPConfig.h
//
//  Created by gitBurning on 15/7/10.
//  Copyright (c) 2015年 ZhiAi. All rights reserved.
//

#ifndef wy_HTTPConfig_h
#define wy_HTTPConfig_h

#define kSuccessCode @"001"
#define kFailseCode  @"002"
#define kHTTPDomnut @"service"

#define kDefualtPage  1
#define kDefualtSize  10


#define kErrorAlter  @"数据错误"
#define kSuccessAlter @"获取成功"
#define kNotData      @"没有数据"
#define kNotMoreData  @"没有更多的数据了"

/**
 *  用户注册  1
 */
#define kHTTPregisterKey @"luanchso.wy.register"

/**
 *  用户登录(手机登录)  2
 */
#define kHTTPloginKey @"luanchso.wy.login"

/**
 *  用户登录(第三方登录)  3
 */
#define kHTTPthirdLoginKey @"luanchso.wy.thirdLogin"

/**
 *  业主绑定信息  4
 */
#define kHTTPgetBindKey @"luanchso.wy.getBind"

/**
 *  业主绑定  5
 */
#define kHTTPBindKey @"luanchso.wy.bind"

/**
 *  获取验证码  6
 */
#define kHTTPGetCodeKey @"luanchso.wy.getCode"

/**
 *  校验验证码  7
 */
#define kHTTPValidCodeKey @"luanchso.wy.validCode"

/**
 *  校验手机号  8
 */
#define kHTTPvalidPhoneKey @"luanchso.wy.validPhone"


/**
 *  忘记密码  9
 */
#define kHTTPforgetPwdKey @"luanchso.wy.forgetPwd"

/**
 *  个人信息  10
 */
#define kHTTPpersonalKey @"luanchso.wy.personal"

/**
 *  个人信息修改 11
 */
#define kHTTPmodifyPersonalKey @"luanchso.wy.modifyPersonal"

/**
 *  获取关系人  12
 */
#define kHTTPgetRelaPersonKey @"luanchso.wy.getRelaPerson"

/**
 *  添加关系人  13
 */
#define kHTTPaddRelaPersonKey @"luanchso.wy.addRelaPerson"

/**
 *  获取业主绑定的房信息 14
 */
#define kHTTPgetBindHouseKey @"luanchso.wy.getBindHouse"

/**
 *  首页banner获取  15
 */
#define kHTTPBanner @"luanchso.wy.getBanner"

/**
 *  公告列表  16
 */
#define kHTTPgetNotice @"luanchso.wy.getNotice"

/**
 *  开锁记录  17
 */
#define kHTTPlockLogKey @"luanchso.wy.lockLog"

/**
 *  修改密码  18
 */
#define kHTTPmodifyPwd @"luanchso.wy.modifyPwd"

/**
 *  保存开锁记录  19 （接口有问题）
 */
#define kHTTPSavePwd @"luanchso.wy.savePwd"

/**
 *  获取门禁权限  20
 */
#define kHTTPvalidLock @"luanchso.wy.getAccessControl"
#define kHTTPvalidLock1 @"luanchso.wy.validLock"

/**
 *  修改关系人  21
 */
#define kHTTPmodifyRelaPerson @"luanchso.wy.modifyRelaPerson"

/**
 *  删除关系人  22
 */
#define kHTTPremoveRelaPerson @"luanchso.wy.removeRelaPerson"

#endif
