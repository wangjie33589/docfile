//
//  authorVC.m
//  KYSYCloud
//
//  Created by sciyonSoft on 16/3/22.
//  Copyright © 2016年 sciyonSoft. All rights reserved.
//

#import "authorVC.h"

@interface authorVC ()<UITextFieldDelegate>{

    int i;
    NSTimer *timer;
    NSDictionary *_fromDic;
   NSDictionary *  _XMLDic;
    NSArray *_showArray;
    int type;

}
@end

@implementation authorVC
-(id)initWithDic:(NSDictionary *)dic{
    self=[super init];
    if (self) {
        _fromDic=dic;
        
        NSLog(@"_dromdic=======%@",_fromDic);
        
    }
    
    
    return self;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    i=60;
    self.title=@"在线授权";
    type=0;
    self.pwdText.delegate=self;
    self.yzmTxt.delegate=self;
    self.dateTxt.delegate=self;
    self.pwdText.returnKeyType= UIReturnKeyDone;
    self.dateTxt.returnKeyType=UIReturnKeyDone;
    self.dateTxt.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    self.yzmTxt.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    self.yzmTxt.returnKeyType=UIReturnKeyDone;

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
[textField resignFirstResponder];
return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}


- (IBAction)changeLeftOrRight:(UIButton *)sender {
    UIAlertController *controler =[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action =[UIAlertAction actionWithTitle:@"左笼" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.changeBtn setTitle:@"左笼" forState:0];
        type=0;
        
    }];
    UIAlertAction *rightAction =[UIAlertAction actionWithTitle:@"右笼" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
               [self.changeBtn setTitle:@"右笼" forState:0];
        type=1;
        
    }];
    [controler addAction:action];
    [controler addAction:rightAction];
    [self presentViewController:controler animated:YES completion:nil];
    
    
}

- (IBAction)autorBtnCilck:(id)sender {
   
    [self requestControlData];
    
    
    
}
-(void)second_1{
   
    [self.yzmBtn setTitle:[NSString stringWithFormat:@"(%d)秒后重新获取",i] forState:0];    i=i-1;
   
    if (i==0) {
        [timer invalidate];
        timer=nil;
    
       self.yzmBtn.userInteractionEnabled=YES;
        self.yzmBtn.alpha=1;
        //isClick=!isClick;
        i=60;
        [self.yzmBtn setTitle:@"获取验证码" forState:0];
    }

}

- (IBAction)yzmBtnClick:(id)sender {
    
    self.yzmBtn.userInteractionEnabled=NO;
    self.yzmBtn.alpha=0.5;
    
    timer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(second_1) userInfo:nil repeats:YES];
    [self requestYzm];
    
}





-(void)requestYzm{
    
    if ([self.dateTxt.text  isEqual:@""]) {
        [SVProgressHUD showErrorWithStatus:@"授权日期不能为空"];
        return;
    }
    if ([self.pwdText.text  isEqual:@""]) {
        [SVProgressHUD showErrorWithStatus:@"登陆密码不能为空"];
        return;
    }

        NSString *string =[NSString stringWithFormat:@"<Data><Action>GETVTCODE</Action><USERID>%@</USERID><PWD>%@</PWD><SIM>%@</SIM></Data>",USER_NAME,self.pwdText.text,SIM_CODE];
        MyRequest *manger =[MyRequest requestWithURL:[NSString stringWithFormat:@"%@%@",HTTPIP,SERVER_URL] withString:string];
        manger.backSuccess=^void(NSDictionary *dictt){
            
            
            if ((NSObject*)[dictt objectForKey:@"ERROR"]==[NSNull null]) {
                [[NSUserDefaults standardUserDefaults]setObject:dictt[@"CUSTOMERINFO"] forKey:@"YZM"];
                
            }else{
                NSLog(@"11111%@",[dictt objectForKey:@"CUSTOMERINFO"]);
                [timer invalidate];
                self.yzmBtn.userInteractionEnabled=YES;
                self.yzmBtn.alpha=1;
                [self.yzmBtn setTitle:@"获取验证码" forState:0];
                timer=nil;
                [SVProgressHUD showErrorWithStatus:[dictt objectForKey:@"ERROR"]];
            }
            
};

}

-(void)requestControlData{
    NSString *xmlString=[NSString stringWithFormat:@"<Data><Action>GETDEVICECTLS</Action><USERID>%@</USERID><PWD>%@</PWD><DGUID>%@</DGUID></Data>",USER_NAME,PASSWORD,_fromDic[@"DGUID"]];
    MyRequest *manger =[MyRequest requestWithURL:[NSString stringWithFormat:@"%@%@",HTTPIP,SERVER_URL] withString:xmlString];
    manger.backSuccess=^void(NSDictionary *dictt){
        
        if ((NSObject*)dictt[@"ERROR"]==[NSNull null] ) {
            _XMLDic=[NSDictionary dictionaryWithXMLString:dictt[@"XML"]];
            _showArray=_XMLDic[@"R"];
            [CommonTool saveCooiker];
            NSLog(@"_showarray=======%@",_showArray);
            [self autorequestwitharr:_showArray];
        }else{
            
            [SVProgressHUD showErrorWithStatus:dictt[@"ERROR"]];
        }
    };
}



-(void)autorequestwitharr:(NSArray*)array{


   
    if ([self.dateTxt.text  isEqual:@""]) {
        [SVProgressHUD showErrorWithStatus:@"授权日期不能为空"];
        return;
    }
    if ([self.pwdText.text  isEqual:@""]) {
        [SVProgressHUD showErrorWithStatus:@"登陆密码不能为空"];
        return;
    }
   [SVProgressHUD showWithStatus:@"正在授权..."];

    NSString *xmlString=[NSString stringWithFormat:@"<Data><Action>EXECMD</Action><USERID>%@</USERID><PWD>%@</PWD><TIME>%d</TIME><SIM>%@</SIM><VTCODE>%@</VTCODE><DGUID>%@</DGUID><DCGUID>%@</DCGUID><CMDCODE>AUONLINE</CMDCODE><CMDPARA><AUDATE>%@</AUDATE></CMDPARA></Data>",USER_NAME,self.pwdText.text,i-1,SIM_CODE,self.yzmTxt.text,_showArray[type][@"DGUID"],_showArray[type][@"DCGUID"],self.dateTxt.text];
    MyRequest *manger =[MyRequest requestWithURL:[NSString stringWithFormat:@"%@%@",HTTPIP,SERVER_URL] withString:xmlString];
    manger.backSuccess=^void(NSDictionary *dictt){
        [SVProgressHUD dismiss];
        
        if ((NSObject*)dictt[@"ERROR"]==[NSNull null] ) {
            [SVProgressHUD showSuccessWithStatus:@"授权成功"];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:dictt[@"ERROR"]];
        }
      };
}


@end
