//
//  DBHandler.h
//  TestOutfit7
//
//  Created by Blaz Oblak on 10/8/20.
//  Copyright © 2020 DigiEd d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Employee.h"

NS_ASSUME_NONNULL_BEGIN

@interface DBHandler : NSObject


+(id) getInstance;
-(BOOL)addEmployee:(Employee *)employee;
-(NSMutableArray *)employees;

@end

NS_ASSUME_NONNULL_END
