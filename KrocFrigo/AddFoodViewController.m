//
//  AddFoodViewController.m
//  KrocFrigo
//
//  Created by Andie Perrault on 21/07/2015.
//  Copyright (c) 2015 Andie Perrault. All rights reserved.
//

#import "AddFoodViewController.h"
#import "DataManager.h"
#import "Ingredients.h"
#import "catTableViewCell.h"
#import "ChoseAlimentViewController.h"

@interface AddFoodViewController (){
   
}

@property (weak, nonatomic) IBOutlet UITableView *catAlimTableView;

@end


 NSArray *category;
 NSString *selectedCat;


@implementation AddFoodViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    category = [[DataManager sharedDataManager]getCat];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
    
}

#pragma mark - TABLEVIEW
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ category count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = @"catCell";
    
    catTableViewCell *cell = (catTableViewCell*)[self.catAlimTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[catTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    

    
   
    
    Ingredients *i = [category objectAtIndex:indexPath.row];
    
    
    cell.labelCat.text = i.nom_classeAlim;
    
    [cell.labelCat setTextColor:[UIColor blackColor]];
    
    cell.imageCat.image = [UIImage  imageNamed:[NSString stringWithFormat:@"%@.jpg",i.nom_classeAlim]];

    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [self performSegueWithIdentifier:@"toChoseAliments" sender:indexPath];
  
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
    

    
    if ([segue.identifier isEqualToString:@"toChoseAliments"]) {
      
        if([sender isKindOfClass:[Ingredients class]]){
            Ingredients *aliment;
           
            if([sender isKindOfClass:[Ingredients class]]){
                aliment = (Ingredients*)sender;
            } else{
                aliment = [category objectAtIndex:((NSIndexPath*)sender).row];
                
            }
        ChoseAlimentViewController *cvc = segue.destinationViewController;
            cvc.ingr = aliment;
       
        
    }
    }
}

    
    
    


@end
