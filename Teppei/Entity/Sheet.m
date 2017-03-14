//
//  Sheet.m
//  Teppei
//
//  Created by levanha711 on 2017/03/13.
//  Copyright © 2017 Welico. All rights reserved.
//

#import "Sheet.h"

@implementation Sheet

- (instancetype)initSheetWithDictionary:(NSDictionary *)sheetDic {
    self = [super init];
    if (self) {
        @try {
            _id = [sheetDic objectForKey:@"objectId"];
            _name = [sheetDic objectForKey:@"name"];
            _isActive = [sheetDic objectForKey:@"isActive"];
        } @catch (NSException *exception) {
            //none
        } @finally {
            //none
        }
    }
    return self;
}

@end
