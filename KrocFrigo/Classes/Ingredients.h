//
//  Ingredients.h
//  KrocFrigo
//
//  Created by Andie Perrault on 12/07/2015.
//  Copyright (c) 2015 Andie Perrault. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ingredients : NSObject{
    NSInteger id_aliment;
    NSString *nom_classeAlim;
    NSString *nom_aliment;
    NSInteger id_cat;
    NSInteger id_uniteMesure;
    NSString *nom_quantite;// quantite int ex: 100
    NSString *unite_mesure;// mesure str ex: grammes

}
@property (nonatomic, assign) NSInteger id_aliment;
@property (nonatomic, strong) NSString *nom_classeAlim;

@property (nonatomic, strong) NSString *nom_aliment;
@property (nonatomic,assign)NSInteger id_cat;
@property (nonatomic,assign) NSInteger id_uniteMesure;
@property (nonatomic, strong) NSString* nom_quantite;
@property (nonatomic, strong) NSString *unite_mesure;



@end
