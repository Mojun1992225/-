//
//  getNotice.h
//  chuanke
//
//  Created by mj on 15/12/7.
//  Copyright © 2015年 jinzelu. All rights reserved.
//

#import "JSONModel.h"

@interface getNotice : JSONModel
//公告列表

/**
 *  唯一标志
 */
@property(copy,nonatomic) NSString* id;

/**
 *  标题
 */
@property(copy,nonatomic) NSString* title;

/**
 *  公告类型contentSimple
 */
@property(copy,nonatomic) NSString* type;

@property(copy,nonatomic) NSString* contentSimple;

/**
 *  公告类型名称
 1、小区公共 2、系统公告 3、其他公共
 */
@property(copy,nonatomic) NSString * typeName;

/**
 *   公告内容
 */
@property(copy,nonatomic) NSString* content;

/**
 *  公告紧急程度
 */
@property(copy,nonatomic) NSString* level;

/**
 *  物业名称
 */
@property(copy,nonatomic) NSString* property_name;

/**
 *  发布时间
 */
@property(copy,nonatomic) NSString * create_time;

/**
 *  附件（图片）
 */
@property(copy,nonatomic) NSString* accessory;

/**
 *  物业Logo图片地址
 */
@property(copy,nonatomic) NSString* logo;


@end
