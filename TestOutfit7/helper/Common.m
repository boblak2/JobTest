//
//  Common.m
//  TestOutfit7
//
//  Created by Blaz Oblak on 10/12/20.
//  Copyright © 2020 DigiEd d.o.o. All rights reserved.
//

#import "Common.h"
#import "Reachability.h"

@implementation Common

+(void)saveToFile:(NSString *)strData{
    
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //[defaults setObject:strData forKey:@"keyWebSearch"];
    //[defaults synchronize];
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents directory
    NSLog(@"%@", documentsDirectory);

    NSError *error;
    BOOL succeed = [strData writeToFile:[documentsDirectory stringByAppendingPathComponent:@"search.html"]
          atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (!succeed){
        // Handle error here
        NSLog(@"problem");
    }
    
    
}
/*
-(NSData *)dataFromFile{
    
    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSString *documentsDirectory = [paths objectAtIndex:0];
    

    
}
*/

+(NSString *)urlEncode:(NSString *)unencodedString{
    
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[unencodedString UTF8String];
    int sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"%20"]; //[output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

+(BOOL)connected{

    Reachability *internetReachability = [Reachability reachabilityForInternetConnection];

    NetworkStatus status = [internetReachability currentReachabilityStatus];
    
    return status != NotReachable ? YES : NO;
    //return NO;
}

+(BOOL)isDateCorrect:(NSString *)strDate{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"d.M.yyyy"];
    
    NSDate *date = [formatter dateFromString:strDate];
    return date ? YES : NO;
    
}

+(BOOL)isNumber:(NSString *)strNumber{
    
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([strNumber rangeOfCharacterFromSet:notDigits].location == NSNotFound){
        // newString consists only of the digits 0 through 9
        return YES;
    }else{
        return NO;
    }
    
}

@end
