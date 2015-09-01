//
//  SearchByTypeViewController.h
//  KrocFrigo
//
//  Created by Andie Perrault on 27/08/2015.
//  Copyright (c) 2015 Andie Perrault. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipes.h"

@class Recipes;
@interface SearchByTypeViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, assign) NSInteger idType;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;


@end
