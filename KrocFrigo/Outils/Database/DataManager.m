//
//  DataManager.m
//
//  Created by Simon Fage on 28/09/12.
//  Copyright (c) Voxinzebox All rights reserved.
//

#import "DataManager.h"
#import "SynthesizeSingleton.h"
#import "AppDelegate.h"
#import "Ingredients.h"

@implementation DataManager


@synthesize database;

@synthesize documentDirectory;
@synthesize cacheDirectory;
@synthesize tempDirectory;


SYNTHESIZE_SINGLETON_FOR_CLASS(DataManager);

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

#pragma mark - Initialization
- (id)init  {
    
    self = [super init];
    if (self) {
        
        /*BOOL success;
         NSFileManager *fileManager = [NSFileManager defaultManager];
         NSError *error;
         
         NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
         documentDirectory = [[NSString alloc] initWithString:[paths objectAtIndex:0]];
         
         paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
         cacheDirectory = [[NSString alloc] initWithString:[paths objectAtIndex:0]];
         
         tempDirectory = [[NSString alloc] initWithString:NSTemporaryDirectory()];
         
         NSString *writableDBPath = [documentDirectory stringByAppendingPathComponent:@"clermont-ferrand.sqlite"];
         success = [fileManager fileExistsAtPath:writableDBPath];
         
         // si la base de données n'existe pas, on copie celle qui est stockée dans le bundle
         if(!success)
         {
         NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"clermont-ferrand.sqlite"];
         success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
         NSLog(@"database copy in document directory");
         }*/
        
        NSString *databasePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"kroc_db.sqlite"];
        database = [FMDatabase databaseWithPath:databasePath];
//
   //     if (database ) {
//            NSLog(@"found");
//        }->ok
        
        
  
    }
    
    return self;
}


- (NSArray *) getIngredientsDansFrigo: (int)id_aliment{
    
    NSMutableArray *ingredients = [NSMutableArray new];
    [self.database open];
    
   NSString *condidionIngredients = id_aliment == 0 ? @"" : [NSString stringWithFormat:@" WHERE adf.id_aliment = %d", id_aliment];
    
    NSString* query = [NSString stringWithFormat:@"select  a.nom_aliment from aliments_dans_frigo adf join Aliments a on adf.id_aliment = a.id_aliment %@",condidionIngredients];
    
    FMResultSet *resultSet = [self.database executeQuery:query];
    while ([resultSet next]) {
        
        Ingredients *ingredient = [Ingredients new];
        
        ingredient.nom_aliment = [resultSet stringForColumnIndex:0];
        
               [ingredients addObject:ingredient];
        
    }
    
    if ([self.database hadError]) {
        NSLog(@"Database error: %@", [self.database lastErrorMessage]);
    }
    
    [resultSet close];
    [self.database close];
    
    return ingredients;

}
-(NSArray *)getCat{
    NSMutableArray *cat = [NSMutableArray new];
    [self.database open];
    
    NSString* query = [NSString stringWithFormat:@"select id_classe, classe from classes_aliments"];
    
    FMResultSet *resultSet = [self.database executeQuery:query];
    while ([resultSet next]) {
        Ingredients *i = [Ingredients new];
        i.id_cat = [resultSet intForColumnIndex:0];
        i.nom_classeAlim = [resultSet stringForColumnIndex:1];
        
        [cat addObject:i];
        NSLog(@"nom cat %@",i.nom_classeAlim);
    }
    [resultSet close];
    [self.database close];
    
    return cat;
    
    
}
- (NSArray *) getIngrediantsFromCat:(int)id_cat{
    
    NSMutableArray *ingredients = [NSMutableArray new];
    [self.database open];
    
    NSString *condiIdCat = id_cat == 0 ? @"" : [NSString stringWithFormat:@" WHERE c.id_classe = %d", id_cat];
    
    NSString* query = [NSString stringWithFormat:@"SELECT a.id_aliment, a.nom_aliment,c.classe FROM Aliments a JOIN classes_aliments c ON a.classe_aliments = c.id_classe %@",condiIdCat];
    
    FMResultSet *resultSet = [self.database executeQuery:query];
    while ([resultSet next]) {
        
        Ingredients *ingredient = [Ingredients new];
        
        ingredient.nom_classeAlim = [resultSet stringForColumnIndex:0
                                  ];
        
        
        [ingredients addObject:ingredient];
        
    }
    
    if ([self.database hadError]) {
        NSLog(@"Database error: %@", [self.database lastErrorMessage]);
    }
    
    [resultSet close];
    [self.database close];
    
    return ingredients;
    
}

@end
