//
//  foodCatTableViewController.m
//  KrocFrigo
//
//  Created by Andie Perrault on 23/07/2015.
//  Copyright (c) 2015 Andie Perrault. All rights reserved.
//

#import "foodCatTableViewController.h"
#import "DataManager.h"
#import "Ingredients.h"
#import "catTableViewCell.h"
#import "AlimCollectionViewCell.h"
#import "AlimChoserViewController.h"



@interface foodCatTableViewController ()

@end

 NSArray *category;

@implementation foodCatTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    category = [[DataManager sharedDataManager]getCat];
    
;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc{
    category = nil;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
      return [ category count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
      NSString *cellIdentifier = @"catCell";
    catTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[catTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
    }
    

    
    Ingredients *i = [category objectAtIndex:indexPath.row];
   
    cell.labelCat.text = i.nom_classeAlim;
   // cell.id_cat.text = [NSString stringWithFormat:@"%ld",(long)i.id_cat];
    
    NSString *idCat = [NSString stringWithFormat:@"%ld",(long)i.id_cat];
    cell.id_cat = idCat;
    
    [cell.labelCat setTextColor:[UIColor blackColor]];
    cell.imageCat.image
    = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", i.nom_classeAlim]];
    
    

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
// [self performSegueWithIdentifier:@"toAlimentChoser" sender:indexPath];
    
 }


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"je suis la");
    
    if ([[segue identifier] isEqualToString:@"toAlimentChoser"]) {
        //Ingredients *cat;
        
       // cat = (Ingredients *)sender;
        
        
      //  NSLog(@"ici aussi  cat %@",cat);
               AlimChoserViewController *alim = [segue destinationViewController];
        alim.info = sender;
    
    }
  }



@end
