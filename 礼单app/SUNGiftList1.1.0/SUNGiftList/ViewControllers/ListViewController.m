//
//  ListViewController.m
//  SUNGiftList
//
//  Created by 孙 化育 on 13-4-18.
//  Copyright (c) 2013年 孙 化育. All rights reserved.
//

#import "ListViewController.h"
#import "VerticalCell.h"
#import "DataBaseTool.h"
#import "AddCell.h"

#define BACKGROUND_PIC_NUM 12


@interface ListViewController ()

@property (nonatomic,retain) NSMutableArray *giverArray;
@property (nonatomic,retain) UIPopoverController *giverCreatController;
@property (nonatomic,retain) UIPopoverController *statisticalController;
@property (nonatomic,retain) UIPopoverController *imagePickerPopController;
@property (nonatomic,retain) NSMutableArray      *listArray;
@property (nonatomic,retain) GiftListModel       *list;

@end

@implementation ListViewController

@synthesize giverArray = _giverArray,giverCreatController = _giverCreatController,statisticalController=_statisticalController,listArray=_listArray,list = _list,imagePickerPopController = _imagePickerPopController;

- (void)dealloc{
    [_tableView release];
    [_downView release];
    [_giverArray release];
    [_list release];
    [_giverCreatController release];
    [_exitButton release];
    [_pageNumberLabel release];
    [_leftButton release];
    [_rightButton release];
    [_countButton release];
    [_statisticalController release];
    [_titleLabel release];
    [_pageChangeButton release];
    [_listArray release];
    [_backGroundView release];
    [_gridImageView release];
    [_downAddButton release];
    [_backgroudChangeButton release];
    [_backgroundChangeScrollView release];
    [_imagePickerPopController release];
    [super dealloc];
}

