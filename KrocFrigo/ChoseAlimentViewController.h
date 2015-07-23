//
//  ChoseAlimentViewController.h
//  KrocFrigo
//
//  Created by Andie Perrault on 23/07/2015.
//  Copyright (c) 2015 Andie Perrault. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Ingredients;
@interface ChoseAlimentViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>


@property (nonatomic, strong) Ingredients *ingr;
@end
