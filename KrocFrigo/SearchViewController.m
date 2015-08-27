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

@interface SearchViewController (){
    bool isVisible;
    NSArray *listRecettesByType;
}

@property (weak, nonatomic) IBOutlet UIButton *entreeBtn;

@property (weak, nonatomic) IBOutlet UIButton *platsBtn;


@property (weak, nonatomic) IBOutlet UIButton *dessertBtn;
@property (weak, nonatomic) IBOutlet UIButton *boissonBtn;


@end


@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customSetup];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
