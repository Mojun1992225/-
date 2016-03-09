//
//  EBHttpRequest.m
//  E-beans
//
//  Created by jingbaoying on 15/5/9.
//  Copyright (c) 2015年 aa. All rights reserved.
//

#import "EBHttpRequest.h"

#import "EBApiClient.h"

typedef  void (^SuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef  void (^FailureBlock)(AFHTTPRequestOperation *operation, NSError *error);


@implementation EBHttpRequest

- (instancetype)initWithHandler:(id<EBHttpRequestDelegate>)delegate
{
    if (self = [self init])  _delegate = delegate ;
    return self ;
}

- (void)getPath:(NSString *)path parameters:(NSDictionary *)parameters
{
    EBApiClient *cliet = [EBApiClient sharedEBApiClient];
    __weak __typeof(self) weakSelf = self ;
    [cliet GET:path parameters:path success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self getSuccessBlock:weakSelf];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self getFailureBlock:weakSelf];
    }];
    
}
- (void)postPath:(NSString *)path parameters:(NSDictionary *)parameters
{
    EBApiClient *client = [EBApiClient sharedEBApiClient];
    __weak __typeof(self) weakSelf = self;
    [client POST:path parameters:parameters
         success:[self getSuccessBlock:weakSelf]
         failure:[self getFailureBlock:weakSelf]
     ];

}

- (SuccessBlock)getSuccessBlock:(EBHttpRequest *)weakSelf
{
    return _Block_copy(^(AFHTTPRequestOperation *operation , id responseObhect){
        [weakSelf.delegate  dataDidLoad:operation data:responseObhect];
    });
}

- (FailureBlock)getFailureBlock:(EBHttpRequest*)weakSelf
{
    return _Block_copy(^(AFHTTPRequestOperation *operation, NSError *error) {
        [weakSelf.delegate dataError:weakSelf error:error];
    });
}

@end
















