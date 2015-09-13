//
//  DataManager.h
///  KrocFrigo
//
//  Created by Andie Perrault on 22/07/2015.
//  Copyright (c) 2015 Andie Perrault. All rights reserved.
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
- (NSArray *) getIngredientsDansFrigo;// récupère les ingrédients qui sont dans le stock
- (NSArray*)GetRecipesByType:(NSInteger )idRecipeType;// récupère les recettes par type
- (NSArray*)getCat;// récupère les catégories
-(NSArray*)getIngrediantsFromCat:(int)id_cat;//Récupère les ingrédients par catégorie
-(void)setfoodInTheFridge:(NSInteger)id_aliment qnt:(NSString*)qnt id_um:(NSInteger)id_um;//ajoute les aliments à la base
-(void)DeleteAlimentsDansFrigo:(NSInteger)id_aliment;//supprime les aliments de la base
-(NSArray*)getRecepies;//récupère toutes les recettes
- (NSArray*) getIngredientsFromRecipe :(NSInteger) idRecette;//récupère les ingrédients d'une recette
-(int)numberOgInginTheFridge:(NSInteger)idAlim;//compte le nombre d'ingrédients dans le stock
-(NSArray*) getRecipesByStock;//récupère les recettes en fonctions du stock
- (NSArray*)GetRecipesBylass:(NSString *)classeRecette;//récupère les recettes par classe
- (NSArray*)GetRecipesWithoutPork:(NSString *)classeRecette;//récupère les recettes ne contenant pas de porc
- (NSArray*)GetRecipesByLevel:(NSString*)level;//récupère les recettes d'un niveau de difficulté


@end
