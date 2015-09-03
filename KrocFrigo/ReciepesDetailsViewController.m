//
//  ReciepesDetailsViewController.m
//  KrocFrigo
//
//  Created by Andie Perrault on 11/07/2015.
//  Copyright (c) 2015 Andie Perrault. All rights reserved.
//
#import "SWRevealViewController.h"
#import "ReciepesDetailsViewController.h"
#import "Recipes.h"
#import "DataManager.h"
#import "ListeIngredientRecetteTableViewCell.h"
#import "Ingredients.h"
#import "AccueilCollectionViewController.h"

@interface ReciepesDetailsViewController (){
    NSArray *listeIngredients;
    NSInteger NBIng;
        
}


@property (weak, nonatomic) IBOutlet UIImageView *imageRecipe;
@property (weak, nonatomic) IBOutlet UITableView *listeIngredientsTableView;
@property (weak, nonatomic) IBOutlet UIImageView *typeImage;
@property (weak, nonatomic) IBOutlet UILabel *tempsPrepaLabel;
@property (weak, nonatomic) IBOutlet UILabel *nomRecette;
@property bool ncons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintIngredientView;
@property (weak, nonatomic) IBOutlet UILabel *nbreCouvertsLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ingrConstraint;
@property (weak, nonatomic) IBOutlet UITextView *descriptionRecette;
@property (weak, nonatomic) IBOutlet UIButton *ingredientBtn;
@property (weak, nonatomic) IBOutlet UIButton *prepaBtn;

@property (weak, nonatomic) IBOutlet UIImageView *recipeClassImage;

@end

@implementation ReciepesDetailsViewController

@synthesize infoRecette;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self customSetup];
    
    self.nomRecette.numberOfLines = 0;
    self.nomRecette.text = infoRecette.nomRecette;
    self.imageRecipe.image = [UIImage imageNamed:[NSString stringWithFormat:@"R_%ld.jpg",(long)infoRecette.idRecette]];
    
    self.tempsPrepaLabel.text = infoRecette.tempsPrepaRecette;
    self.nbreCouvertsLabel.text = infoRecette.nbreCouvertsRecette;
  
    if (([infoRecette.type_recette  isEqual: @"Hors d'oeuvres"])) {
        [self.prepaBtn setBackgroundColor:[UIColor colorWithRed:1/255.0 green:231/255.0 blue:204/255.0 alpha:0.6]];
        [self.ingredientBtn setBackgroundColor:[UIColor colorWithRed:1/255.0 green:231/255.0 blue:204/255.0 alpha:0.6]];
        self.typeImage.image = [UIImage imageNamed:@"HO.png"];
    }
    else if (([infoRecette.type_recette  isEqual: @"Plat principal"])) {
        [self.prepaBtn setBackgroundColor:[UIColor colorWithRed:220/255.0 green:12/255.0 blue:7/255.0 alpha:0.6]];
        [self.ingredientBtn setBackgroundColor:[UIColor colorWithRed:220/255.0 green:12/255.0 blue:7/255.0 alpha:0.6]];
        NSLog(@"je rentre là");
        self.typeImage.image = [UIImage imageNamed:@"PP.png"];
    }else if (([infoRecette.type_recette  isEqual: @"Dessert"])) {
        [self.prepaBtn setBackgroundColor:[UIColor colorWithRed:220/255.0 green:7/255.0 blue:204/255.0 alpha:0.6]];
        [self.ingredientBtn setBackgroundColor:[UIColor colorWithRed:220/255.0 green:7/255.0 blue:204/255.0 alpha:0.6]];
        self.typeImage.image = [UIImage imageNamed:@"D.png"];
        
    }else if (([infoRecette.type_recette  isEqual: @"Boissons"])) {
        [self.prepaBtn setBackgroundColor:[UIColor colorWithRed:19/255.0 green:202/255.0 blue:28/255.0 alpha:0.6]];
        [self.ingredientBtn setBackgroundColor:[UIColor colorWithRed:19/255.0 green:202/255.0 blue:28/255.0 alpha:0.6]];
        self.typeImage.image = [UIImage imageNamed:@"B.png"];
        
    }
    else if (([infoRecette.type_recette  isEqual: @"Boulangerie/viennoiserie"])) {
    [self.prepaBtn setBackgroundColor:[UIColor colorWithRed:250/255.0 green:255/255.0 blue:58/255.0 alpha:0.8]];
    [self.ingredientBtn setBackgroundColor:[UIColor colorWithRed:250/255.0 green:255/255.0 blue:58/255.0 alpha:0.8]];
    self.typeImage.image = [UIImage imageNamed:@"BOU.png"];
    }
    
    if ([infoRecette.classeRecette isEqualToString:@"cochon"]) {
        self.recipeClassImage.image = [UIImage imageNamed:@"cochon.png"];
        
    }else if([infoRecette.classeRecette isEqualToString:@"veggie"]){
        self.recipeClassImage.image = [UIImage imageNamed:@"veggie.png"];
    }else{
        self.recipeClassImage.hidden =true;
    }
    
    listeIngredients = [[DataManager sharedDataManager]getIngredientsFromRecipe:infoRecette.idRecette];
    
    
    // NSLog(@"listeingredients  %@",listeIngredients);
    
    //NSLog(@"aliment -------->>>>>>>> %@",alim.nom_aliment);
    self.tempsPrepaLabel.text = infoRecette.tempsPrepaRecette;
    self.descriptionRecette.text = infoRecette.descriptionRecette;
    
    
   // self.prepaBtn.tintColor = [UIColor colorWithRed:1 green:231 blue:204 alpha:1];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc{
    listeIngredients = nil;
    
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

