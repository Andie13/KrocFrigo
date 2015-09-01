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
#import "Recipes.h"

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
        
        BOOL success;
         NSFileManager *fileManager = [NSFileManager defaultManager];
         NSError *error;
         
         NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
         documentDirectory = [[NSString alloc] initWithString:[paths objectAtIndex:0]];
         
         paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
         cacheDirectory = [[NSString alloc] initWithString:[paths objectAtIndex:0]];
         
         tempDirectory = [[NSString alloc] initWithString:NSTemporaryDirectory()];
         
         NSString *writableDBPath = [documentDirectory stringByAppendingPathComponent:@"kroc_db.sqlite"];
         success = [fileManager fileExistsAtPath:writableDBPath];
         
         // si la base de données n'existe pas, on copie celle qui est stockée dans le bundle
         if(!success)
         {
         NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"kroc_db.sqlite"];
         success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
         NSLog(@"database copy in document directory");
         }
        
        //NSString *databasePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"kroc_db.sqlite"];
        database = [FMDatabase databaseWithPath:writableDBPath];
        
        

        if (database ) {
         NSLog(@"found");      }
        
        
  
    }
    
    return self;
}

// récupérer recettes
- (NSArray *) getRecepies{
    
    NSMutableArray *recettes = [NSMutableArray new];
    [self.database open];
    
    NSString* query = [NSString stringWithFormat:@"SELECT r.id_recette,r.nom_recette,tr.type_recette,r.description_recette,r.temps_prepa_recette,r.nbre_couverts_recette FROM recettes r join aliments_recette ar on r.id_recette = ar.id_recette join type_recettes tr on r.type_recette = tr.id_type  group by r.id_recette order by random()"];
    
    FMResultSet *resultSet = [self.database executeQuery:query];
    while ([resultSet next]) {
        
        Recipes *rec = [Recipes new];
        
        rec.idRecette = [resultSet intForColumnIndex:0];
        rec.nomRecette =[resultSet stringForColumnIndex:1];
        rec.type_recette = [resultSet stringForColumnIndex:2];
        rec.descriptionRecette = [resultSet stringForColumnIndex:3];
        rec.tempsPrepaRecette = [resultSet stringForColumnIndex:4];
        rec.nbreCouvertsRecette = [resultSet stringForColumnIndex:5];
        
               [recettes addObject:rec];
        
    }
    
    if ([self.database hadError]) {
        NSLog(@"Database error: %@", [self.database lastErrorMessage]);
    }
    
    [resultSet close];
    [self.database close];
    
    return recettes;

}

- (NSArray*) getIngredientsFromRecipe :(NSInteger) idRecette{
    
    NSString *condotionRecette = idRecette == 0 ? @"" : [NSString stringWithFormat:@"AND r.id_recette = %ld", (long)idRecette];
    
    
    NSMutableArray *ingredients = [NSMutableArray new];
    [self.database open];
    
    NSString* query = [NSString stringWithFormat:@"SELECT a.nom_aliment, ar.qnt_aliment, ar.id_aliment FROM Aliments a , recettes r, aliments_recette ar WHERE  a.id_aliment = ar.id_aliment AND ar.id_recette = r.id_recette %@",condotionRecette];

    
    FMResultSet *resultSet = [self.database executeQuery:query];
    while ([resultSet next]) {
        
        Ingredients *al = [Ingredients new];
        
        al.nom_aliment = [resultSet stringForColumnIndex:0];
        al.nom_quantite = [resultSet stringForColumnIndex:1];
        al.id_aliment = [resultSet intForColumnIndex:2];
        NSLog(@"ingredient %@",al.nom_aliment);
        
        [ingredients addObject:al];
        
    }
    
    if ([self.database hadError]) {
        NSLog(@"Database error: %@", [self.database lastErrorMessage]);
    }
    
    [resultSet close];
    [self.database close];
    
    return ingredients;
   

}
//récupère le nom des aliments présents dans le garde-manger

- (NSArray *) getIngredientsDansFrigo{
    
    NSMutableArray *ingredients = [NSMutableArray new];
    [self.database open];
    
//   NSString *condidionIngredients = id_aliment == 0 ? @"" : [NSString stringWithFormat:@" WHERE adf.id_aliment = %d", id_aliment];
    
    NSString* query = [NSString stringWithFormat:@"SELECT aliments_dans_frigo.id_aliment, Aliments.nom_aliment ,aliments_dans_frigo.quantite,  unite_mesure.nom_unite FROM aliments_dans_frigo , Aliments , unite_mesure WHERE aliments_dans_frigo.id_aliment = Aliments.id_aliment AND Aliments.unite_mesure_aliment = unite_mesure.id_unite GROUP BY Aliments.nom_aliment;"];
    
    FMResultSet *resultSet = [self.database executeQuery:query];
    while ([resultSet next]) {
        
        Ingredients *ingredient = [Ingredients new];
        
        ingredient.id_aliment = [resultSet intForColumnIndex:0];
        ingredient.nom_aliment = [resultSet stringForColumnIndex:1];
        ingredient.nom_quantite = [resultSet stringForColumnIndex:2];
        ingredient.unite_mesure = [resultSet stringForColumnIndex:3];
    //    NSLog(@"ingredient %@",ingredient.nom_aliment);---->OK
               [ingredients addObject:ingredient];
        
    }
    
    if ([self.database hadError]) {
        NSLog(@"Database error: %@", [self.database lastErrorMessage]);
    }
    
    [resultSet close];
    [self.database close];
    
    return ingredients;

}