- (id)initWithList:(GiftListModel *)list{
    self = [super init];
    if (self) {
        _list = [list retain];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _searchCellIndex = NSNotFound;
    _sorted = NO;
    self.listArray = [DataBaseTool getAllPeople];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _backGroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, 1024, 718)];
    if (LIST_VIEW_BACKGROUND) {
        if ([LIST_VIEW_BACKGROUND isEqualToString:@"listBack.png"]) {
            NSString *path=NSHomeDirectory();
            NSString *filePath=[path stringByAppendingPathComponent:@"Documents/listBack.png"];
            UIImage *image = [[[UIImage alloc] initWithContentsOfFile:filePath] autorelease];
            _backGroundView.image = [UIImage imageWithCGImage:image.CGImage scale:1 orientation:SAVED_ORIENTATION];
        }else{
            _backGroundView.image = [UIImage imageNamed:LIST_VIEW_BACKGROUND];
        }
    }else{
        _backGroundView.image = [UIImage imageNamed:@"listBackground0.png"];
    }
    [self.view addSubview:_backGroundView];
    
    _gridImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 32, 1024, 698)];
    _gridImageView.image = [UIImage imageNamed:@"grid.png"];
    [self.view addSubview:_gridImageView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(208, -113, 608, 944)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView.backgroundColor = [UIColor clearColor];
    _tableView.pagingEnabled = YES;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.transform = CGAffineTransformMakeRotation(-M_PI/2);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    _downView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 1024, 50)];
    _downView.barStyle = UIBarStyleBlackOpaque;
    [self.view addSubview:_downView];
    
    UITapGestureRecognizer *recgnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pageChangeButtonClick)];
    [_downView addGestureRecognizer:recgnizer];
    [recgnizer release];
    
    _titleLabel = [[UILabel alloc] initWithFrame:_downView.bounds];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:26];
    [_downView addSubview:_titleLabel];
    _titleLabel.text = _list.listTitle;
    [_titleLabel sizeToFit];
    _titleLabel.center = _downView.center;
    
    _pageChangeButton = [[UIButton alloc] initWithFrame:CGRectMake(_titleLabel.frame.origin.x+_titleLabel.frame.size.width+10, 10, 30, 30)];
    [_pageChangeButton setBackgroundImage:[UIImage imageNamed:@"arrowDown.png"] forState:UIControlStateNormal];
    [_pageChangeButton addTarget:self action:@selector(pageChangeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_downView addSubview:_pageChangeButton];
    
    _exitButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 688, 100, 40)];
    [_exitButton setBackgroundImage:[[UIImage imageNamed:@"rBTN.png"] stretchableImageWithLeftCapWidth:35
                                                                                      topCapHeight:35]
                       forState:UIControlStateNormal];
    [_exitButton setBackgroundImage:[[UIImage imageNamed:@"rBTN_CLICK.png"] stretchableImageWithLeftCapWidth:35
                                                                                            topCapHeight:35]
                       forState:UIControlStateHighlighted];
    [_exitButton setTitle:@"返 回" forState:UIControlStateNormal];
    _exitButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [_exitButton addTarget:self action:@selector(exitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_exitButton];
    
    _backgroudChangeButton = [[UIButton alloc] initWithFrame:CGRectMake(160, 688, 100, 40)];
    [_backgroudChangeButton setBackgroundImage:[[UIImage imageNamed:@"rBTN.png"] stretchableImageWithLeftCapWidth:35
                                                                                          topCapHeight:35]
                           forState:UIControlStateNormal];
    [_backgroudChangeButton setBackgroundImage:[[UIImage imageNamed:@"rBTN_CLICK.png"] stretchableImageWithLeftCapWidth:35
                                                                                                topCapHeight:35]
                           forState:UIControlStateHighlighted];
    [_backgroudChangeButton setTitle:@"更换背景" forState:UIControlStateNormal];
    _backgroudChangeButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [_backgroudChangeButton addTarget:self action:@selector(backgroundChangeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backgroudChangeButton];
    
    _currentPage = 1;
    _pageNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(412, 688, 200, 40)];
    _pageNumberLabel.textAlignment = NSTextAlignmentCenter;
    _pageNumberLabel.backgroundColor = [UIColor clearColor];
    _pageNumberLabel.font = [UIFont systemFontOfSize:26];
    [self.view addSubview:_pageNumberLabel];
    
    _leftButton = [[UIButton alloc] initWithFrame:CGRectMake(372, 688, 40, 40)];
    [_leftButton setBackgroundImage:[UIImage imageNamed:@"arrowLeft.png"] forState:UIControlStateNormal];
    [_leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_leftButton];
    
    _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(612, 688, 40, 40)];
    [_rightButton setBackgroundImage:[UIImage imageNamed:@"arrowRight.png"] forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_rightButton];
    
    _countButton = [[UIButton alloc] initWithFrame:CGRectMake(884, 688, 100, 40)];
    [_countButton setBackgroundImage:[[UIImage imageNamed:@"rBTN.png"] stretchableImageWithLeftCapWidth:35
                                                                                          topCapHeight:35]
                           forState:UIControlStateNormal];
    [_countButton setBackgroundImage:[[UIImage imageNamed:@"rBTN_CLICK.png"] stretchableImageWithLeftCapWidth:35
                                                                                                topCapHeight:35]
                           forState:UIControlStateHighlighted];
    [_countButton setTitle:@"统 计" forState:UIControlStateNormal];
    _countButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [_countButton addTarget:self action:@selector(countButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_countButton];
    
    _downAddButton = [[UIButton alloc] initWithFrame:CGRectMake(764, 688, 100, 40)];
    [_downAddButton setBackgroundImage:[[UIImage imageNamed:@"rBTN.png"] stretchableImageWithLeftCapWidth:35
                                                                                           topCapHeight:35]
                            forState:UIControlStateNormal];
    [_downAddButton setBackgroundImage:[[UIImage imageNamed:@"rBTN_CLICK.png"] stretchableImageWithLeftCapWidth:35
                                                                                                 topCapHeight:35]
                            forState:UIControlStateHighlighted];
    [_downAddButton setTitle:@"添 加" forState:UIControlStateNormal];
    _downAddButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [_downAddButton addTarget:self action:@selector(downAddButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_downAddButton];
    
    self.giverArray = [DataBaseTool getGiverByListNumber:_list.listNumber];
    [_tableView reloadData];
    _pageNumberLabel.text = [NSString stringWithFormat:@"第 %d/%d 页",_currentPage,(_giverArray.count)/8+1];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

#pragma mark- tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _tableView) {
        int num = _giverArray.count + 1;
        if (num % 8 != 0) {
            num = (num/8+1)*8;
        }
        return num;
    }else{
        return _listArray.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tableView){
        if (indexPath.row == _giverArray.count) {
            AddCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddCell"];
            if (!cell) {
                NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"AddCell"
                                                             owner:nil
                                                           options:nil];
                cell = [arr objectAtIndex:0];
                [cell.button2 setBackgroundImage:[UIImage imageNamed:@"addButtonRed.png"] forState:UIControlStateNormal];
                [cell.button2 setBackgroundImage:[UIImage imageNamed:@"addButtonGreen.png"] forState:UIControlStateHighlighted];
                [cell.button2 addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                _addButton = cell.button2;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor clearColor];
            }
            return cell;
        }else{
            VerticalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VerticalCell"];
            if (!cell) {
                NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"VerticalCell"
                                                             owner:nil
                                                           options:nil];
                cell = [arr objectAtIndex:0];
                cell.backgroundColor = [UIColor clearColor];
                cell.nameLabel.transform = CGAffineTransformMakeRotation(M_PI/2);
                cell.moneyLabel.transform = CGAffineTransformMakeRotation(M_PI/2);
                cell.selectionStyle = UITableViewCellSelectionStyleGray;
            }
            if (indexPath.row > _giverArray.count) {
                cell.nameLabel.text = @"";
                cell.moneyLabel.text = @"";
            }else{
                GiverModel *giver = [_giverArray objectAtIndex:indexPath.row];
                cell.nameLabel.text = giver.name;
                cell.moneyLabel.text = [SUNTools changeNumberToHigherCase:giver.money];
            }
            
            return cell;
        }
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
        if (!cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"listCell"] autorelease];
            cell.backgroundColor = [UIColor clearColor];

        }
        GiftListModel *list = [_listArray objectAtIndex:indexPath.row];
        cell.textLabel.text = list.listTitle;
        return cell;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tableView){
        return 118;
    }else{
        return 40;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tableView){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self hideTheListTable];
        if (_backgroundChangeViewDidShow) {
            [self hideTheBackgroundChangeView];
            return;
        }
        if (indexPath.row > _giverArray.count) {
            return;
        }
        if (indexPath.row == _giverArray.count) {
            [self addButtonClick:_addButton];
        }else{
            GiverModel *giver = [_giverArray objectAtIndex:indexPath.row];
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:giver.name
                                                               delegate:self
                                                      cancelButtonTitle:@"取消"
                                                 destructiveButtonTitle:@"删除"
                                                      otherButtonTitles:@"编辑", nil];
            _giverDeleteTag = indexPath.row;
            [sheet showFromRect:[tableView cellForRowAtIndexPath:indexPath].frame
                         inView:_tableView
                       animated:YES];
            [sheet release];
        }
    }else{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self hideTheListTable];
        GiftListModel *list = [_listArray objectAtIndex:indexPath.row];
        [self changePageToList:list];
    }
    
}

