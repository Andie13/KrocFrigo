//
//  AlimentsChoserCollectionViewController.h
//  KrocFrigo
//
//  Created by Andie Perrault on 24/07/2015.
//  Copyright (c) 2015 Andie Perrault. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "catTableViewCell.h"

@class Ingredients;

@interface AlimentsChoserCollectionViewController : UICollectionViewController
    
@property (nonatomic,strong) catTableViewCell* info;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;



@end