//récupère toutes les catégories d'aliments
-(NSArray *)getCat{
    NSMutableArray *cat = [NSMutableArray new];
    [self.database open];
    
    NSString* query = [NSString stringWithFormat:@"SELECT id_classe, classe FROM classes_aliments"];
    
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
-(int)numberOgInginTheFridge:(NSInteger)idAlim{
    int nbIngSim = 0;
    
    NSString* query = [NSString stringWithFormat:@"SELECT COUNT(adf.id_aliment) FROM aliments_dans_frigo adf WHERE adf.id_aliment = %d",idAlim];
    
    [self.database open];
    
    FMResultSet *resultSet = [self.database executeQuery:query];
    while ([resultSet next]) {
        nbIngSim = [resultSet intForColumnIndex:0];
    }
    [resultSet close];
    [self.database close];
    
    return nbIngSim;
}

// récupère les infos reliées aux ingrédients compris dans la catégorie choisie.
- (NSArray *) getIngrediantsFromCat:(int)id_cat{
    
    NSMutableArray *ingredients = [NSMutableArray new];
    [self.database open];
    
    NSString *condiIdCat = id_cat == 0 ? @"" : [NSString stringWithFormat:@" WHERE c.id_classe = %d", id_cat];
    
    NSString* query = [NSString stringWithFormat:@"SELECT a.id_aliment, a.nom_aliment, a.unite_mesure_aliment,um.nom_unite FROM Aliments a JOIN classes_aliments c ON a.classe_aliment = c.id_classe JOIN unite_mesure um ON a.unite_mesure_aliment = um.id_unite %@",condiIdCat];
    
    FMResultSet *resultSet = [self.database executeQuery:query];
    while ([resultSet next]) {
        
        Ingredients *ingredient = [Ingredients new];
        
        ingredient.id_aliment = [resultSet intForColumnIndex:0];
        ingredient.nom_aliment =[resultSet stringForColumnIndex:1];
        ingredient.id_uniteMesure = [resultSet intForColumnIndex:2];
        ingredient.unite_mesure = [resultSet stringForColumnIndex:3];
        
        
        
        [ingredients addObject:ingredient];
        
    }
    
    if ([self.database hadError]) {
        NSLog(@"Database error: %@", [self.database lastErrorMessage]);
    }
    
    [resultSet close];
    [self.database close];
    
    return ingredients;
    
}

- (NSArray*)GetRecipesByType:(NSInteger )idRecipeType{
    
    NSMutableArray *recipe = [NSMutableArray new];
    [self.database open];
    
    NSString *conId = idRecipeType == 0 ? @"" : [NSString stringWithFormat:@"  tr.id_type = %d", idRecipeType];
    
    NSString *query = [NSString stringWithFormat:@"SELECT r.id_recette, r.nom_recette, r.description_recette, nbre_couverts_recette, temps_prepa_recette,tr.type_recette  FROM recettes r JOIN  type_recettes tr ON r.type_recette = tr.id_type JOIN aliments_recette ar ON r.id_recette = ar.id_recette  WHERE %@ GROUP BY r.id_recette",conId];
    
    
    FMResultSet *resultSet = [self.database executeQuery:query];
    while ([resultSet next]) {
        
        Recipes *orederedRecipes = [Recipes new];
        
        orederedRecipes.idRecette= [resultSet intForColumnIndex:0];
        orederedRecipes.nomRecette = [resultSet stringForColumnIndex:1];
        orederedRecipes.descriptionRecette = [resultSet stringForColumnIndex:2];
        orederedRecipes.nbreCouvertsRecette= [resultSet stringForColumnIndex:3];
        orederedRecipes.tempsPrepaRecette = [resultSet stringForColumnIndex:4];
        orederedRecipes.type_recette = [resultSet stringForColumnIndex:5];
        
        
        [recipe addObject:orederedRecipes];
        
    }
    
    if ([self.database hadError]) {
        NSLog(@"Database error: %@", [self.database lastErrorMessage]);
    }
    
    [resultSet close];
    [self.database close];
    
    return recipe;
    

    
}
// enregistrer aliments dans garde-manger
-(void) setfoodInTheFridge:(NSInteger)id_aliment qnt:(NSString*)qnt id_um:(NSInteger)id_um{
  
    
    
            if((id_aliment)&&(qnt)){
                
                [self.database open];

  NSString* query = [NSString stringWithFormat:@"INSERT  INTO aliments_dans_frigo VALUES(?, ?, ?)"];
        
                if ([self.database executeUpdate:query, [NSNumber numberWithInteger:id_aliment], qnt,[NSNumber numberWithInteger:id_um]]) {
                    NSLog(@"les données sont enregistréés");
                }
                
                if ([self.database hadError]) {
                    NSLog(@"Database error: %@", [self.database lastErrorMessage]);
                }
                
        [self.database close];


    }else{
        UIAlertView *erreurAlert = [[UIAlertView alloc] initWithTitle:@"saisissez une quantité" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];

        
        [erreurAlert show];
    }
}

 //retirer aliment
    -(void)DeleteAlimentsDansFrigo:(NSInteger)id_aliment{
        
        if(id_aliment){
            
           [self.database open];
            NSString* query = [NSString stringWithFormat:@"DELETE FROM aliments_dans_frigo  WHERE id_aliment = %d",id_aliment];
            
            if ([self.database executeUpdate:query]) {
              

                FMResultSet *resultSet = [self.database executeQuery:query];
                
                if ([self.database hadError]) {
                    NSLog(@"Database error: %@", [self.database lastErrorMessage]);
                }
                  NSLog(@"les données sont annulées");
                
                [resultSet close];
                [self.database close];

            
        }
    }

    }
    



@end


