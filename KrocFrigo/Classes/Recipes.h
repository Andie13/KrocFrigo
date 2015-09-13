//
//  Recipes.h
//  KrocFrigo
//
//  Created by Andie Perrault on 11/07/2015.
//  Copyright (c) 2015 Andie Perrault. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recipes : NSObject

@property (nonatomic, assign) NSInteger idRecette;
@property (nonatomic, strong) NSString *nomRecette;
@property (nonatomic, strong) NSString *type_recette;
@property (nonatomic, strong) NSString * descriptionRecette;
@property (nonatomic, strong) NSString *tempsPrepaRecette;
@property (nonatomic, strong) NSString *nbreCouvertsRecette;
@property (nonatomic, strong) NSArray *ingredients;
@property (nonatomic, strong) NSString *classeRecette;


@end