#pragma mark- buttonAction
- (void)addButtonClick:(UIButton *)sender{
    GiverCreateVC *giverMaker = [[GiverCreateVC alloc] initWithNibName:@"GiverCreateVC" bundle:nil];
    giverMaker.delegate = self;
    if (_giverCreatController!=nil) {
		[_giverCreatController dismissPopoverAnimated:YES];
	}
	self.giverCreatController=[[[UIPopoverController alloc] initWithContentViewController:giverMaker] autorelease];
	[giverMaker release];
	_giverCreatController.popoverContentSize=CGSizeMake(330, 200);
	
    [_giverCreatController presentPopoverFromRect:sender.frame
                                           inView:sender.superview
                         permittedArrowDirections:UIPopoverArrowDirectionRight|UIPopoverArrowDirectionLeft
                                         animated:YES];
}

- (void)exitButtonClick{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)backgroundChangeButtonClick{
    if (!_backgroundChangeScrollView) {
        _backgroundChangeScrollView = [[UIScrollView alloc] initWithFrame:_backgroudChangeButton.frame];
        _backgroundChangeScrollView.hidden = YES;
        _backgroundChangeScrollView.showsVerticalScrollIndicator = YES;
        [self.view addSubview:_backgroundChangeScrollView];
    }
    _backgroundChangeScrollView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    _backgroundChangeScrollView.clipsToBounds = YES;
    if (_backgroundChangeViewDidShow) {
        [self hideTheBackgroundChangeView];
    }else{
        [self showTheBackgroundChangeView];
    }
}

