//
//  URLSingleton.h
//  ProgramAPP
//
//  Created by liuweidong on 15/10/14.
//  Copyright © 2015年 JuTeHui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLSingleton : NSObject
@property (nonatomic, strong) NSString *urlString;
+ (URLSingleton *)mainURLSingleton;
@end
