//
//  DataManager.m
//
//  Created by Simon Fage on 28/09/12.
//  Copyright (c) Voxinzebox All rights reserved.
//

#import "DataManager.h"
#import "SynthesizeSingleton.h"
#import "AppDelegate.h"

@implementation DataManager

SYNTHESIZE_SINGLETON_FOR_CLASS(DataManager);

- (void) dealloc {
    _dbQueue = nil;
}

- (id)init  {
    
    self = [super init];
    if (self) {
        [self initiliaze];
    }
    return self;
}

- (void)addCustomFunctions:(sqlite3 *)db {
    
    if (sqlite3_create_function_v2(db, "unaccented", 1, SQLITE_ANY, NULL, &unaccented, NULL, NULL, NULL) != SQLITE_OK) {
        NSLog(@"%s: sqlite3_create_function_v2 error: %s", __FUNCTION__, sqlite3_errmsg(db));
    }
}

void unaccented(sqlite3_context *context, int argc, sqlite3_value **argv) {
    
    if (argc != 1 || sqlite3_value_type(argv[0]) != SQLITE_TEXT) {
        sqlite3_result_null(context);
        return;
    }
    
    @autoreleasepool {
        NSMutableString *string = [NSMutableString stringWithUTF8String:(const char *)sqlite3_value_text(argv[0])];
        CFStringTransform((__bridge CFMutableStringRef)string, NULL, kCFStringTransformStripCombiningMarks, NO);
        sqlite3_result_text(context, [string UTF8String], -1, SQLITE_TRANSIENT);
    }
}

- (void)initiliaze {
    

    NSString *databasePath = [[NSBundle mainBundle] pathForResource:@"nom_base" ofType:@"extension" inDirectory:nil];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:databasePath]) {
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:databasePath];
    }
}


@end