- (void)leftButtonClick{
    if (_currentPage<=1) {
        return;
    }
    _currentPage-=1;
    CGPoint point = CGPointMake(0, 944*(_currentPage-1));
    [_tableView setContentOffset:point animated:NO];
    _pageNumberLabel.text = [NSString stringWithFormat:@"第 %d/%d 页",_currentPage,(_giverArray.count)/8+1];
}

- (void)rightButtonClick{
    if (_currentPage>=_giverArray.count/8+1) {
        return;
    }
    _currentPage+=1;
    CGPoint point = CGPointMake(0, 944*(_currentPage-1));
    [_tableView setContentOffset:point animated:NO];
    _pageNumberLabel.text = [NSString stringWithFormat:@"第 %d/%d 页",_currentPage,(_giverArray.count)/8+1];
}

- (void)countButtonClick{
    if (_backgroundChangeViewDidShow) {
        [self hideTheBackgroundChangeView];
    }
    int tot = 0;
    for (int i = 0; i<_giverArray.count; i++) {
        GiverModel *giver = [_giverArray objectAtIndex:i];
        tot+=[giver.money intValue];
    }
    
    int curr = 0;
    for (int i = (_currentPage-1)*8; i<_currentPage*8; i++) {
        if (i >= _giverArray.count) {
            break;
        }
        GiverModel *giver = [_giverArray objectAtIndex:i];
        curr+=[giver.money intValue];
    }
    
    
    StatisticalVC *statisticalController = [[StatisticalVC alloc] initWithNibName:@"StatisticalVC" bundle:nil peopleCount:_giverArray.count totalMoney:tot currentPageMoney:curr sorted:_sorted];
    statisticalController.delegate = self;
    if (_giverCreatController!=nil) {
		[_giverCreatController dismissPopoverAnimated:YES];
	}
	self.statisticalController=[[[UIPopoverController alloc] initWithContentViewController:statisticalController] autorelease];
	[statisticalController release];
	_statisticalController.popoverContentSize=CGSizeMake(320, 240);
	
    [_statisticalController presentPopoverFromRect:_countButton.frame
                                           inView:_downView
                         permittedArrowDirections:UIPopoverArrowDirectionRight|UIPopoverArrowDirectionLeft
                                         animated:YES];
}

- (void)downAddButtonClick{
    if (_currentPage == (_giverArray.count)/8+1) {
        [self addButtonClick:_addButton];
    }else{
        _addAnimiationGoing = YES;
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_giverArray.count/8*8 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        _currentPage = (_giverArray.count)/8+1;
        _pageNumberLabel.text = [NSString stringWithFormat:@"第 %d/%d 页",_currentPage,(_giverArray.count)/8+1];
    }
}

- (void)pageChangeButtonClick{
    if (_backgroundChangeViewDidShow) {
        [self hideTheBackgroundChangeView];
    }
    if (!_listTableView) {
        _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(362, 50, 300, 0)];
        _listTableView.dataSource = self;
        _listTableView.delegate = self;
        _listTableView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        [self.view addSubview:_listTableView];
    }
    if (_listTableDidShow) {
        [self hideTheListTable];
    }else{
        [self showTheListTable];
    }
}

- (void)backgroundSelectButtonClick:(UIButton *)sender{
    self.view.userInteractionEnabled = NO;
    _backgroundChangeScrollView.backgroundColor = [UIColor clearColor];
    for (int i = 0; i<BACKGROUND_PIC_NUM; i++){
        if (sender.tag-1000 == i) {
            continue;
        }
        [_backgroundChangeScrollView viewWithTag:i+1000].hidden = YES;
        [_backgroundChangeScrollView viewWithTag:998].hidden = YES;
        [_backgroundChangeScrollView viewWithTag:999].hidden = YES;
        
    }
    _backgroundChangeScrollView.clipsToBounds = NO;
    [self.view sendSubviewToBack:_backgroundChangeScrollView];
    [self.view sendSubviewToBack:_backGroundView];
    [UIView animateWithDuration:0.5
                     animations:^{
                         [_backgroundChangeScrollView viewWithTag:sender.tag].frame = CGRectMake(-100+_backgroundChangeScrollView.contentOffset.x, -100, 1024, 698);
                     }
                     completion:^(BOOL finished) {
                         _backGroundView.image = [UIImage imageNamed:[NSString stringWithFormat:@"listBackground%d.png",sender.tag-1000]];
                         [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"listBackground%d.png",sender.tag-1000] forKey:@"listViewBackground"];
                         [[NSUserDefaults standardUserDefaults] synchronize];
                         [self.view bringSubviewToFront:_backgroundChangeScrollView];
                         [self hideTheBackgroundChangeView];
                         self.view.userInteractionEnabled = YES;
                     }];
}

