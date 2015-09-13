//
//  SearchByStockViewController.m
//  KrocFrigo
//
//  Created by Andie Perrault on 02/09/2015.
//  Copyright (c) 2015 Andie Perrault. All rights reserved.
//

#import "SearchByStockViewController.h"
#import "Recipes.h"
#import "SWRevealViewController.h"
#import "DataManager.h"
#import "ShowByTypeCollectionViewCell.h"
#import "ReciepesDetailsViewController.h"

@interface SearchByStockViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *showByStockCollection;

@end

@implementation SearchByStockViewController

@synthesize ListOfRecipesByStock;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customSetup];
    
    
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return ListOfRecipesByStock.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cellForRecipeByType";
    
    
    
    ShowByTypeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    Recipes *maRecette = [ListOfRecipesByStock objectAtIndex: indexPath.row];
  //  NSLog(@"ma recette %@",maRecette.nomRecette);
    cell.imageRecipe.image = [UIImage imageNamed:[NSString stringWithFormat:@"R_%ld.jpg",(long)maRecette.idRecette]];
    cell.nameRecipe.numberOfLines = 0;
    cell.nameRecipe.text = maRecette.nomRecette;
    
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    Recipes *myRecipe = [ListOfRecipesByStock objectAtIndex:indexPath.row];
    
    ReciepesDetailsViewController *collVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RecetteDetails"];
    collVC.infoRecette = myRecipe;
    [self.navigationController pushViewController:collVC animated:YES];
    
}



@end
