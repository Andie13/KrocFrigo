//
//  SearchViewController.m
//  KrocFrigo
//
//  Created by Andie Perrault on 27/08/2015.
//  Copyright (c) 2015 Andie Perrault. All rights reserved.
//

#import "SearchViewController.h"
#import "SWRevealViewController.h"
#import "DataManager.h"
#import "Recipes.h"
#import "SearchByTypeViewController.h"
#import "SearchByStockViewController.h"
#import "SearchByClassViewController.h"

@interface SearchViewController (){
    bool isVisible;
    NSArray *listRecettesByType;
    NSArray *listeOfRecipes;
    NSArray *listOrecipesByStock;
}

@property (weak, nonatomic) IBOutlet UIButton *entreeBtn;

@property (weak, nonatomic) IBOutlet UIButton *platsBtn;

@property (weak, nonatomic) IBOutlet UIButton *dessertBtn;
@property (weak, nonatomic) IBOutlet UIButton *boissonBtn;

@property (weak, nonatomic) IBOutlet UIButton *searchByStock;

@end


@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customSetup];
    
    
    self.searchByStock.titleLabel.numberOfLines=0;
    
    
    self.entreeBtn.hidden = true;
    self.platsBtn.hidden = true;
    self.dessertBtn.hidden = true;
    self.boissonBtn.hidden= true;
    isVisible = false;
    
   }
- (IBAction)byTypeAction:(id)sender {
    if (isVisible == false) {
        self.entreeBtn.hidden = false;
        self.platsBtn.hidden = false;
        self.dessertBtn.hidden = false;
        self.boissonBtn.hidden= false;
        isVisible = true;
    }
    else{
        self.entreeBtn.hidden = true;
        self.platsBtn.hidden = true;
        self.dessertBtn.hidden = true;
        self.boissonBtn.hidden= true;
        isVisible = false;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)torecipeByTypeStarter:(id)sender {
    NSInteger recipeTypeId = 1;
    
    SearchByTypeViewController *SbtVC = [self.storyboard instantiateViewControllerWithIdentifier:@"searchByType"];
    SbtVC.idType = recipeTypeId;
      [self.navigationController pushViewController:SbtVC animated:YES];
    
}
- (IBAction)toRecipeByTypeMain:(id)sender {
     NSInteger recipeTypeId = 2;
    
    SearchByTypeViewController *SbtVC = [self.storyboard instantiateViewControllerWithIdentifier:@"searchByType"];
    SbtVC.idType = recipeTypeId;
      [self.navigationController pushViewController:SbtVC animated:YES];
   }
- (IBAction)toRecipesByTypeSweet:(id)sender {
     NSInteger recipeTypeId = 3;
    
    SearchByTypeViewController *SbtVC = [self.storyboard instantiateViewControllerWithIdentifier:@"searchByType"];
    SbtVC.idType = recipeTypeId;
      [self.navigationController pushViewController:SbtVC animated:YES];
    
}
- (IBAction)toRecipesByTypeDrink:(id)sender {
     NSInteger recipeTypeId = 4;
    
    SearchByTypeViewController *SbtVC = [self.storyboard instantiateViewControllerWithIdentifier:@"searchByType"];
    SbtVC.idType = recipeTypeId;
      [self.navigationController pushViewController:SbtVC animated:YES];
    
}
- (IBAction)searchByStockAction:(id)sender {
    listOrecipesByStock = [[DataManager sharedDataManager]getRecipesByStock];
      
    SearchByStockViewController *sbsVc = [self.storyboard instantiateViewControllerWithIdentifier:@"searchByStock"];
    
    sbsVc.ListOfRecipesByStock = listOrecipesByStock;
    [self.navigationController pushViewController:sbsVc animated:YES];
    
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

- (IBAction)withoutPorkSearch:(id)sender {
 NSString *classeRecette = @"cochon";
    listeOfRecipes = [[DataManager sharedDataManager]GetRecipesWithoutPork:classeRecette];
    
    SearchByStockViewController *sbsVc = [self.storyboard instantiateViewControllerWithIdentifier:@"searchByStock"];
    
    sbsVc.ListOfRecipesByStock = listeOfRecipes;
    [self.navigationController pushViewController:sbsVc animated:YES];
    

    
}
- (IBAction)veggieSearch:(id)sender {
    NSString *classeRecette = @"veggie";
    listeOfRecipes = [[DataManager sharedDataManager]GetRecipesBylass:classeRecette];
    
    SearchByStockViewController *sbsVc = [self.storyboard instantiateViewControllerWithIdentifier:@"searchByStock"];
    
    sbsVc.ListOfRecipesByStock = listeOfRecipes;
    [self.navigationController pushViewController:sbsVc animated:YES];
    

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
