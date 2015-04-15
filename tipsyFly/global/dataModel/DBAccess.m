//
//  DBAccess.m
//  sqlitedemo1
//
//  Created by rutger_i on 3/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DBAccess.h"

@implementation DBAccess

#pragma mark Class functions

+(NSString *)getDBPath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
    
//    GlobalMethods *superMethods = [[GlobalMethods alloc]init];
//    NSMutableDictionary *data = [superMethods loadJSONDataFromFile:keyGlobalValuesJSON];
    
    return [documentsDir stringByAppendingPathComponent:@"tipsyFly.sqlite"];
}

+(NSString *)getBundledDBPath {
    
//    GlobalMethods *superMethods = [[GlobalMethods alloc]init];
//    NSMutableDictionary *data = [superMethods loadJSONDataFromFile:keyGlobalValuesJSON];
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"tipsyFly.sqlite"];
    
    return defaultDBPath;
}

+(sqlite3 *)openDatabase{
    
    sqlite3 *database;
    sqlite3_open([[DBAccess getDBPath] UTF8String], &database);
    
    return database;
}

+(int)databaseFromDocumentDirCurrentVersion{
    
    sqlite3 *database;
    
    sqlite3_open([[DBAccess getDBPath]UTF8String], &database);
    
    static sqlite3_stmt *stmt_version;
    int databaseVersion = 0;
    
    if(sqlite3_prepare_v2(database, "PRAGMA user_version;", -1, &stmt_version, NULL) == SQLITE_OK) {
        while(sqlite3_step(stmt_version) == SQLITE_ROW) {
            databaseVersion = sqlite3_column_int(stmt_version, 0);
        }
//        NSLog(@"%s: the databaseVersion is: %d", __FUNCTION__, databaseVersion);
    } else {
        NSLog(@"%s: ERROR Preparing: , %s", __FUNCTION__, sqlite3_errmsg(database) );
    }
    sqlite3_finalize(stmt_version);
    
    return databaseVersion;
}

+(int)databaseFromBundleCurrentVersion{
    
    sqlite3 *database;
    
    sqlite3_open([[DBAccess getBundledDBPath]UTF8String], &database);
    
    static sqlite3_stmt *stmt_version;
    int databaseVersion = 0;
    
    if(sqlite3_prepare_v2(database, "PRAGMA user_version;", -1, &stmt_version, NULL) == SQLITE_OK) {
        while(sqlite3_step(stmt_version) == SQLITE_ROW) {
            databaseVersion = sqlite3_column_int(stmt_version, 0);
        }
//        NSLog(@"%s: the databaseVersion is: %d", __FUNCTION__, databaseVersion);
    } else {
        NSLog(@"%s: ERROR Preparing: , %s", __FUNCTION__, sqlite3_errmsg(database) );
    }
    sqlite3_finalize(stmt_version);
    
    return databaseVersion;
}

+(void)setDatabaseVersion:(NSString *)version{
    
    sqlite3 *database;
    
    sqlite3_open([[DBAccess getDBPath]UTF8String], &database);
    
    static sqlite3_stmt *stmt_version;
    int databaseVersion = 0;
    NSString *strSql = [NSString stringWithFormat:@"PRAGMA user_version = %@ ;",version];
    
    if(sqlite3_prepare_v2(database, [strSql UTF8String], -1, &stmt_version, NULL) == SQLITE_OK) {
        while(sqlite3_step(stmt_version) == SQLITE_ROW) {
            databaseVersion = sqlite3_column_int(stmt_version, 0);
        }
//        NSLog(@"%s: the databaseVersion is: %d", __FUNCTION__, databaseVersion);
    } else {
        NSLog(@"%s: ERROR Preparing: , %s", __FUNCTION__, sqlite3_errmsg(database) );
    }
    sqlite3_finalize(stmt_version);
    
}

/* This Method is made as global to utilize it at needed place. This initializes the the SQL statements. */
+(BOOL)initializeStatement:(sqlite3_stmt **)statement forSQLString:(NSString *)sqlString withDatabase:(sqlite3 *)database{
    if(sqlite3_prepare_v2(database, [sqlString UTF8String], -1, statement, NULL) == SQLITE_OK)
    {
        return YES;
    }else{
        
        return NO;
    }
}


/* This Method is made as global to utilize it at needed place. This closes the database. */
+(void)closeDatabase:(sqlite3 *)database{
    
    if (sqlite3_close(database) != SQLITE_OK)
	{
        NSAssert1(0, @"Error: failed to close database with message '%s'.", sqlite3_errmsg(database));
    }
}

