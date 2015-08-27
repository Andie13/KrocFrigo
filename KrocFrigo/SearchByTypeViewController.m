//
//  SearchByTypeViewController.m
//  KrocFrigo
//
//  Created by Andie Perrault on 27/08/2015.
//  Copyright (c) 2015 Andie Perrault. All rights reserved.
//

#import "SearchByTypeViewController.h"
#import "DataManager.h"
#import "Recipes.h"

@interface SearchByTypeViewController (){
    NSArray *listeRecipe;
    Recipes *recette;
}

@end


@implementation SearchByTypeViewController

@synthesize idType;

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"%d",idType);
    listeRecipe = [[DataManager sharedDataManager]GetRecipesByType:idType];


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

@end
