//
//  AccueilCollectionViewController.m
//  KrocFrigo
//
//  Created by Andie Perrault on 08/07/2015.
//  Copyright (c) 2015 Andie Perrault. All rights reserved.
//

#import "AccueilCollectionViewController.h"
#import "DataManager.h"
#import "Recipes.h"
#import "ReciepesDetailsViewController.h"
#import "AccueilCollectionViewCell.h"
#import "SWRevealViewController.h"

@interface AccueilCollectionViewController (){
    
    __weak IBOutlet UIBarButtonItem *revealButtonItem;
    
    NSArray *collectionRecettes;
}

@end

@implementation AccueilCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customSetup];
    
    
    
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"<=" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    collectionRecettes =[[DataManager sharedDataManager]getRecepies];
    
    
}

- (void) dealloc{
    collectionRecettes = nil;
    
}
- (void)customSetup
{
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return collectionRecettes.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cellForAccueil";
    
    
    
    AccueilCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    Recipes *maRecette = [collectionRecettes objectAtIndex: indexPath.row];
    cell.imageRecette.image = [UIImage imageNamed:[NSString stringWithFormat:@"R_%d.jpg",maRecette.idRecette]];
    
    if (([maRecette.type_recette  isEqual: @"Hors d'oeuvres"])) {
        cell.imageType.image = [UIImage imageNamed:@"HO.png"];
    }
    else if (([maRecette.type_recette  isEqual: @"Plat principal"])) {
        
        cell.imageType.image = [UIImage imageNamed:@"PP.png"];
    }else if (([maRecette.type_recette  isEqual: @"Dessert"])) {
        cell.imageType.image = [UIImage imageNamed:@"D.png"];
    }else if (([maRecette.type_recette  isEqual: @"Boissons"])) {
        cell.imageType.image = [UIImage imageNamed:@"B.png"];
    }
    else if (([maRecette.type_recette  isEqual: @"Boulangerie/viennoiserie"])) {
        cell.imageType.image = [UIImage imageNamed:@"BOU.png"];
    }
    
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    Recipes *myRecipe = [collectionRecettes objectAtIndex:indexPath.row];
    
    ReciepesDetailsViewController *collVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RecetteDetails"];
    collVC.infoRecette = myRecipe;
    [self.navigationController pushViewController:collVC animated:YES];
    
}



@end