//
//  DataBaseTool.m
//  SUNGiftList
//
//  Created by 孙 化育 on 13-4-17.
//  Copyright (c) 2013年 孙 化育. All rights reserved.
//

#import "DataBaseTool.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "GiftListModel.h"
#import "GiverModel.h"

@implementation DataBaseTool

static FMDatabase *__db = nil;

+ (void)load{
    [super load];
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    if (!__db) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [paths objectAtIndex:0];
        NSString *dbPath = [path stringByAppendingPathComponent:@"Database.sqlite"];
        __db = [[FMDatabase alloc] initWithPath:dbPath];
        [__db open];
        if ( ![__db tableExists:@"GiftList"] ){
            [self createGiftList];
        }
        if ( ![__db tableExists:@"GiverList"] ){
            [self createGiverList];
        }
        [__db close];
    }
    [pool drain];
}

+ (void)createGiftList{
	
	if ( ![__db tableExists:@"GiftList"] ){
        NSLog(@"开始创建表  %@",__db);
        
		[__db executeUpdate:@"create table GiftList (ListID INTEGER primary key AUTOINCREMENT ,title text, time text, spare text)"] ;
    }
    
}

+ (void)createGiverList{
    if ( ![__db tableExists:@"GiverList"] ){
        NSLog(@"开始创建表  %@",__db);
        
		[__db executeUpdate:@"create table GiverList (GiverID INTEGER primary key AUTOINCREMENT ,name text, money INTEGER, listNum text, spare text)"] ;
    }
}

+ (void)saveList:(GiftListModel *)list{
	
	if (![__db open]){
		return;
    }
	
        // kind of experimentalish.
	[__db setShouldCacheStatements:YES];
    
    [__db executeUpdate:@"insert into GiftList "
     @"( title, time) "
     @"values (?, ?)",
     list.listTitle,list.creatTime];
    
	[__db close];
}

+ (void)updateList:(GiftListModel *)list{
    if (![__db open]){
		NSLog(@"Could not open TransMedicsDb.");
		return;
    }
	
        // kind of experimentalish.
	[__db setShouldCacheStatements:YES];
	
    FMResultSet *peopleRS = [__db executeQuery:@"select * from GiftList where [ListID] = ?", list.listNumber];
    
    if ([peopleRS next]){
        [__db executeUpdate:@"update GiftList "
		 @"set title = ?, time = ? "
		 @"where ListID = ?" ,
         list.listTitle,list.creatTime,list.listNumber];
        
    }
    [peopleRS close];
	[__db close];
}

+ (BOOL)deletePeople:(GiftListModel *)list{
    if (![__db open]) {
		NSLog(@"Could not open TransMedicsDb.");
		return NO;
	}
    
    [__db setShouldCacheStatements:YES];
	
	if ( ![__db tableExists:@"GiftList"] ) {
		return NO;
	}
    
    BOOL flag = [__db executeUpdate:@"delete from GiftList where [ListID] = ?",list.listNumber];
    
    [__db close];
    
    return flag;
}

+ (NSMutableArray *)getAllPeople{
	if (![__db open])
        {
		NSLog(@"Could not open TransMedicsDb.");
		return nil;
        }
	
        // kind of experimentalish.
	[__db setShouldCacheStatements:YES];
	
	if ( ![__db tableExists:@"GiftList"] ) {
		return nil;
	}
    
	NSMutableArray *listArray = [[NSMutableArray alloc] init];
	FMResultSet *dataRs = [__db executeQuery:@"select * from GiftList"];
	
	while ([dataRs next]){
        
        GiftListModel *list = [[GiftListModel alloc] init];
        
        list.listNumber = [dataRs stringForColumn:@"ListID"];
        list.listTitle = [dataRs stringForColumn:@"title"];
        list.creatTime = [dataRs stringForColumn:@"time"];
        
        [listArray addObject:list];
        [list release];
    }
	
	[dataRs close];
	[__db close];
    
	return [listArray autorelease];
}

#pragma mark- giver

