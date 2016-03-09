//
//  getBind.h
//  chuanke
//
//  Created by mj on 15/12/7.
//  Copyright © 2015年 jinzelu. All rights reserved.
//

#import "JSONModel.h"

@interface getBind : JSONModel
//业主绑定信息

/**x
 *  小区标志
 */
@property(copy,nonatomic) NSString* id;

/**
 *  小区名称
 */
@property(copy,nonatomic) NSString* name;

/**
 *  小区地址
 */
@property(copy,nonatomic) NSString* address;

//--------------------------------------------------------------------

//房list

/**
 *   房标志
 */
@property(copy,nonatomic) NSString* houseId;

/**
 *  房编号 14#1203
 */
@property(copy,nonatomic) NSString* houseCode;
@property(copy,nonatomic) NSString* houseName;
/**
 *  10、业主 20、租户 30、亲属
 */
@property(copy,nonatomic) NSString* relaType;

@end