- (void)chooseImageFromAlbums:(UIButton *)sender{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        UIPopoverController *popover = [[[UIPopoverController alloc] initWithContentViewController:imagePicker] autorelease];
        [imagePicker release];
        self.imagePickerPopController = popover;
        [self.imagePickerPopController presentPopoverFromRect:CGRectMake(612, 0, 964, 638)
                                                       inView:self.view
                                     permittedArrowDirections:UIPopoverArrowDirectionRight
                                                     animated:YES];
    }else{
        [SUNTools simpleAlertWithTitle:@"提示" message:@"访问相册失败"];
    }
}

- (void)takePhotoNow{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentModalViewController:imagePicker animated:YES];
        [imagePicker release];
    }else{
        [SUNTools simpleAlertWithTitle:@"提示" message:@"您的设备似乎不支持拍照"];
    }
    
}

#pragma mark- GiverDelegate
- (void)madeGiver:(GiverModel *)giver{
    giver.relatedList = _list.listNumber;
    giver.keyNum = [DataBaseTool saveGiver:giver];
    [_giverArray addObject:giver];
    [_tableView reloadData];
    if (_giverArray.count%8 == 0) {
        [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_giverArray.count inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        _currentPage = (_giverArray.count)/8+1;
        _pageNumberLabel.text = [NSString stringWithFormat:@"第 %d/%d 页",_currentPage,(_giverArray.count)/8+1];
    }
    
    [_giverCreatController dismissPopoverAnimated:YES];
    self.giverCreatController = nil;
}

- (void)editFinish{
    [_tableView reloadData];
    [_giverCreatController dismissPopoverAnimated:YES];
    self.giverCreatController = nil;
}

#pragma mark- StatisticalVCDelegate

- (void)sortOrCancel{
    [_statisticalController dismissPopoverAnimated:YES];
    self.statisticalController = nil;
    
    if (_sorted) {
        self.giverArray = [DataBaseTool getGiverByListNumber:_list.listNumber];
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        _sorted = NO;
    }else{
        self.giverArray = [DataBaseTool getSortedGiverByListNumber:_list.listNumber];
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        _sorted = YES;
    }
}

#pragma mark- actionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        GiverModel *giver = [_giverArray objectAtIndex:_giverDeleteTag];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:[NSString stringWithFormat:@"您确定要删除“%@”的贺礼信息吗？",giver.name]
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
        alert.tag = 50;
        [alert show];
        [alert release];
        
    }else if(buttonIndex == 1){
        GiverModel *giver = [_giverArray objectAtIndex:_giverDeleteTag];
        GiverCreateVC *giverMaker = [[GiverCreateVC alloc] initWithNibName:@"GiverCreateVC" bundle:nil];
        giverMaker.delegate = self;
        giverMaker.giver = giver;
        if (_giverCreatController!=nil) {
            [_giverCreatController dismissPopoverAnimated:YES];
        }
        self.giverCreatController=[[[UIPopoverController alloc] initWithContentViewController:giverMaker] autorelease];
        [giverMaker release];
        _giverCreatController.popoverContentSize=CGSizeMake(330, 200);
        
        [_giverCreatController presentPopoverFromRect:[_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_giverDeleteTag inSection:0]].frame
                                               inView:_tableView
                             permittedArrowDirections:UIPopoverArrowDirectionRight|UIPopoverArrowDirectionLeft
                                             animated:YES];
    }
}
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//    
//}

#pragma mark- scrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _tableView){
        _currentPage = scrollView.contentOffset.y/944 + 1;
        _pageNumberLabel.text = [NSString stringWithFormat:@"第 %d/%d 页",_currentPage,(_giverArray.count)/8+1];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == _tableView) {
        [self hideTheListTable];
        if (_backgroundChangeViewDidShow) {
            [self hideTheBackgroundChangeView];
        }
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (scrollView == _tableView){
        if (_addAnimiationGoing) {
            [self addButtonClick:_addButton];
            _addAnimiationGoing = NO;
        }
        if (_searchCellIndex != NSNotFound) {
            UITableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_searchCellIndex inSection:0]];
            cell.selected = YES;
            _searchCellIndex = NSNotFound;
        }
    }
}

