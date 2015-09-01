//
//  SearchByTypeViewController.m
//  KrocFrigo
//
//  Created by Andie Perrault on 27/08/2015.
//  Copyright (c) 2015 Andie Perrault. All rights reserved.
//

#import "SearchByTypeViewController.h"
#import "SWRevealViewController.h"
#import "DataManager.h"
#import "Recipes.h"
#import "ShowByTypeCollectionViewCell.h"
#import "ReciepesDetailsViewController.h"


@interface SearchByTypeViewController (){
    NSArray *listeRecipe;
    Recipes *recette;
}
@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UICollectionView *recipessByTypeCollection;
@property (weak, nonatomic) IBOutlet UIImageView *imageType;


@end


@implementation SearchByTypeViewController

@synthesize idType;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customSetup];
    NSLog(@"type recette : %d",idType);
    listeRecipe = [[DataManager sharedDataManager]GetRecipesByType:idType];
    
    switch(idType){
            case 1:
             [self.recipessByTypeCollection setBackgroundColor:[UIColor colorWithRed:1/255.0 green:231/255.0 blue:204/255.0 alpha:0.6]];
             [self.backgroundView setBackgroundColor:[UIColor colorWithRed:1/255.0 green:231/255.0 blue:204/255.0 alpha:0.6]];
           self.imageType.image = [UIImage imageNamed:@"HO.png"];
            break;
            case 2: 
            [self.recipessByTypeCollection setBackgroundColor:[UIColor colorWithRed:220/255.0 green:12/255.0 blue:7/255.0 alpha:0.6]];
            [self.backgroundView setBackgroundColor:[UIColor colorWithRed:220/255.0 green:12/255.0 blue:7/255.0 alpha:0.6]];
            self.imageType.image = [UIImage imageNamed:@"PP.png"];
            break;
            case 3:
             NSLog(@"je vois que ce sont des desserts");
            [self.recipessByTypeCollection setBackgroundColor:[UIColor colorWithRed:220/255.0 green:7/255.0 blue:204/255.0 alpha:0.6]];
            [self.backgroundView setBackgroundColor:[UIColor colorWithRed:220/255.0 green:7/255.0 blue:204/255.0 alpha:0.6]];

            self.imageType.image = [UIImage imageNamed:@"D.png"];
            break;
            case 4:
             [self.recipessByTypeCollection setBackgroundColor:[UIColor colorWithRed:19/255.0 green:202/255.0 blue:28/255.0 alpha:0.6]];
            [self.backgroundView setBackgroundColor:[UIColor colorWithRed:19/255.0 green:202/255.0 blue:28/255.0 alpha:0.6]];
            self.imageType.image = [UIImage imageNamed:@"B.png"];
            break;
            default:
            [self.recipessByTypeCollection setBackgroundColor:[UIColor blackColor]];
            break;


            
    }

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
    
    return listeRecipe.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cellForRecipeByType";
    
    
    
    ShowByTypeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    Recipes *maRecette = [listeRecipe objectAtIndex: indexPath.row];
    cell.imageRecipe.image = [UIImage imageNamed:[NSString stringWithFormat:@"R_%d.jpg",maRecette.idRecette]];
    cell.nameRecipe.numberOfLines = 0;
    cell.nameRecipe.text = maRecette.nomRecette;
    
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    
   Recipes *myRecipe = [listeRecipe objectAtIndex:indexPath.row];
//    
   ReciepesDetailsViewController *collVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RecetteDetails"];
    collVC.infoRecette = myRecipe;
    [self.navigationController pushViewController:collVC animated:YES];
   
}
//



@end
