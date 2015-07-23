//
//  ChoseAlimentViewController.m
//  KrocFrigo
//
//  Created by Andie Perrault on 23/07/2015.
//  Copyright (c) 2015 Andie Perrault. All rights reserved.
//

#import "ChoseAlimentViewController.h"
#import "DataManager.h"
#import "Ingredients.h"
#import "AlimCollectionViewCell.h"
#import "AddFoodViewController.h"

@interface ChoseAlimentViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collOfAliments;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;




@end

NSArray *listIngr ;




@implementation ChoseAlimentViewController
@synthesize ingr;




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLable.text =ingr.nom_classeAlim;
    
    NSLog(@"title %@",ingr.nom_classeAlim);
    
    
        
    ;
    
   
    NSLog(@"ingr %@",listIngr);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return listIngr.count  ;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    
      
    AlimCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
     Ingredients *i = [listIngr objectAtIndex:indexPath.row];
    cell.alimentsLab.text = i.nom_aliment;
   
    
     return cell;
}


- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
