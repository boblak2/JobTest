//
//  Employee.m
//  TestOutfit7
//
//  Created by Blaz Oblak on 10/8/20.
//  Copyright © 2020 DigiEd d.o.o. All rights reserved.
//

#import "Employee.h"

@implementation Employee

-(NSDate *)dateOfBirtAsDateObject{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"d.M.yyyy"];
    
    NSDate *date = [formatter dateFromString:_dateOfBirth];
    
    return date;
}

-(int)years{
    
    NSDate *now = [NSDate date];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"d.M.yyyy"];
    
    NSDate *dateOfBirth = [formatter dateFromString:_dateOfBirth];
    
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
     
    // pass as many or as little units as you like here, separated by pipes
    NSUInteger units = NSCalendarUnitYear | NSCalendarUnitDay | NSCalendarUnitMonth;
     
    NSDateComponents *components = [gregorian components:units fromDate:dateOfBirth toDate:now options:0];
     
    NSInteger years = [components year];
    NSInteger months = [components month];
    NSInteger days = [components day];
    
    NSLog(@"years:%ld months:%ld days:%ld", (long)years, (long)months, (long)days);
    
    return 0;
    
}

-(long)age{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"d.M.yyyy"];
    
    NSDate *date = [formatter dateFromString:_dateOfBirth];
    
    return [date timeIntervalSince1970];
    
}

+(NSString *)dateFromEpoch:(long)epoch{
    
    NSDate *now = [NSDate date];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"d.M.yyyy"];
    
    //NSDate *dateOfBirth = [formatter dateFromString:_dateOfBirth];
    NSDate *dateOfBirth = [NSDate dateWithTimeIntervalSince1970:epoch];
    
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
     
    // pass as many or as little units as you like here, separated by pipes
    NSUInteger units = NSCalendarUnitYear | NSCalendarUnitDay | NSCalendarUnitMonth;
     
    NSDateComponents *components = [gregorian components:units fromDate:dateOfBirth toDate:now options:0];
     
    NSInteger years = [components year];
    NSInteger months = [components month];
    NSInteger days = [components day];
    
    NSString *strDate = [NSString stringWithFormat:@"years:%ld months:%ld days:%ld",
                         (long)years, (long)months, (long)days];
    
    return strDate;
}

@end
