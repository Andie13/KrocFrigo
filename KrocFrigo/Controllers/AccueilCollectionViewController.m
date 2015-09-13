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
    //menu
      [self customSetup];

    //test sur btn retour
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"<=" style:UIBarButtonItemStylePlain target:nil action:nil];
//    
//Gets recipes from db randomly like
    collectionRecettes =[[DataManager sharedDataManager]getRecepies];

}
// release adresses when usednecessary from iOS7 or later.Need to do it on every strog values
- (void) dealloc{
    collectionRecettes = nil;
}
//menu
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


- (NSInteger)collctionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return collectionRecettes.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cellForAccueil";
    
 
//use view AccueilCollectionViewCell
    AccueilCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    Recipes *maRecette = [collectionRecettes objectAtIndex: indexPath.row];
    cell.imageRecette.image = [UIImage imageNamed:[NSString stringWithFormat:@"R_%ld.jpg",(long)maRecette.idRecette]];
 
    //contition on recipe type displays the right image
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

#pragma mark delegates
//navigation on tap
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  
    
    Recipes *myRecipe = [collectionRecettes objectAtIndex:indexPath.row];
    
        ReciepesDetailsViewController *collVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RecetteDetails"];
        collVC.infoRecette = myRecipe;
        [self.navigationController pushViewController:collVC animated:YES];
    
}



@end