#pragma mark- alertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 505 && buttonIndex == 1) {
        NSString *str = [alertView textFieldAtIndex:0].text;
        for (int i = 0; i<_giverArray.count; i++) {
            GiverModel *giver = [_giverArray objectAtIndex:i];
            if ([giver.name rangeOfString:str].location!=NSNotFound) {
                if (_currentPage == i/8+1) {
                    UITableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                    cell.selected = YES;
                    break;
                }else{
                    _currentPage = i/8+1;
                    CGPoint point = CGPointMake(0, 944*(_currentPage-1));
                    [_tableView setContentOffset:point animated:YES];
                    _pageNumberLabel.text = [NSString stringWithFormat:@"第 %d/%d 页",_currentPage,(_giverArray.count)/8+1];
                    _searchCellIndex = i;
                    break;
                }
            }
            if (i == _giverArray.count - 1) {
                [SUNTools simpleAlertWithTitle:@"提示" message:@"查无此人"];
            }
        }
    }else if (alertView.tag == 50 && buttonIndex == 1){
        GiverModel *giver = [_giverArray objectAtIndex:_giverDeleteTag];
        [DataBaseTool deleteGiver:giver];
        [_giverArray removeObject:giver];
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        _pageNumberLabel.text = [NSString stringWithFormat:@"第 %d/%d 页",_currentPage,(_giverArray.count)/8+1];
    }
}

#pragma mark- listTableShowAndHidden
- (void)showTheListTable{
    if (!_listTableDidShow) {
        [UIView animateWithDuration:0.3 animations:^{
            _listTableView.frame = CGRectMake(362, 50, 300, 200);
            _pageChangeButton.transform = CGAffineTransformMakeRotation(M_PI);
        }];
        _listTableDidShow = YES;
    }
}

- (void)hideTheListTable{
    if (_listTableDidShow) {
        [UIView animateWithDuration:0.3 animations:^{
            _listTableView.frame = CGRectMake(362, 50, 300, 0);
             _pageChangeButton.transform = CGAffineTransformIdentity;
        }];
        _listTableDidShow = NO;
    }
}

- (void)changePageToList:(GiftListModel *)list{
    self.list = list;
    self.giverArray = [DataBaseTool getGiverByListNumber:_list.listNumber];
    [_tableView reloadData];
    _titleLabel.text = _list.listTitle;
    [_titleLabel sizeToFit];
    _titleLabel.center = _downView.center;
    _pageChangeButton.frame = CGRectMake(_titleLabel.frame.origin.x+_titleLabel.frame.size.width+10, 10, 30, 30);
    _currentPage = _tableView.contentOffset.y/944 + 1;
    _pageNumberLabel.text = [NSString stringWithFormat:@"第 %d/%d 页",_currentPage,(_giverArray.count)/8+1];
}

