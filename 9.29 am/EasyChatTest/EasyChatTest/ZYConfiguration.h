//
//  ZYConfiguration.h
//  EasyChatTest
//
//  Created by laosun on 15/9/25.
//  Copyright (c) 2015年 zhiyou. All rights reserved.
//

/*********************  URL *************************/

#define SERVER_IP  @"http://localhost:8080"

//登录 注册使用的URI
#define COMMON_URI @"st/s"
#define NEWS_LIST_URI @"st/news/news_list.json"


/*********************  Macro *************************/


#define USER_NAME_KEY   @"userNameKey"
#define PASSWORD_KEY    @"passwordKey"
#define NICKNAME_KEY    @"nicknameKey"
#define EMAIL_KEY       @"emailKey"



/*********************  helpers *************************/




#define ALERT_SHOW(msg) UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];\
[alertView show];\
[alertView release];

#define ALERT_DELEGATE_SHOW(msg,dlg) UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:dlg cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];\
[alertView show];\
[alertView release];


#define ALERT_DELEGATE_TAG_SHOW(msg,dlg,aTag) UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:dlg cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];\
alertView.tag = aTag;\
[alertView show];\
[alertView release];

/*********************  storage data *************************/

#define ACCESS_TOKEN_KEY @"accessTokenKey"
#define EXPIRES_DATE_KEY @"expiresDateKey"


/*********************  other *************************/


#define USER_DEFALUTS [NSUserDefaults standardUserDefaults]










