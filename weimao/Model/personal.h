//
//  personal.h
//  chuanke
//
//  Created by mj on 15/12/7.
//  Copyright © 2015年 jinzelu. All rights reserved.
//

#import "JSONModel.h"

@interface personal : JSONModel
//个人信息

/**
 *  用户标志
 */
@property(copy,nonatomic) NSString* userId;

/**
 *  手机号码
 */
@property(copy,nonatomic) NSString* telephone;

/**
 *  昵称
 */
@property(copy,nonatomic) NSString* nickName;

/**
 * 用户描述
 */
@property(copy,nonatomic) NSString * desc;

/**
 *   用户签名
 */
@property(copy,nonatomic) NSString* signature;

/**
 *  用户头像
 */
@property(copy,nonatomic) NSString* pesionImg;
@end
