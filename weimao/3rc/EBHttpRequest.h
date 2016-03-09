//
//  EBHttpRequest.h
//  E-beans
//
//  Created by jingbaoying on 15/5/9.
//  Copyright (c) 2015年 aa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EBApiClient.h"
@class EBHttpRequest;

@protocol EBHttpRequestDelegate  <NSObject>

@required
/**
 *  加载数据成功，返回正确
 */
- (void)dataDidLoad:(id)sender data:(id)data;
/**
 *  网络异常
 */
- (void)dataError:(id)sender error:(NSError*)error;

@end


@interface EBHttpRequest : NSObject

@property (nonatomic, readonly, strong) id<EBHttpRequestDelegate> delegate;

- (id)initWithHandler:(id<EBHttpRequestDelegate>)delegate;


/**
 *  get请求
 *
 *  @param path       访问路径
 *  @param parameters 所需参数
 */
- (void)getPath:(NSString*)path parameters:(NSDictionary*)parameters;
/**
 *  post请求
 *
 *  @param path       路径
 *  @param parameters 参数
 */
- (void)postPath:(NSString*)path parameters:(NSDictionary*)parameters;
@end

















