//
//  DataBaseTool.h
//  SUNGiftList
//
//  Created by 孙 化育 on 13-4-17.
//  Copyright (c) 2013年 孙 化育. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GiftListModel;
@class GiverModel;

@interface DataBaseTool : NSObject

    // 礼单表
+ (void)saveList:(GiftListModel *)list;
+ (void)updateList:(GiftListModel *)list;
+ (NSMutableArray *)getAllPeople;
+ (BOOL)deletePeople:(GiftListModel *)list;

    // 名单表
+ (NSString *)saveGiver:(GiverModel *)giver;
+ (void)updateGiver:(GiverModel *)giver;
+ (NSMutableArray *)getGiverByListNumber:(NSString *)listNum;
+ (void)deleteGiver:(GiverModel *)giver;
+ (void)deleteGiverByListnum:(NSString *)listID;
+ (NSMutableArray *)getSortedGiverByListNumber:(NSString *)listNum;

@end
