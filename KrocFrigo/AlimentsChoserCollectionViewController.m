//
//  AlimentsChoserCollectionViewController.m
//  KrocFrigo
//
//  Created by Andie Perrault on 24/07/2015.
//  Copyright (c) 2015 Andie Perrault. All rights reserved.
//

#import "AlimentsChoserCollectionViewController.h"
#import "foodCatTableViewController.h"
#import "Ingredients.h"
#import "SWRevealViewController.h"
#import "DataManager.h"
#import "AlimCollectionViewCell.h"

@interface AlimentsChoserCollectionViewController (){

}

@end

NSArray *aliments;
UIView *selAlim;


@implementation AlimentsChoserCollectionViewController

@synthesize info;



static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customSetup];
   // NSLog(@"info %@",info.id_cat);
  
 

    NSInteger id_cat = [info.id_cat integerValue];
    
     self.navigationItem.titleView = info.labelCat;
    aliments = [[DataManager sharedDataManager] getIngrediantsFromCat:id_cat];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
     [self.navigationItem setHidesBackButton:YES animated:YES];
   
    
    // Do any additional setup after loading the view.
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
    return aliments.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {


    AlimCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"alimCell" forIndexPath:indexPath];

    Ingredients *monAlim = [aliments objectAtIndex:indexPath.row];
    cell.unite_mesure = monAlim.unite_mesure;
    cell.alimLabel.text = monAlim.nom_aliment;
  //  NSLog(@"aliments %@", monAlim.nom_aliment);
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   // NSLog(@" %@",[aliments objectAtIndex:indexPath.row]);
    Ingredients *selAli= [aliments objectAtIndex:indexPath.row];
       NSLog(@"je tape");
    NSLog(@"//////// %@",selAli.unite_mesure);
    CGRect frame = CGRectMake(10, 10, 290, 300);
    selAlim =[[UIView alloc]initWithFrame:frame];
    selAlim.backgroundColor =[UIColor yellowColor];
   
   

    //
   
//    UIAlertView *selAliments = [[UIAlertView alloc] initWithTitle:@"saisissez la quantité "  message:[NSString stringWithFormat:@"%ld %@ en %@",(long)selAli.id_aliment,selAli.nom_aliment,selAli.unite_mesure ] delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"Oui, c'est bien ça", nil];
//    UILabel *um = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 45.0, 245.0, 25.0)];
//    [um setBackgroundColor:[UIColor whiteColor]];
//    
//     um.text = [NSString stringWithFormat:@"%@",selAli.unite_mesure];
//    NSLog(@"um %@",um.text);
//    
//    
//    UILabel *idAlim = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 45.0, 245.0, 25.0)];
//    [um setBackgroundColor:[UIColor whiteColor]];
//    
//    idAlim.text = [NSString stringWithFormat:@"%ld",(long)selAli.id_aliment];
//
//    
//    [selAliments addSubview:um];
//    [selAliments addSubview:idAlim];
//   
//  
// 
//    //textfield pour saisir la quantité
//    
//    selAliments.alertViewStyle = UIAlertViewStylePlainTextInput;
//    
//    UITextField *writeQnt= [selAliments textFieldAtIndex:0];
//
//    
//    assert(writeQnt);
//  
//    //keyboard numeric pour sécuriser les données entrées en base.
//    writeQnt.keyboardType = UIKeyboardTypeNumberPad;
//
//        
//       [selAliments show];
  }
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        NSString *QNT = [alertView textFieldAtIndex:0].text;
        NSLog(@"QNT SAISIE %@" ,QNT );
        
 
     
       
        NSString *newAlim = [alertView title];
    
        
        
        
  
        
        
    }
        // Insert whatever needs to be done with "name"
    
}
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