#pragma tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [listeIngredients count] ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ListeIngredientRecetteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellForFood" forIndexPath:indexPath];
    
    UIFont *myFont = [ UIFont fontWithName: @"Arial" size: 18.0 ];
    cell.textLabel.font  = myFont;
    
    Ingredients *i=[listeIngredients objectAtIndex:indexPath.row];
    
    cell.nomIngredient.text = [NSString stringWithFormat:@"%@", i.nom_aliment];
    cell.qnt.text = i.nom_quantite;
    
    NBIng = [[DataManager sharedDataManager]numberOgInginTheFridge:i.id_aliment];
    if (NBIng == 0) {
        cell.imageVal.image = [UIImage imageNamed:@"nonValider.jpg"];
    }
  
    return cell;
      
}


- (IBAction)showPrepa:(id)sender {
    
    
    float constraintValue = self.constraintIngredientView.constant;
    
    NSLog(@" begin constraints %f",self.constraintIngredientView.constant);
    NSLog(@" begin ncons %d", self.ncons ? 1 : 0);
    
    NSLog(@" begin constraintValue %f",constraintValue);
    
    [self.listeIngredientsTableView layoutIfNeeded];
    
    if (constraintValue == (float)-60
        ) {
        
        NSLog(@" in if constraints  %f",self.constraintIngredientView.constant);
        
        // Close
        self.ncons = FALSE;
        NSLog(@"close");
    }else {
        // Open
        self.ncons = TRUE;
        NSLog(@"open");
    }
    
    NSLog(@" ncons %d", self.ncons ? 1 : 0);
    
    if ((self.ncons == FALSE)) {
        float newVal =  self.constraintIngredientView.constant -=373;
        self.constraintIngredientView.constant = newVal;
        self.ncons = TRUE;
    }
    else{
        NSLog(@"NON");
        float newVal =  self.constraintIngredientView.constant +=373;
        self.constraintIngredientView.constant = newVal;
        self.ncons = false;
        
    }
    
    NSLog(@" end constraints %f",self.constraintIngredientView.constant);
  
}


- (IBAction)showIngredientBtn:(id)sender {
    float constraintValue = self.ingrConstraint.constant;
    
    NSLog(@" begin constraints %f",self.ingrConstraint.constant);
    NSLog(@" begin ncons %d", self.ncons ? 1 : 0);
    
    NSLog(@" begin constraintValue %f",constraintValue);
    
    [self.listeIngredientsTableView layoutIfNeeded];
    
    if (constraintValue == (float)-121) {
        
        NSLog(@" in if constraints  %f",self.ingrConstraint.constant);
        
        // Close
        self.ncons = FALSE;
        NSLog(@"close");
    }else {
        // Open
        self.ncons = TRUE;
        NSLog(@"open");
    }
    
    NSLog(@" ncons %d", self.ncons ? 1 : 0);
    
    if ((self.ncons == FALSE)) {
        float newVal =  self.ingrConstraint.constant -=373
        ;
        self.ingrConstraint.constant = newVal;
        self.ncons = TRUE;
    }
    else{
        NSLog(@"NON");
        float newVal =  self.ingrConstraint.constant +=373
        ;
        self.ingrConstraint.constant = newVal;
        self.ncons = false;
        
    }
    
    NSLog(@" end constraints %f",self.ingrConstraint.constant);
    

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
