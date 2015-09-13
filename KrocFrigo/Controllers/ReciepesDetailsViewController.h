//
//  ReciepesDetailsViewController.h
//  KrocFrigo
//
//  Created by Andie Perrault on 11/07/2015.
//  Copyright (c) 2015 Andie Perrault. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Recipes;
@class Ingredients;

@interface ReciepesDetailsViewController : UIViewController<UITabBarControllerDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;


@property (nonatomic, strong) Recipes *infoRecette;
@end
