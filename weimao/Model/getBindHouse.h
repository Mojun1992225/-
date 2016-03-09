//
//  getBindHouse.h
//  chuanke
//
//  Created by mj on 15/12/7.
//  Copyright © 2015年 jinzelu. All rights reserved.
//

#import "JSONModel.h"

@interface getBindHouse : JSONModel

//获取业主绑定的房信息

/**
 *  房标志
 */
@property(copy,nonatomic) NSString* houseId;

/**
 *  房名称
 */
@property(copy,nonatomic) NSString* name;

/**
 *  房编号
 */
@property(copy,nonatomic) NSString* code;


@end
