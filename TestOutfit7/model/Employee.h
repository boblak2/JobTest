//
//  Employee.h
//  TestOutfit7
//
//  Created by Blaz Oblak on 10/8/20.
//  Copyright © 2020 DigiEd d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Employee : NSObject

@property(nonatomic, assign) int employeeId;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *dateOfBirth;
@property(nonatomic, assign) BOOL isMale;
@property(nonatomic, assign) double salary;

//Helper
@property(nonatomic, strong) NSDate *dateOfBirtAsDateObject;
@property(nonatomic, assign) int years;
@property(nonatomic, assign) long age;

+(NSString *)dateFromEpoch:(long)epoch;

@end

NS_ASSUME_NONNULL_END
