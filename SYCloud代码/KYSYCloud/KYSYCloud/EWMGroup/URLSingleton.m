//
//  URLSingleton.m
//  ProgramAPP
//
//  Created by liuweidong on 15/10/14.
//  Copyright © 2015年 JuTeHui. All rights reserved.
//

#import "URLSingleton.h"

@implementation URLSingleton
+ (URLSingleton *)mainURLSingleton {
    static URLSingleton *singleton = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //内部代码只会执行一次
        singleton = [[URLSingleton alloc] init];
        
    });
    return singleton;
}

@end
