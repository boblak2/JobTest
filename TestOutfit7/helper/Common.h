//
//  Common.h
//  TestOutfit7
//
//  Created by Blaz Oblak on 10/12/20.
//  Copyright © 2020 DigiEd d.o.o. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Common : NSObject

+(void)saveToFile:(NSString *)strData;
+(NSString *)urlEncode:(NSString *)unencodedString;
+(BOOL)connected;
+(BOOL)isDateCorrect:(NSString *)strDate;
+(BOOL)isNumber:(NSString *)strNumber;

@end

NS_ASSUME_NONNULL_END
