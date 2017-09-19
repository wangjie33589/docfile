//
//  StatisticalVC.m
//  SUNGiftList
//
//  Created by 孙 化育 on 13-4-21.
//  Copyright (c) 2013年 孙 化育. All rights reserved.
//

#import "StatisticalVC.h"

@interface StatisticalVC ()

@end

@implementation StatisticalVC

@synthesize delegate=_delegate;

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [_tableView release];
    _tableView = nil;
    [super viewDidUnload];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil peopleCount:(int)people totalMoney:(int)money currentPageMoney:(int)current sorted:(BOOL)sorted{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _peopleCount = people;
        _totalMoney = money;
        _currentPageMoney = current;
        _sorted = sorted;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark- tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if (indexPath.row<3) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                           reuseIdentifier:@"cell"] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"总人数";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%d人",_peopleCount];
                break;
            case 1:
                cell.textLabel.text = @"共计";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%d元",_totalMoney];
                break;
            case 2:
                cell.textLabel.text = @"本页合计";
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%d元",_currentPageMoney];
                break;
                
            default:
                break;
        }
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"buttonCell"];
        if (!cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:@"buttonCell"] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
        if (indexPath.row == 3) {
            if (_sorted) {
                cell.textLabel.text = @"取消排序";
            }else{
                cell.textLabel.text = @"排序";
            }
        }else if (indexPath.row == 4){
            cell.textLabel.text = @"查找";
        }
        
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        [_delegate sortOrCancel];
    }else if (indexPath.row == 4){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"查找"
                                                        message:@"请输入您要查找的姓名"
                                                       delegate:_delegate
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        alert.tag = 505;
        [alert show];
        [alert release];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
