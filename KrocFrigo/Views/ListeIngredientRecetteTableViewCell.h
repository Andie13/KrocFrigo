//
//  ListeIngredientRecetteTableViewCell.h
//  KrocFrigo
//
//  Created by Andie Perrault on 19/08/2015.
//  Copyright (c) 2015 Andie Perrault. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListeIngredientRecetteTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nomIngredient;

@property (weak, nonatomic) IBOutlet UILabel *qnt;
@property (weak, nonatomic) IBOutlet UIImageView *imageVal;


@end
