//
//  DBHandler.m
//  TestOutfit7
//
//  Created by Blaz Oblak on 10/8/20.
//  Copyright © 2020 DigiEd d.o.o. All rights reserved.
//

#import "DBHandler.h"

@implementation DBHandler{
    
    sqlite3 *dataBase;
    
    NSString *databasePath;
    
    sqlite3_stmt *statement;
    
}

-(instancetype)init{
    
    self = [super init];
    if (self) {
        
        [self createDB];
        [self openDB];
        
    }
    return self;
}

+(id) getInstance{
    
    static DBHandler *sharedInstance = nil;
    
    @synchronized(self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    }
    
    return sharedInstance;
}

-(BOOL)createDB{
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0]; //dirPaths[0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"outfit7.db"]];
    
    BOOL isSuccess = YES;
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: databasePath ] == NO){
        
        const char *dbpath = [databasePath UTF8String];
        
        //Create db
        if (sqlite3_open(dbpath, &dataBase) == SQLITE_OK){
            
            char *errMsg;
            
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS employees (id_employee INTEGER PRIMARY KEY, name TEXT, date_of_birth TEXT, gender INTEGER, salary REAL)";
            
            if (sqlite3_exec(dataBase, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK){
                isSuccess = NO;
            }
            
            sqlite3_close(dataBase);
            return  isSuccess;
            
        }else {
            
            isSuccess = NO;
            
        }
    }
    
    
    return isSuccess;
}

-(BOOL) openDB{
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &dataBase)==SQLITE_OK) {
        
        //NSLog(@"DB opened");
        return YES;
        
    }else{
        
        //NSLog(@"DB not opened");
        return NO;
        
    }
}


-(BOOL)addEmployee:(Employee *)employee{
    
    NSString *insertSQL = [NSString stringWithFormat:@"insert into employees (name, date_of_birth, gender, salary) values ('%@', '%@', %d, %f)",
                           employee.name,
                           employee.dateOfBirth,
                           (employee.isMale ? 1 : 0),
                           employee.salary];
    
    const char *insert_stmt = [insertSQL UTF8String];
    
    sqlite3_prepare_v2(dataBase, insert_stmt, -1, &statement, NULL);
    
    if (sqlite3_step(statement) == SQLITE_DONE){
        
        sqlite3_reset(statement);//blaz dodal
        return YES;
        
    }else {
        
        return NO;
        
    }
    
}

//(id_employee INTEGER PRIMARY KEY, name TEXT, date_of_birth TEXT, gender INTEGER, salary TEXT)
-(NSMutableArray *)employees{
    
    NSMutableArray *employeesArr = [NSMutableArray array];
    
    NSString *query = @"SELECT * FROM employees";
    
    if (sqlite3_prepare_v2(dataBase, [query UTF8String], -1, &statement, nil)==SQLITE_OK) {
        
        while (sqlite3_step(statement)==SQLITE_ROW) {
            
            int i_id = sqlite3_column_int(statement, 0);
            char *c_name = (char *) sqlite3_column_text(statement, 1);
            char *c_dateOfBirth = (char *) sqlite3_column_text(statement, 2);
            int i_gender = sqlite3_column_int(statement, 3);
            double d_salary = sqlite3_column_double(statement, 4);
            
            Employee *employee = [[Employee alloc] init];
            employee.employeeId = i_id;
            employee.name = [[NSString alloc] initWithUTF8String:c_name];
            employee.dateOfBirth = [[NSString alloc] initWithUTF8String:c_dateOfBirth];
            employee.isMale = i_gender != 0 ? 1 : 0;
            employee.salary = d_salary;
            
            [employeesArr addObject:employee];
            
        }
        //blaz
        sqlite3_reset(statement);
        
    }
    
    return employeesArr;
    
}

@end
