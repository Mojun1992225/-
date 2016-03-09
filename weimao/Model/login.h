//
//  login.h
//  chuanke
//
//  Created by mj on 15/12/7.
//  Copyright © 2015年 jinzelu. All rights reserved.
//

#import "JSONModel.h"

@interface login : JSONModel
//用户注册

/**
 *  手机号
 */
@property(copy,nonatomic) NSString* telephone;

/**
 *  用户唯一标志
 */
@property(copy,nonatomic) NSString* userId;

/**
 *  登录标志
 */
@property(copy,nonatomic) NSString* sessionId;

/**
 *  登录类型 11、手机号登录 12、第三方登录
 */
@property(copy,nonatomic) NSString* type;


@end
