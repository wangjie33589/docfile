//
//  ZYRequestTools.h
//  EasyChatTest
//
//  Created by laosun on 15/9/25.
//  Copyright (c) 2015年 zhiyou. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^ResultBlock)(NSDictionary *resultDic);


//custom enum  
typedef NS_ENUM(NSInteger, ZYRequestType)
{
    ZYRequestTypeRegister = 0,
    ZYRequestTypeLogin,
};



@interface ZYRequestTools : NSObject

//注册请求
+ (void)registerRequest:(NSDictionary *)parameterDic  withCompletionBlock:(void(^)(NSDictionary *resultDictionary))completionBlock;

//登录
+ (void)loginRequest:(NSDictionary *)parameterDic  withCompletionBlock:(void(^)(NSDictionary *resultDictionary))completionBlock;


//注册登录集成为一个方法。
+ (void)loginAndRegisterRequest:(ZYRequestType)requestType  withParameters:(NSDictionary *)parameterDic  withCompletionBlock:(void(^)(NSDictionary *resultDictionary))completionBlock;

//注销登录
+ (void)loginOutWithCompletionBlock:(void(^)(NSDictionary *resultDic))resultBlock;

//请求新闻列表
+ (void)requestNewsList:(ResultBlock)resultBlock;


@end


//@interface Laosun : NSObject
//{
//    int _age;
//}
//
//@end








