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
    
    [Tools initializeLanguage];
    
    NSString *databasePath = [Tools getBundleFilePath:@"stquentin" type:@"db" directory:NO];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:databasePath]) {
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:databasePath];
    }
}

- (NSArray *)getPOI {
    
    __block NSMutableArray *res = [NSMutableArray array];
    
    [self.dbQueue inDatabase:^(FMDatabase *database) {
        
        NSString *query = @"SELECT id, nom, ordre, numero, latitude, longitude FROM POI LEFT OUTER JOIN POI_LANGUE ON id = id_poi WHERE langue = ? ORDER BY ordre";
        
        FMResultSet *rs = [database executeQuery:query, [[Tools getCurrentLanguage] uppercaseString]];
        
        while ([rs next]) {
            
            POI *p = [[POI alloc] init];
            p.idPOI = [rs intForColumn:@"id"];
            p.name = [rs stringForColumn:@"nom"];
            p.order = [rs intForColumn:@"ordre"];
            p.number = [rs intForColumn:@"numero"];
            p.latitude = [rs doubleForColumn:@"latitude"];
            p.longitude = [rs doubleForColumn:@"longitude"];
            [res addObject:p];
        }
        
        if ([database hadError]) {
            NSLog(@"getPOI %@", [database lastErrorMessage]);
        }
        
        [rs close];
        rs = nil;
    }];
    
    return  res;
}

- (POI *)getPOI:(int)idPOI {
    
    __block POI *p = nil;
    
    [self.dbQueue inDatabase:^(FMDatabase *database) {
        
        NSString *query = @"SELECT id, nom, ordre, numero, latitude, longitude FROM POI LEFT OUTER JOIN POI_LANGUE ON id = id_poi WHERE langue = ? AND id = ?";
        
        FMResultSet *rs = [database executeQuery:query, [[Tools getCurrentLanguage] uppercaseString], [NSNumber numberWithInt:idPOI]];
        
        while ([rs next]) {
            
            p = [[POI alloc] init];
            p.idPOI = [rs intForColumn:@"id"];
            p.name = [rs stringForColumn:@"nom"];
            p.order = [rs intForColumn:@"ordre"];
            p.number = [rs intForColumn:@"numero"];
            p.latitude = [rs doubleForColumn:@"latitude"];
            p.longitude = [rs doubleForColumn:@"longitude"];
        }
        
        if ([database hadError]) {
            NSLog(@"getPOI %@", [database lastErrorMessage]);
        }
        
        [rs close];
        rs = nil;
    }];
    
    return p;
}

- (int)getIdProchainPOI {
    
    __block int idPOI = 0;
    
    [self.dbQueue inDatabase:^(FMDatabase *database) {
        
        NSString *query = @"SELECT id FROM POI WHERE termine = 0 ORDER BY ordre LIMIT 1";
        
        FMResultSet *rs = [database executeQuery:query, [[Tools getCurrentLanguage] uppercaseString]];
        
        while ([rs next]) {
            
            idPOI = [rs intForColumn:@"id"];
        }
        
        if ([database hadError]) {
            NSLog(@"getIdProchainPOI %@", [database lastErrorMessage]);
        }
        
        [rs close];
        rs = nil;
    }];
    
    return  idPOI;
}