/* This Method is made as global to utilize it at needed place. This updates the the value of a columns in the table in the database */
+(void)updateTable:(NSString *)tableName columnName:(NSArray *)arrayColumnName columnData:(NSArray *)arrayColumnData whereClause:(NSString *)strWhereClause withDatabase:(sqlite3 *)database{
    
    sqlite3_stmt *statement = NULL;
    NSMutableString *columnNameAndData = [[NSMutableString alloc]init];
    
    for (int i =0; i< [arrayColumnData count]; i++) {
        
        [columnNameAndData appendString:arrayColumnName[i]];
        [columnNameAndData appendString:@"="];
        
        if ([arrayColumnData[i] isKindOfClass:[NSNumber class]]) {
            
            [columnNameAndData appendString:[NSString stringWithFormat:@"%@",arrayColumnData[i]]];
            
        }else if ([arrayColumnData[i] isKindOfClass:[NSString class]]){
            
            [columnNameAndData appendString:@"\""];
            [columnNameAndData appendString:arrayColumnData[i]];
            [columnNameAndData appendString:@"\""];
            
        }
        
        if (i != [arrayColumnData count] - 1) {
            
            [columnNameAndData appendString:@", "];
            
        }
        
    }
    
    NSString *strSQL;
    if (strWhereClause != Nil) {
        strSQL = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@",tableName,columnNameAndData,strWhereClause];
    }else{
        strSQL = [NSString stringWithFormat:@"UPDATE %@ SET %@",tableName,columnNameAndData];
    }
    
    if([DBAccess initializeStatement:&statement forSQLString:strSQL withDatabase:database])
    {
        if(sqlite3_step(statement) != SQLITE_DONE){
            
            NSLog(@"Record Not Updated in table %@",tableName);
        }
        sqlite3_finalize(statement);
    }else{
        printf( "could not prepare update statemnt: %s\n", sqlite3_errmsg(database) );
    }
}

/* This Method is made as global to utilize it at needed place. This inserts the the value for a columns in the table in the database */
+(void)insertIntoTable:(NSString *)tableName columnName:(NSArray *)arrayColumnName columnData:(NSArray *)arrayColumnData withDatabase:(sqlite3 *)database{
    
    sqlite3_stmt *statement = NULL;
    
    NSMutableString *columnName = [[NSMutableString alloc]init];
    NSMutableString *columnData = [[NSMutableString alloc]init];
    
    for (int i =0; i< [arrayColumnName count]; i++) {
        
        [columnName appendString:arrayColumnName[i]];
        
        if (i != [arrayColumnName count] - 1) {
            
            [columnName appendString:@","];
            
        }
        
    }
    
    for (int i =0; i< [arrayColumnData count]; i++) {
        
        if ([arrayColumnData[i] isKindOfClass:[NSNumber class]]) {
            
            [columnData appendString:[NSString stringWithFormat:@"%@",arrayColumnData[i]]];
            
        }else if ([arrayColumnData[i] isKindOfClass:[NSString class]]){
            
            [columnData appendString:@"\""];
            [columnData appendString:arrayColumnData[i]];
            [columnData appendString:@"\""];
            
        }
        
        if (i != [arrayColumnData count] - 1) {
            
            [columnData appendString:@","];
            
        }
        
    }
    
    NSString *strSQL = [NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES(%@)",tableName,columnName,columnData];
    
    if([DBAccess initializeStatement:&statement forSQLString:strSQL withDatabase:database])
    {
        if(sqlite3_step(statement) != SQLITE_DONE){
            
            NSLog(@"Record Not Inserted in table %@",tableName);
        }
        sqlite3_finalize(statement);
    }else{
        printf( "could not prepare insert statemnt: %s\n", sqlite3_errmsg(database) );
    }
    
    
}

/* This Method is made as global to utilize it at needed place. This deletes the the value in the database */

+(void)deleteFromTable:(NSString *)tableName whereClause:(NSString *)strWhereClause withDatabase:(sqlite3 *)database{
    sqlite3_stmt *statement = NULL;
    
    NSString *strSQL;
    if (strWhereClause != Nil) {
        strSQL = [NSString stringWithFormat:@"DELETE FROM %@ WHERE %@",tableName,strWhereClause];
    }else{
        strSQL = [NSString stringWithFormat:@"DELETE FROM %@",tableName];
    }
    
    if ([DBAccess initializeStatement:&statement forSQLString:strSQL withDatabase:database]) {
        
        if(sqlite3_step(statement) != SQLITE_DONE){
            
            NSLog(@"Records Not Deleted with Query %@",strSQL);
            
        }
        sqlite3_finalize(statement);
        
    }else{
        
        printf( "could not prepare delete statemnt: %s\n", sqlite3_errmsg(database) );
    }
    
}

@end
