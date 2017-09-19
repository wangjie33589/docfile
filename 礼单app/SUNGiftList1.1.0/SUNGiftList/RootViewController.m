//
//  RootViewController.m
//  SUNGiftList
//
//  Created by 孙 化育 on 13-4-14.
//  Copyright (c) 2013年 孙 化育. All rights reserved.
//

#import "RootViewController.h"
#import "CreatViewController.h"
#import "GiftListModel.h"
#import "DataBaseTool.h"
#import "ListViewController.h"
#import "SettingVC.h"

@interface RootViewController ()

@property (nonatomic,retain)NSMutableArray *giftListArray;

@end

@implementation RootViewController
@synthesize giftListArray = _giftListArray;

- (void)dealloc{
    [_backgroundImageView release];
    [_tableView release];
    [_giftListArray release];
    [_emptyLabel release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.bounds = CGRectMake(0, 0, 1024, 768);
    self.view.backgroundColor = [UIColor whiteColor];
    
    _backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _backgroundImageView.backgroundColor = [UIColor clearColor];
    _backgroundImageView.image = [UIImage imageNamed:@"heartBackground.png"];
    [self.view addSubview:_backgroundImageView];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(380+1000, 140, 514, 480)
                                              style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 180, 0);
    [self.view addSubview:_tableView];
    [self.view sendSubviewToBack:_tableView];
    
    for (int i = 0; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(70-1000, 80+210*i, 160, 160);
        button.tag = i+1;
        [button setBackgroundImage:[UIImage imageNamed:@"roungButton.png"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:24];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    [(UIButton *)[self.view viewWithTag:1] setTitle:@"新 建" forState:UIControlStateNormal];
    [(UIButton *)[self.view viewWithTag:2] setTitle:@"删 除" forState:UIControlStateNormal];
    [(UIButton *)[self.view viewWithTag:3] setTitle:@"设 置" forState:UIControlStateNormal];
    
    [self loadListFromDatabase];
    [UIView animateWithDuration:0.5
                          delay:0.5
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _tableView.frame = CGRectMake(380, 140, 514, 480);
                         for (int i = 1; i<4; i++){
                             ((UIButton *)[self.view viewWithTag:i]).frame = CGRectMake(70, 80+210*(i-1), 160, 160);
                         }
                     }
                     completion:nil];
    
	// Do any additional setup after loading the view.
}

#pragma mark- buttonAction
- (void)buttonClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1:{
            CreatViewController *controller = [[CreatViewController alloc] initWithList:nil finish:^(GiftListModel *list) {
                [DataBaseTool saveList:list];
                [self loadListFromDatabase];
                [_tableView reloadData];
            }];
            controller.modalPresentationStyle = UIModalPresentationFormSheet;
            [self presentModalViewController:controller animated:YES];
            [controller release];
            break;
        }
        case 2:{
            if (_tableView.editing == YES) {
                [_tableView setEditing:NO animated:YES];
            }else{
                [_tableView setEditing:YES animated:YES];
            }
            break;
        }
        case 3:{
            SettingVC *controller = [[SettingVC alloc] initWithNibName:@"SettingVC" bundle:nil];
            controller.modalPresentationStyle = UIModalPresentationFormSheet;
            [self presentModalViewController:controller animated:YES];
            [controller release];
            break;
        }
        default:
            break;
    }
}

#pragma mark- tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_giftListArray.count<=0) {
        if (!_emptyLabel) {
            _emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 130, 414, 40)];
            _emptyLabel.textAlignment = NSTextAlignmentCenter;
            _emptyLabel.backgroundColor = [UIColor clearColor];
            _emptyLabel.textColor = [UIColor grayColor];
            _emptyLabel.font = [UIFont boldSystemFontOfSize:18];
            _emptyLabel.text = @"暂无礼单，请点左侧“新建”按钮创建礼单";
            [_tableView addSubview:_emptyLabel];
        }
        _emptyLabel.hidden = NO;
    }else{
        _emptyLabel.hidden = YES;
    }
    return _giftListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"] autorelease];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:22];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:18];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    if (indexPath.row<_giftListArray.count) {
        GiftListModel *list = [_giftListArray objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        cell.textLabel.text = list.listTitle;
        cell.detailTextLabel.text = list.creatTime;
    }else{
        cell.textLabel.text = @"";
        cell.detailTextLabel.text = @"";
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    return cell;

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row>=_giftListArray.count){
        return;
    }
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        GiftListModel *list = [_giftListArray objectAtIndex:indexPath.row];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"您确定要删除“%@”吗？",list.listTitle]
                                                        message:@"删除后数据将不可恢复。"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
        alert.tag = 10;
        _deleteRow = indexPath.row;
        [alert show];
        [alert release];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row>=_giftListArray.count){
        return;
    }
    GiftListModel *list = [_giftListArray objectAtIndex:indexPath.row];
    ListViewController *controller = [[ListViewController alloc] initWithList:list];
    [self presentModalViewController:controller animated:YES];
    [controller release];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row>=_giftListArray.count){
        return;
    }
    GiftListModel *list = [_giftListArray objectAtIndex:indexPath.row];
    CreatViewController *controller = [[CreatViewController alloc] initWithList:list finish:^(GiftListModel *list) {
        [DataBaseTool updateList:list];
        [_tableView reloadData];
    }];
    controller.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:controller animated:YES];
    [controller release];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

#pragma mark- alertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 10) {
        if (buttonIndex == 1) {
            GiftListModel *list = [_giftListArray objectAtIndex:_deleteRow];
            [DataBaseTool deletePeople:list];
            [DataBaseTool deleteGiverByListnum:list.listNumber];
            [_giftListArray removeObjectAtIndex:_deleteRow];
            [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:_deleteRow
                                                                                           inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
            [_tableView setEditing:NO animated:YES];
        }
    }
}

#pragma mark- tool
- (void)loadListFromDatabase{
    self.giftListArray = [DataBaseTool getAllPeople];
}

#pragma mark-
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        return YES;
    }else{
        return NO;
    }
}

@end