- (NSArray *)getMedias:(int)idPOI {
    
    __block NSMutableArray *res = [NSMutableArray array];
    
    [self.dbQueue inDatabase:^(FMDatabase *database) {
        
        NSString *query = @"SELECT id, titre, texte, adresse, type_media, latitude, longitude, principal, debloque FROM MEDIA LEFT OUTER JOIN MEDIA_LANGUE ON id = id_media WHERE id_poi = ? AND langue = ? ORDER BY principal, ordre";
        
        FMResultSet *rs = [database executeQuery:query, [NSNumber numberWithInt:idPOI], [[Tools getCurrentLanguage] uppercaseString]];
        
        while ([rs next]) {
            
            Media *m = [[Media alloc] init];
            m.idMedia = [rs intForColumn:@"id"];
            m.title = [rs stringForColumn:@"titre"];
            m.text = [rs stringForColumn:@"texte"];
            m.address = [rs stringForColumn:@"adresse"];
            m.typeMedia = [rs intForColumn:@"type_media"];
            m.latitude = [rs doubleForColumn:@"latitude"];
            m.longitude = [rs doubleForColumn:@"longitude"];
            m.principal = [rs intForColumn:@"principal"] ? YES : NO;
            m.debloque = [rs intForColumn:@"debloque"] ? YES : NO;
            [res addObject:m];
        }
        
        if ([database hadError]) {
            NSLog(@"getMedias %@", [database lastErrorMessage]);
        }
        
        [rs close];
        rs = nil;
    }];
    
    return  res;
}

- (NSArray *)getMediasPrincipaux:(int)idPOI {
    
    __block NSMutableArray *res = [NSMutableArray array];
    
    [self.dbQueue inDatabase:^(FMDatabase *database) {
        
        NSString *query = @"SELECT id, titre, texte, adresse, type_media, latitude, longitude, principal, debloque FROM MEDIA LEFT OUTER JOIN MEDIA_LANGUE ON id = id_media WHERE id_poi = ? AND langue = ? AND principal = 1 AND debloque = 0 ORDER BY ordre";
        
        FMResultSet *rs = [database executeQuery:query, [NSNumber numberWithInt:idPOI], [[Tools getCurrentLanguage] uppercaseString]];
        
        while ([rs next]) {
            
            Media *m = [[Media alloc] init];
            m.idMedia = [rs intForColumn:@"id"];
            m.title = [rs stringForColumn:@"titre"];
            m.text = [rs stringForColumn:@"texte"];
            m.address = [rs stringForColumn:@"adresse"];
            m.typeMedia = [rs intForColumn:@"type_media"];
            m.latitude = [rs doubleForColumn:@"latitude"];
            m.longitude = [rs doubleForColumn:@"longitude"];
            m.principal = [rs intForColumn:@"principal"] ? YES : NO;
            m.debloque = [rs intForColumn:@"debloque"] ? YES : NO;
            [res addObject:m];
        }
        
        if ([database hadError]) {
            NSLog(@"getMediasPrincipaux %@", [database lastErrorMessage]);
        }
        
        [rs close];
        rs = nil;
    }];
    
    return  res;
}

- (NSArray *)getMediasSecondaires:(int)idPOI {
    
    __block NSMutableArray *res = [NSMutableArray array];
    
    [self.dbQueue inDatabase:^(FMDatabase *database) {
        
        NSString *query = @"SELECT id, titre, texte, adresse, type_media, latitude, longitude, principal, debloque FROM MEDIA LEFT OUTER JOIN MEDIA_LANGUE ON id = id_media WHERE id_poi = ? AND langue = ? AND principal = 0 AND debloque = 0 ORDER BY ordre";
        
        FMResultSet *rs = [database executeQuery:query, [NSNumber numberWithInt:idPOI], [[Tools getCurrentLanguage] uppercaseString]];
        
        while ([rs next]) {
         
            Media *m = [[Media alloc] init];
            m.idMedia = [rs intForColumn:@"id"];
            m.title = [rs stringForColumn:@"titre"];
            m.text = [rs stringForColumn:@"texte"];
            m.address = [rs stringForColumn:@"adresse"];
            m.typeMedia = [rs intForColumn:@"type_media"];
            m.latitude = [rs doubleForColumn:@"latitude"];
            m.longitude = [rs doubleForColumn:@"longitude"];
            m.principal = [rs intForColumn:@"principal"] ? YES : NO;
            m.debloque = [rs intForColumn:@"debloque"] ? YES : NO;
            [res addObject:m];
        }
        
        if ([database hadError]) {
            NSLog(@"getMediasSecondaires %@", [database lastErrorMessage]);
        }
        
        [rs close];
        rs = nil;
    }];
    
    return  res;
}

