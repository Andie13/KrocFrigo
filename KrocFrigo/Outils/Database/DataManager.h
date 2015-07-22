//
//  DataManager.h
//
//  Created by Simon Fage on 28/09/12.
//  Copyright (c) 2011 Voxinzebox All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FMDatabase.h"
#import "FMDB.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabaseQueue.h"

#import "Ingredients.h"

@interface DataManager : NSObject {
    
 FMDatabase *database;
}



@property (nonatomic, retain) FMDatabase *database;

@property (nonatomic, retain) NSString *documentDirectory;
@property (nonatomic, retain) NSString *cacheDirectory;
@property (nonatomic, retain) NSString *tempDirectory;

+ (DataManager *)sharedDataManager;
- (NSArray *) getIngredientsDansFrigo:(int)id_aliment;
-(NSArray*) getNomIngPicker;
-(NSArray*) getNomQntPicker;
-(NSArray*) getNomUnitePicker;
- (NSArray*)getCat;


@end
