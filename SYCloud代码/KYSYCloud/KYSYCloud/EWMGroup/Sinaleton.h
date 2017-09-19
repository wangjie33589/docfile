//
//  Sinaleton.h
//  ProgramAPP
//
//  Created by liuweidong on 15/10/5.
//  Copyright (c) 2015年 JuTeHui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sinaleton : NSObject
@property (nonatomic, strong) NSString *urlAddress;

+ (Sinaleton *)defaultSinaleton;
@end