#pragma mark- backgroundChangeViewShowAndHidden
- (void)showTheBackgroundChangeView{
    if (_backgroundChangeViewDidShow) {
        return;
    }
    _backgroundChangeScrollView.hidden = NO;
    self.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _backgroundChangeScrollView.frame = CGRectMake(100, 150, 824, 448);
                     }
                     completion:^(BOOL finished) {
                         _backgroundChangeScrollView.contentSize = CGSizeMake(40+(300+40)*(BACKGROUND_PIC_NUM+1), 448);
                         for (int i = 0; i<BACKGROUND_PIC_NUM; i++) {
                             UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(40+(300+40)*i, 112, 300, 222)];
                             [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"listBackground%d.png",i]] forState:UIControlStateNormal];
                             [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"listBackground%d.png",i]] forState:UIControlStateHighlighted];
                             [button addTarget:self action:@selector(backgroundSelectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                             button.tag = i+1000;
                             [_backgroundChangeScrollView addSubview:button];
                             [button release];
                         }
                         //从相册选择
                         UIButton *butt = [[UIButton alloc] initWithFrame:CGRectMake(40+(300+40)*BACKGROUND_PIC_NUM, 132, 300, 40)];
                         [butt setBackgroundImage:[[UIImage imageNamed:@"rBTN.png"] stretchableImageWithLeftCapWidth:35
                                                                                                               topCapHeight:35]
                                                forState:UIControlStateNormal];
                         [butt setBackgroundImage:[[UIImage imageNamed:@"rBTN_CLICK.png"] stretchableImageWithLeftCapWidth:35
                                                                                                                     topCapHeight:35]
                                                forState:UIControlStateHighlighted];
                         [butt setTitle:@"从相册选择" forState:UIControlStateNormal];
                         butt.titleLabel.font = [UIFont boldSystemFontOfSize:20];
                         [butt addTarget:self action:@selector(chooseImageFromAlbums:) forControlEvents:UIControlEventTouchUpInside];
                         butt.tag = 998;
                         [_backgroundChangeScrollView addSubview:butt];
                         [butt release];
                         
                         //临时照一张
                         butt = [[UIButton alloc] initWithFrame:CGRectMake(40+(300+40)*BACKGROUND_PIC_NUM, 276, 300, 40)];
                         [butt setBackgroundImage:[[UIImage imageNamed:@"rBTN.png"] stretchableImageWithLeftCapWidth:35
                                                                                                        topCapHeight:35]
                                         forState:UIControlStateNormal];
                         [butt setBackgroundImage:[[UIImage imageNamed:@"rBTN_CLICK.png"] stretchableImageWithLeftCapWidth:35
                                                                                                              topCapHeight:35]
                                         forState:UIControlStateHighlighted];
                         [butt setTitle:@"现在拍一张!" forState:UIControlStateNormal];
                         butt.titleLabel.font = [UIFont boldSystemFontOfSize:20];
                         [butt addTarget:self action:@selector(takePhotoNow) forControlEvents:UIControlEventTouchUpInside];
                         butt.tag = 999;
                         [_backgroundChangeScrollView addSubview:butt];
                         [butt release];
                         
                         [_backgroundChangeScrollView flashScrollIndicators];
                         _backgroundChangeViewDidShow = YES;
                         self.view.userInteractionEnabled = YES;
                     }];
}

- (void)hideTheBackgroundChangeView{
    if (!_backgroundChangeViewDidShow) {
        return;
    }
    _backgroundChangeScrollView.scrollEnabled = NO;
    [_backgroundChangeScrollView setContentOffset:_backgroundChangeScrollView.contentOffset animated:NO];
    for (int i = 0; i<BACKGROUND_PIC_NUM; i++){
        [[_backgroundChangeScrollView viewWithTag:i+1000] removeFromSuperview];
    }
    [[_backgroundChangeScrollView viewWithTag:998] removeFromSuperview];
    [[_backgroundChangeScrollView viewWithTag:999] removeFromSuperview];
    self.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         _backgroundChangeScrollView.frame = _backgroudChangeButton.frame;
                     }
                     completion:^(BOOL finished) {
                         _backgroundChangeScrollView.hidden = YES;
                         _backgroundChangeViewDidShow = NO;
                         self.view.userInteractionEnabled = YES;
                         _backgroundChangeScrollView.scrollEnabled = YES;
                     }];
}

#pragma mark- imagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0){
    _backGroundView.image = image;
    NSString *path=NSHomeDirectory();
    NSString *filePath=[path stringByAppendingPathComponent:@"Documents/listBack.png"];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:filePath]) {
        [manager createFileAtPath:filePath contents:UIImagePNGRepresentation(image) attributes:nil];
    }else{
        [manager removeItemAtPath:filePath error:nil];
        [manager createFileAtPath:filePath contents:UIImagePNGRepresentation(image) attributes:nil];
    }
    [[NSUserDefaults standardUserDefaults] setInteger:image.imageOrientation forKey:@"savedImageOrientation"];
    [[NSUserDefaults standardUserDefaults] setObject:@"listBack.png" forKey:@"listViewBackground"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        [self.imagePickerPopController dismissPopoverAnimated:YES];
        [self hideTheBackgroundChangeView];
    }else if (picker.sourceType == UIImagePickerControllerSourceTypeCamera){
        [picker dismissModalViewControllerAnimated:YES];
        [self hideTheBackgroundChangeView];
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        [self.imagePickerPopController dismissPopoverAnimated:YES];
    }else if (picker.sourceType == UIImagePickerControllerSourceTypeCamera){
        [picker dismissModalViewControllerAnimated:YES];
    }
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