- (Media *)getMedia:(int)idMedia {
    
    __block Media *m = nil;
    
    [self.dbQueue inDatabase:^(FMDatabase *database) {
        
        NSString *query = @"SELECT id, titre, texte, adresse, type_media, latitude, longitude, principal, debloque FROM MEDIA LEFT OUTER JOIN MEDIA_LANGUE ON id = id_media WHERE id = ? AND langue = ? ORDER BY principal, ordre";
        
        FMResultSet *rs = [database executeQuery:query, [NSNumber numberWithInt:idMedia], [[Tools getCurrentLanguage] uppercaseString]];
        
        while ([rs next]) {
            
            m = [[Media alloc] init];
            m.idMedia = [rs intForColumn:@"id"];
            m.title = [rs stringForColumn:@"titre"];
            m.text = [rs stringForColumn:@"texte"];
            m.address = [rs stringForColumn:@"adresse"];
            m.typeMedia = [rs intForColumn:@"type_media"];
            m.latitude = [rs doubleForColumn:@"latitude"];
            m.longitude = [rs doubleForColumn:@"longitude"];
            m.principal = [rs intForColumn:@"principal"] ? YES : NO;
            m.debloque = [rs intForColumn:@"debloque"] ? YES : NO;
        }
        
        if ([database hadError]) {
            NSLog(@"getMedia %@", [database lastErrorMessage]);
        }
        
        [rs close];
        rs = nil;
    }];
    
    return  m;
}

- (void)setMediaAsUnlock:(int)idMedia {
    
    [self.dbQueue inDatabase:^(FMDatabase *database) {
        
        NSString *query = @"UPDATE MEDIA SET debloque = 1 WHERE id = ?;";
        FMResultSet *rs = [database executeQuery:query, [NSNumber numberWithInt:idMedia]];
        
        if ([database hadError]) {
            NSLog(@"setMediaAsUnlock %@", [database lastErrorMessage]);
        }
        
        [rs close];
        rs = nil;
    }];
}

- (void)setPOIAsFinished:(int)idPOI {
    
    [self.dbQueue inDatabase:^(FMDatabase *database) {
        
        NSString *query = @"UPDATE POI SET termine = 1 WHERE id = ?;";
        FMResultSet *rs = [database executeQuery:query, [NSNumber numberWithInt:idPOI]];
        
        if ([database hadError]) {
            NSLog(@"setPOIAsFinished %@", [database lastErrorMessage]);
        }
        
        [rs close];
        rs = nil;
    }];
}

- (void)clearAlbum {
    
    [self.dbQueue inDatabase:^(FMDatabase *database) {
        
        NSString *query = @"UPDATE MEDIA SET debloque = 0;";
        FMResultSet *rs = [database executeQuery:query];
        
        if ([database hadError]) {
            NSLog(@"clearAlbum %@", [database lastErrorMessage]);
        }
        
        [rs close];
        rs = nil;
    }];
}

- (NSArray *)getPersonnages {
    
    __block NSMutableArray *res = [NSMutableArray array];
    
    [self.dbQueue inDatabase:^(FMDatabase *database) {
        
        NSString *query = @"SELECT id, nom FROM PERSONNAGE";
        FMResultSet *rs = [database executeQuery:query];
        
        while ([rs next]) {
            
            NSDictionary *p = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:[rs intForColumn:@"id"]], @"id", [rs stringForColumn:@"nom"], @"nom", nil];
            [res addObject:p];
        }
        
        if ([database hadError]) {
            NSLog(@"getPersonnages %@", [database lastErrorMessage]);
        }
        
        [rs close];
        rs = nil;
    }];
    
    return  res;
}

@end
