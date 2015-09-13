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


@interface SearchViewController (){
    bool isVisible;
    bool levelBtnVisible;
    NSArray *listRecettesByType;
    NSArray *listeOfRecipes;
    NSArray *listOrecipesByStock;
    NSString *level;
    
}

@property (weak, nonatomic) IBOutlet UIButton *entreeBtn;

@property (weak, nonatomic) IBOutlet UIButton *platsBtn;

@property (weak, nonatomic) IBOutlet UIButton *dessertBtn;
@property (weak, nonatomic) IBOutlet UIButton *boissonBtn;

@property (weak, nonatomic) IBOutlet UIButton *searchByStock;
@property (weak, nonatomic) IBOutlet UIButton *easyBtn;

@property (weak, nonatomic) IBOutlet UIButton *avaerageBtn;

@property (weak, nonatomic) IBOutlet UIButton *hard;



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
    
    self.easyBtn.hidden = true;
    self.avaerageBtn.hidden = true;
    self.hard.hidden = true;
    levelBtnVisible = false;
    
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

- (IBAction)searchByLevel:(id)sender {
    if (levelBtnVisible == false) {
        self.easyBtn.hidden = false;
        self.avaerageBtn.hidden = false;
        self.hard.hidden = false;
        
        levelBtnVisible = true;
    }
    else{
        self.easyBtn.hidden = true;
        self.avaerageBtn.hidden = true;
        self.hard.hidden = true;
        
        levelBtnVisible = false;
    }
    
}
- (IBAction)searchEasyAction:(id)sender {
    level = @"facile";
    listeOfRecipes = [[DataManager sharedDataManager]GetRecipesByLevel:level];
    SearchByStockViewController *sbsVc = [self.storyboard instantiateViewControllerWithIdentifier:@"searchByStock"];
    
    sbsVc.ListOfRecipesByStock = listeOfRecipes;
    [self.navigationController pushViewController:sbsVc animated:YES];
}
- (IBAction)searchAverageAction:(id)sender {
    level =@"moyen";
    listeOfRecipes = [[DataManager sharedDataManager]GetRecipesByLevel:level];
    SearchByStockViewController *sbsVc = [self.storyboard instantiateViewControllerWithIdentifier:@"searchByStock"];
    
    sbsVc.ListOfRecipesByStock = listeOfRecipes;
    [self.navigationController pushViewController:sbsVc animated:YES];
}
- (IBAction)searchHardAction:(id)sender {
    level =@"difficile";
    listeOfRecipes = [[DataManager sharedDataManager]GetRecipesByLevel:level];
    SearchByStockViewController *sbsVc = [self.storyboard instantiateViewControllerWithIdentifier:@"searchByStock"];
    
    sbsVc.ListOfRecipesByStock = listeOfRecipes;
    [self.navigationController pushViewController:sbsVc animated:YES];
}


- (IBAction)searchByStockAction:(id)sender {
    listOrecipesByStock = [[DataManager sharedDataManager]getRecipesByStock];
      
    SearchByStockViewController *sbsVc = [self.storyboard instantiateViewControllerWithIdentifier:@"searchByStock"];
    
    sbsVc.ListOfRecipesByStock = listOrecipesByStock;
    [self.navigationController pushViewController:sbsVc animated:YES];
    
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
#pragma mark - Navigation
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

@end
