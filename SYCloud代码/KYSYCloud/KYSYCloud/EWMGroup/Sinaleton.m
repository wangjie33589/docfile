//
//  Sinaleton.m
//  ProgramAPP
//
//  Created by liuweidong on 15/10/5.
//  Copyright (c) 2015年 JuTeHui. All rights reserved.
//

#import "Sinaleton.h"

@implementation Sinaleton
+ (Sinaleton *)defaultSinaleton {
    static Sinaleton *singleton = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //内部代码只会执行一次
        singleton = [[Sinaleton alloc] init];
        
    });
    return singleton;
}


@end
