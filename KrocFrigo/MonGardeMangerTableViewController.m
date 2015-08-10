//
//  MonGardeMangerTableViewController.m
//  KrocFrigo
//
//  Created by Andie Perrault on 21/07/2015.
//  Copyright (c) 2015 Andie Perrault. All rights reserved.
//

#import "MonGardeMangerTableViewController.h"
#import "SWRevealViewController.h"
#import "DataManager.h"
#import "Ingredients.h"


@interface MonGardeMangerTableViewController (){
    NSArray *nbIngredientsDansFrigo;
}

@end

@implementation MonGardeMangerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customSetup];
   
    self.tableView.allowsMultipleSelectionDuringEditing =NO;
    
    nbIngredientsDansFrigo = [[DataManager sharedDataManager]getIngredientsDansFrigo];
    NSLog(@"---------->%@",nbIngredientsDansFrigo);
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [nbIngredientsDansFrigo count] ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    UIFont *myFont = [ UIFont fontWithName: @"Arial" size: 18.0 ];
    cell.textLabel.font  = myFont;
    
    Ingredients *i=[nbIngredientsDansFrigo objectAtIndex:indexPath.row];
 
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font= myFont;
    cell.textLabel.text = [NSString stringWithFormat:@"%d", i.id_aliment ];
    cell.textLabel.text =[NSString stringWithFormat:@"%@ : %@ %@", i.nom_aliment, i.nom_quantite, i.unite_mesure];
     return cell;
    
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView*)tableView editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return UITableViewCellEditingStyleDelete;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
     Ingredients *i=[nbIngredientsDansFrigo objectAtIndex:indexPath.row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"Je rentre");
        
        
        [[DataManager sharedDataManager] DeleteAlimentsDansFrigo:i.id_aliment];
        
        
       
        [ self reload];

        
    }
}


-(void)reload
{
     nbIngredientsDansFrigo = [[DataManager sharedDataManager]getIngredientsDansFrigo];
       [self.tableView reloadData]; //lstDevide étant ma tableView
}
/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
