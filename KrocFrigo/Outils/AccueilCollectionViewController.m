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
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
        NSLog(@"je rentre là");
        cell.imageType.image = [UIImage imageNamed:@"PP.png"];
    }else if (([maRecette.type_recette  isEqual: @"Dessert"])) {
        cell.imageType.image = [UIImage imageNamed:@"D.png"];
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



#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
