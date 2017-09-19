//
//  ZYNewsViewController.m
//  EasyChatTest
//
//  Created by laosun on 15/9/28.
//  Copyright (c) 2015年 zhiyou. All rights reserved.
//

#import "ZYNewsViewController.h"

#import "ZYNewsListImageObj.h"
#import "ZYNewsListObj.h"

@interface ZYNewsViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (retain, nonatomic) IBOutlet UITableView *newsTable;

@property (nonatomic ,retain)NSArray *dataArray;


@end

@implementation ZYNewsViewController


NSString *const newsCellIdentifier = @"newsCell";

#pragma mark - Request

- (void)requestNewsListInfo
{
    [ZYRequestTools requestNewsList:^(NSDictionary *resultDic) {
        NSLog(@"get news list---%@",resultDic);
        
//      封装对象--》NSArray，刷新表。
//      1 Model类
//      2 Custom cell 2种
//      3 tableView reload data
        
        
        NSArray *newsListArray = resultDic[@"news_list"];
        
//      存放model对象
        NSMutableArray *newsObjArray = [NSMutableArray arrayWithCapacity:0];
        
        for (NSDictionary *dictionary in newsListArray)
        {
            ZYNewsListObj *newsObj = [[ZYNewsListObj alloc] init];
            newsObj.newsTitle = dictionary[@"news_title"];
            newsObj.newsIntro = dictionary[@"intro"];
            newsObj.newsSource = dictionary[@"source"];
            newsObj.newsSourceURLString = dictionary[@"source_url"];
        
            
//          存放新闻列表中每一个新闻对应的图片
//          1 有没有新闻图片
//          2 如果有，则取出每一个图片对应的小字典，封装成ZYNewsListImageObj对象
//          3 封装之后放置到新的array中，再讲数组赋值给obj.newsImagesArray
            
            
//          取出图片们对应的数组
            NSArray *imgArray = dictionary[@"images"];
            
//          如果数组中有图片
            if ([imgArray count] > 0)
            {
                
//              创建可变数组将来用于存放ZYNewsListImageObj对象们。
                NSMutableArray *imgObjArray = [NSMutableArray arrayWithCapacity:0];
                
//              遍历 数组。
                for (NSDictionary *imgDictionary in imgArray)
                {
                    
//                   从imgDictionary中一一取值，赋给对象的属性。
                    ZYNewsListImageObj *imageObj = [[ZYNewsListImageObj alloc] init];
                    imageObj.imgURLString = imgDictionary[@"url"];
                    imageObj.width = [imgDictionary[@"width"] floatValue];
                    imageObj.height = [imgDictionary[@"height"] floatValue];
                    
//                   最终把封装好的对象存放到图片数组中。
                    [imgObjArray addObject:imageObj];
                    [imageObj release];
                }
                
//              经过上面的for循环，imgArray中存在多少小字典就封装成多少newListImageObj对象,然后将封装好的保存了多个newListImageObj对象的数组赋值给大newsObj的属性。这样将来就可以通过newsObj获得图片对象数组。
                newsObj.newsImagesArray = imgObjArray;
            }
            
            
//          把多个newsObj对象存放到newsObjArray
            [newsObjArray addObject:newsObj];
            [newsObj release];
        }
        
        NSLog(@"-新闻列表对象对应的数组---->>>>>>>%@",newsObjArray);
        
        
//      练习：把上面的封装对象过程写入到model类中。
        
        
        self.dataArray = newsObjArray;
        
//      别忘记刷新表
        [_newsTable reloadData];
        
        
        
        }];
}

#pragma mark - Life Cycle

- (void)viewWillAppear:(BOOL)animated
{
//  请求新闻列表
    [self requestNewsListInfo];
    
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//  一个表只有一个表头 或者表尾，但可以有很多区头和区尾。
//    UITableView *tableView = nil;
//    tableView.tableHeaderView
//    tableView.tableFooterView
    
    [_newsTable registerClass:[UITableViewCell class] forCellReuseIdentifier:newsCellIdentifier];
    
}


#pragma mark -
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:newsCellIdentifier  forIndexPath:indexPath];
    
    ZYNewsListObj *obj = _dataArray[indexPath.row];
    
    cell.textLabel.text = obj.newsTitle;
    
    return cell;
}



- (void)dealloc
{
    [_newsTable release];
    [super dealloc];
}
@end
