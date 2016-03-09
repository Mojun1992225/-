//
//  login_third.h
//  chuanke
//
//  Created by mj on 15/12/7.
//  Copyright © 2015年 jinzelu. All rights reserved.
//

#import "JSONModel.h"

@interface login_third : JSONModel
//用户登录(第三方)

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

@end
