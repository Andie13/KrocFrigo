//
//  SearchByStockViewController.h
//  KrocFrigo
//
//  Created by Andie Perrault on 02/09/2015.
//  Copyright (c) 2015 Andie Perrault. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Recipes;

@interface SearchByStockViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;

@property(nonatomic, strong) NSArray *ListOfRecipesByStock;

@end
