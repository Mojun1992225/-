//
//  lockLog.h
//  chuanke
//
//  Created by mj on 15/12/7.
//  Copyright © 2015年 jinzelu. All rights reserved.
//

#import "JSONModel.h"

@interface lockLog : JSONModel

//开锁记录

/**
 *   锁名称
 */
@property(copy,nonatomic) NSString* lockName;

/**
 *  开锁方式
 */
@property(copy,nonatomic) NSString* type;

/**
 *  开锁时间
 */
@property(copy,nonatomic) NSString* create_time;

/**
 *  开锁记录照片
 */
@property(copy,nonatomic) NSString * Images;

@end
