//
//  DBAccess.h
//  sqlitedemo1
//
//  Created by rutger_i on 3/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "GlobalMethods.h"

@interface DBAccess : NSObject{
    GlobalMethods *superMethods;
}

+(NSString *) getDBPath;

+(NSString *)getBundledDBPath;

+(sqlite3 *)openDatabase;

+(int)databaseFromDocumentDirCurrentVersion;

+(int)databaseFromBundleCurrentVersion;

+(void)setDatabaseVersion:(NSString *)version;

+(BOOL)initializeStatement:(sqlite3_stmt **)statement forSQLString:(NSString *)sqlString withDatabase:(sqlite3 *)database;

+(void)closeDatabase:(sqlite3 *)database;

+(void)insertIntoTable:(NSString *)tableName columnName:(NSArray *)arrayColumnName columnData:(NSArray *)arrayColumnData withDatabase:(sqlite3 *)database;

+(void)updateTable:(NSString *)tableName columnName:(NSArray *)arrayColumnName columnData:(NSArray *)arrayColumnData whereClause:(NSString *)strWhereClause withDatabase:(sqlite3 *)database;

+(void)deleteFromTable:(NSString *)tableName whereClause:(NSString *)strWhereClause withDatabase:(sqlite3 *)database;

@end
