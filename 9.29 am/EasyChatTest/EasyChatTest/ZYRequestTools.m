//
//  ZYRequestTools.m
//  EasyChatTest
//
//  Created by laosun on 15/9/25.
//  Copyright (c) 2015年 zhiyou. All rights reserved.
//

#import "ZYRequestTools.h"
#import "ASIFormDataRequest.h"
#import "ZYConfiguration.h"

@implementation ZYRequestTools

+ (void)registerRequest:(NSDictionary *)parameterDic  withCompletionBlock:(void(^)(NSDictionary *resultDictionary))completionBlock
{
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",SERVER_IP,COMMON_URI]]];
    
    
    
    [request addPostValue:@"ST_R" forKey:@"command"];
    
    [request addPostValue:parameterDic[USER_NAME_KEY] forKey:@"name"];
    [request addPostValue:parameterDic[PASSWORD_KEY] forKey:@"psw"];
    [request addPostValue:parameterDic[NICKNAME_KEY] forKey:@"nickname"];
    [request addPostValue:parameterDic[EMAIL_KEY] forKey:@"email"];
    
    
    [request setCompletionBlock:^
    {
        
        NSLog(@">>>>> %@",request.responseString);
        
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
        
//      回调
        completionBlock(dictionary);
        
        
    }];
    
    [request startAsynchronous];
}





+ (void)loginRequest:(NSDictionary *)parameterDic  withCompletionBlock:(void(^)(NSDictionary *resultDictionary))completionBlock
{
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",SERVER_IP,COMMON_URI]]];
    
    
    
    [request addPostValue:@"ST_L" forKey:@"command"];
    
    [request addPostValue:parameterDic[USER_NAME_KEY] forKey:@"name"];
    [request addPostValue:parameterDic[PASSWORD_KEY] forKey:@"psw"];
  
    
    
    [request setCompletionBlock:^
     {
         
         NSLog(@">>>>> %@",request.responseString);
         
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
         
         //      回调
         completionBlock(dictionary);
         
         
     }];
    
    [request startAsynchronous];
}

//优化：把登录和注册的请求封装成一个方法？
// 自定义enum


+ (void)loginAndRegisterRequest:(ZYRequestType)requestType  withParameters:(NSDictionary *)parameterDic  withCompletionBlock:(void(^)(NSDictionary *resultDictionary))completionBlock
{
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",SERVER_IP,COMMON_URI]]];
    
    
    switch (requestType)
    {
//         注册
        case ZYRequestTypeRegister:
        {
            [request addPostValue:@"ST_R" forKey:@"command"];
           
            [request addPostValue:parameterDic[NICKNAME_KEY] forKey:@"nickname"];
            [request addPostValue:parameterDic[EMAIL_KEY] forKey:@"email"];
        }
            break;
            
//         登录
        case ZYRequestTypeLogin:
        {
            [request addPostValue:@"ST_L" forKey:@"command"];
        }
            break;
            
        default:
            break;
    }
    
//    注册和登录都需要用到用户名和密码，所以可以提取到switch case 外面。
    [request addPostValue:parameterDic[USER_NAME_KEY] forKey:@"name"];
    [request addPostValue:parameterDic[PASSWORD_KEY] forKey:@"psw"];
    
    
    [request setCompletionBlock:^
     {
         
         NSLog(@">>>>> %@",request.responseString);
         
         NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
         
         //      回调
         completionBlock(dictionary);
         
         
     }];
    
    [request startAsynchronous];
}

+ (void)loginOutWithCompletionBlock:(void(^)(NSDictionary *resultDic))resultBlock
{
    
    
    
    __block  ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",SERVER_IP,COMMON_URI]]];
    
    [request setPostValue:@"ST_LO" forKey:@"command"];
    
    [request setPostValue:[USER_DEFALUTS objectForKey:ACCESS_TOKEN_KEY] forKey:@"access_token"];
    
    
    [request setCompletionBlock:^
     {
         
        
         //      解析
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
         
         //      回传给loginVC
         resultBlock(dic);
         
     }];
    [request startAsynchronous];
    
}
+ (void)requestNewsList:(ResultBlock)resultBlock
{
    __block  ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",SERVER_IP,NEWS_LIST_URI]]];
    
    [request setCompletionBlock:^
     {
         
         
         //      解析
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
         
         //      回传
         resultBlock(dic);
         
     }];
    [request startAsynchronous];
}



@end
