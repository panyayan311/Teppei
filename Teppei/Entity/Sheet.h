//
//  Sheet.h
//  Teppei
//
//  Created by levanha711 on 2017/03/13.
//  Copyright © 2017 Welico. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sheet : NSObject

@property (strong, nonatomic) NSString *id;
@property (nonatomic) NSString *isActive;
@property (strong, nonatomic) NSString *name;

- (instancetype)initSheetWithDictionary:(NSDictionary *)sheetDic;

@end