+ (NSString *)saveGiver:(GiverModel *)giver{
    if (![__db open]){
		return nil;
    }
	
        // kind of experimentalish.
	[__db setShouldCacheStatements:YES];
    
    [__db executeUpdate:@"insert into GiverList "
     @"( name, money, listNum) "
     @"values (?, ?, ?)",
     giver.name,giver.money,giver.relatedList];
    
    FMResultSet *dataRs = [__db executeQuery:@"select max(GiverID) from GiverList"];
    
    NSString *str = nil;
    
    if ([dataRs next]) {
        int maxID;
        maxID=[dataRs intForColumnIndex:0];
        str=[NSString stringWithFormat:@"%d",maxID];
    }
    [dataRs close];
    
	[__db close];
    
    return str;
}
+ (void)updateGiver:(GiverModel *)giver{
    if (![__db open]){
		NSLog(@"Could not open TransMedicsDb.");
		return;
    }
	
        // kind of experimentalish.
	[__db setShouldCacheStatements:YES];
	
    FMResultSet *peopleRS = [__db executeQuery:@"select * from GiverList where [GiverID] = ?", giver.keyNum];
    
    if ([peopleRS next]){
        [__db executeUpdate:@"update GiverList "
		 @"set name = ?, money = ?, listNum = ? "
		 @"where GiverID = ?" ,
         giver.name,giver.money,giver.relatedList,giver.keyNum];
        
    }
	[__db close];
}
+ (NSMutableArray *)getGiverByListNumber:(NSString *)listNum{
    if (![__db open])
        {
		NSLog(@"Could not open TransMedicsDb.");
		return nil;
        }
	
        // kind of experimentalish.
	[__db setShouldCacheStatements:YES];
	
	if ( ![__db tableExists:@"GiverList"] ) {
		return nil;
	}
    
	NSMutableArray *listArray = [[NSMutableArray alloc] init];
	FMResultSet *dataRs = [__db executeQuery:@"select * from GiverList where [listNum] = ?",listNum];
	
	while ([dataRs next]){
        
        GiverModel *giver = [[GiverModel alloc] init];
        
        giver.name = [dataRs stringForColumn:@"name"];
        giver.money = [NSString stringWithFormat:@"%d",[dataRs intForColumn:@"money"]];
        giver.relatedList = [dataRs stringForColumn:@"listNum"];
        giver.keyNum = [NSString stringWithFormat:@"%d",[dataRs intForColumn:@"GiverID"]];
        
        [listArray addObject:giver];
        [giver release];
    }
	
	[dataRs close];
	[__db close];
    
	return [listArray autorelease];
}

+ (NSMutableArray *)getSortedGiverByListNumber:(NSString *)listNum{
    if (![__db open])
        {
		NSLog(@"Could not open TransMedicsDb.");
		return nil;
        }
	
        // kind of experimentalish.
	[__db setShouldCacheStatements:YES];
	
	if ( ![__db tableExists:@"GiverList"] ) {
		return nil;
	}
    
	NSMutableArray *listArray = [[NSMutableArray alloc] init];
	FMResultSet *dataRs = [__db executeQuery:@"select * from GiverList where [listNum] = ? order by money desc",listNum];
        //asc
	while ([dataRs next]){
        
        GiverModel *giver = [[GiverModel alloc] init];
        
        giver.name = [dataRs stringForColumn:@"name"];
        giver.money = [NSString stringWithFormat:@"%d",[dataRs intForColumn:@"money"]];
        giver.relatedList = [dataRs stringForColumn:@"listNum"];
        giver.keyNum = [NSString stringWithFormat:@"%d",[dataRs intForColumn:@"GiverID"]];
        
        [listArray addObject:giver];
        [giver release];
    }
	
	[dataRs close];
	[__db close];
    
	return [listArray autorelease];
}

+ (void)deleteGiver:(GiverModel *)giver{
    if (![__db open]) {
		NSLog(@"Could not open TransMedicsDb.");
		return;
	}
    
    [__db setShouldCacheStatements:YES];
	
	if ( ![__db tableExists:@"GiverList"] ) {
		return;
	}
    
    [__db executeUpdate:@"delete from GiverList where [GiverID] = ?",giver.keyNum];
    
    [__db close];
}

+ (void)deleteGiverByListnum:(NSString *)listID{
    if (![__db open]) {
		NSLog(@"Could not open TransMedicsDb.");
		return;
	}
    
    [__db setShouldCacheStatements:YES];
	
	if ( ![__db tableExists:@"GiverList"] ) {
		return;
	}
    
    [__db executeUpdate:@"delete from GiverList where [listNum] = ?",listID];
    
    [__db close];
}

@end
