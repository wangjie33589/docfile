//
//  SUNTools.m
//  SUNGiftList
//
//  Created by 孙 化育 on 13-4-16.
//  Copyright (c) 2013年 孙 化育. All rights reserved.
//

#import "SUNTools.h"

@implementation SUNTools

+(void)simpleAlertWithTitle:(NSString *)title message:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

+(NSString *)changeNumberToHigherCase:(NSString *)number{
    NSCharacterSet *disallowedCharacters = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"] ;
    for (int i = 0; i<number.length; i++) {
        NSString *str = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange foundRange = [str rangeOfCharacterFromSet:disallowedCharacters];
        if (foundRange.location == NSNotFound){
                // 非数字
            return nil;
        }
    }
    
    NSMutableString *resultString = [NSMutableString stringWithFormat:@""];
    for (int i = number.length-1; i >= 0; i--) {
        NSString *subStr = [number substringWithRange:NSMakeRange(i, 1)];
        if ((subStr.intValue == 0)&&(number.length-1-i == 0)) {
            continue;
        }else if (subStr.intValue == 0){
            if ([number substringWithRange:NSMakeRange(i+1, 1)].intValue!=0) {
                [resultString insertString:@"零"
                                   atIndex:0];
            }
            if (i == number.length-5) {
                [resultString insertString:@"万"
                                   atIndex:0];
            }
            continue;
        }else{
            if (i == number.length-5) {
                [resultString insertString:@"万"
                                   atIndex:0];
            }
        }
        NSString *unitStr = nil;
        subStr = [SUNTools changeNumberChar:subStr];
        switch (number.length-1-i) {
            case 0:
                unitStr = @"";
                break;
            case 1:
                if (IS_HIGN_CASE) {
                    unitStr = @"拾";
                }else{
                    unitStr = @"十";
                }
                break;
            case 2:
                if (IS_HIGN_CASE) {
                    unitStr = @"佰";
                }else{
                    unitStr = @"百";
                }
                break;
            case 3:
                if (IS_HIGN_CASE) {
                    unitStr = @"仟";
                }else{
                    unitStr = @"千";
                }
                break;
            case 4:
                unitStr = @"";
                break;
            case 5:
                if (IS_HIGN_CASE) {
                    unitStr = @"拾";
                }else{
                    unitStr = @"十";
                }
                break;
                
            default:
                unitStr = @"..";
                break;
        }
        
        [resultString insertString:[NSString stringWithFormat:@"%@%@",subStr,unitStr]
                           atIndex:0];
    }
    
    return [NSString stringWithString:resultString];
}

+(NSString *)changeNumberChar:(NSString *)number{
    switch (number.intValue) {
        case 0:
            return @"零";
            break;
        case 1:
            if (IS_HIGN_CASE) {
                return @"壹";
            }else{
                return @"一";
            }
            break;
        case 2:
            if (IS_HIGN_CASE) {
                return @"贰";
            }else{
                return @"二";
            }
            break;
        case 3:
            if (IS_HIGN_CASE) {
                return @"叁";
            }else{
                return @"三";
            }
            break;
        case 4:
            if (IS_HIGN_CASE) {
                return @"肆";
            }else{
                return @"四";
            }
            break;
        case 5:
            if (IS_HIGN_CASE) {
                return @"伍";
            }else{
                return @"五";
            }
            break;
        case 6:
            if (IS_HIGN_CASE) {
                return @"陆";
            }else{
                return @"六";
            }
            break;
        case 7:
            if (IS_HIGN_CASE) {
                return @"柒";
            }else{
                return @"七";
            }
            break;
        case 8:
            if (IS_HIGN_CASE) {
                return @"捌";
            }else{
                return @"八";
            }
            break;
        case 9:
            if (IS_HIGN_CASE) {
                return @"玖";
            }else{
                return @"九";
            }
            break;
        default:
            return nil;
            break;
    }
}

@end
