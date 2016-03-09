//
//  getRelaPerson.h
//  chuanke
//
//  Created by mj on 15/12/7.
//  Copyright © 2015年 jinzelu. All rights reserved.
//

#import "JSONModel.h"

@interface getRelaPerson : JSONModel

//获取关系人

/**
 *  用户标志
 */
@property(copy,nonatomic) NSString* userId;
@property(copy,nonatomic) NSString* houseId;


@property(copy,nonatomic) NSString* houseCode;
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
