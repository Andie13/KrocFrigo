//
//  AlimChoserViewController.h
//  KrocFrigo
//
//  Created by Andie Perrault on 01/08/2015.
//  Copyright (c) 2015 Andie Perrault. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "catTableViewCell.h"

@class Ingredients;

@interface AlimChoserViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
    
    @property (nonatomic,strong) Ingredients* info;
    
@property (nonatomic, strong) UITextField *qntTxt;

    
    


@end
