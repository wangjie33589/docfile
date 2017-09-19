//
//  repaireViewController.m
//  KYSYCloud
//
//  Created by sciyonSoft on 16/2/19.
//  Copyright © 2016年 sciyonSoft. All rights reserved.
//

#import "repaireViewController.h"

@interface repaireViewController (){
    NSDictionary *_fromDic;


}

@end

@implementation repaireViewController
-(id)initWithADic:(NSDictionary *)aDic
{
    self=[super init];
    if (self) {
        _fromDic=aDic;
    }
    
    return self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=_fromDic[@"MNAME"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
