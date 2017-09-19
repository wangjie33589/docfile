//
//  RealWatchController.m
//  KYSYCloud
//
//  Created by sciyonSoft on 16/3/1.
//  Copyright © 2016年 sciyonSoft. All rights reserved.
//

#import "RealWatchController.h"
#import "ReanWathcell.h"

@interface RealWatchController ()<UITableViewDataSource,UITableViewDelegate>{
    NSDictionary *_showDic;
    NSDictionary * _XMLDic;
    NSArray *_showArray;
   NSDictionary*_tableViewDic;
    NSArray *_tableViewArray;
    NSArray *_tableTitleArray;
    NSTimer *timer;

}

@end

@implementation RealWatchController
-(id)initWithDic:(NSDictionary *)aDic{
    self=[super init];
    if (self) {
             _showDic=aDic;
        
    }
    return self;


}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestControlData];
    self.myTable.dataSource=self;
    self.myTable.delegate=self;
    self.myTable.rowHeight=20;
    [self.myTable registerNib:[UINib nibWithNibName:@"ReanWathcell" bundle:nil] forCellReuseIdentifier:@"CELL"];
    timer =[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(second_2) userInfo:nil repeats:YES];
}
-(void)second_2{
    [self requestControlData];
}
-(void)viewDidAppear:(BOOL)animated{
    [timer invalidate];
    
}

-(void)requestControlData{
    NSString *xmlString=[NSString stringWithFormat:@"<Data><Action>GETDEVICECTLS</Action><USERID>%@</USERID><PWD>%@</PWD><DGUID>%@</DGUID></Data>",USER_NAME,PASSWORD,_showDic[@"DGUID"]];
    MyRequest *manger =[MyRequest requestWithURL:[NSString stringWithFormat:@"%@%@",HTTPIP,SERVER_URL] withString:xmlString];
    manger.backSuccess=^void(NSDictionary *dictt){
        
        if ((NSObject*)dictt[@"ERROR"]==[NSNull null] ) {
           _XMLDic=[NSDictionary dictionaryWithXMLString:dictt[@"XML"]];
           _showArray=_XMLDic[@"R"];
            [self initSegment];
            }else{
            
            [SVProgressHUD showErrorWithStatus:dictt[@"ERROR"]];
        }
      };
 }
-(void)initSegment{
    
    for (int i=0;i<_showArray.count;i++) {
      [ segent setTitle:_showArray[i][@"CONTRONAME"] forSegmentAtIndex:i];
        segent.selectedSegmentIndex=0;
        [segent addTarget:self action:@selector(changeIndex:) forControlEvents:UIControlEventValueChanged];
       }
    
    [self requestTableShowData];
 }

-(void)changeIndex:(UISegmentedControl*)seg{
    [self requestTableShowData];
 }


-(void)requestTableShowData{
   
    NSString *xmlString=[NSString stringWithFormat:@"<Data><Action>GETREALDATA</Action><USERID>%@</USERID><PWD>%@</PWD><DGUID>%@</DGUID><DCGUID>%@</DCGUID></Data>",USER_NAME,PASSWORD,_showArray[segent.selectedSegmentIndex][@"DGUID"],_showArray[segent.selectedSegmentIndex][@"DCGUID"]];
    MyRequest *manger =[MyRequest requestWithURL:[NSString stringWithFormat:@"%@%@",HTTPIP,SERVER_URL] withString:xmlString];
    manger.backSuccess=^void(NSDictionary *dictt){
        [SVProgressHUD dismiss];
        
        if ((NSObject*)dictt[@"ERROR"]==[NSNull null] ) {
            _tableViewDic=[NSDictionary dictionaryWithXMLString:dictt[@"XML"]];
            _tableViewArray=_tableViewDic[@"R"];
                     
                 [self.myTable reloadData];
            
        }else{
            
            [SVProgressHUD showErrorWithStatus:dictt[@"ERROR"]];
        }
     };
}


#pragma mark 表代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _tableViewArray.count;


}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReanWathcell *cell =[tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    cell.label.text=_tableViewArray[indexPath.row][@"TAGDESC"];
    cell.labelTwo.text=_tableViewArray[indexPath.row][@"VALUE"];
    return cell;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
