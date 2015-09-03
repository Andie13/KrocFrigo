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
- (NSArray *) getIngredientsDansFrigo;
- (NSArray*)GetRecipesByType:(NSInteger )idRecipeType;
- (NSArray*)getCat;
-(NSArray*)getIngrediantsFromCat:(int)id_cat;
-(void)setfoodInTheFridge:(NSInteger)id_aliment qnt:(NSString*)qnt id_um:(NSInteger)id_um;
-(void)DeleteAlimentsDansFrigo:(NSInteger)id_aliment;
-(NSArray*)getRecepies;
- (NSArray*) getIngredientsFromRecipe :(NSInteger) idRecette;
-(int)numberOgInginTheFridge:(NSInteger)idAlim;
-(NSArray*) getRecipesByStock;
- (NSArray*)GetRecipesBylass:(NSString *)classeRecette;
- (NSArray*)GetRecipesWithoutPork:(NSString *)classeRecette;



@end
